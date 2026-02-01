#!/usr/bin/env python3
import sys
import time
import subprocess
import pty
import os
import select
import errno


def log(msg):
    sys.stderr.write(f"[bluetooth-connect] {msg}\n")


def main():
    if len(sys.argv) < 5:
        log("Usage: bluetooth-connect.py <addr> <pairWaitSeconds> <attempts> <intervalSec>")
        sys.exit(2)

    addr = sys.argv[1]
    # We won't use pair_wait_seconds in the same way, but we'll respect the timeout logic.
    pair_wait_seconds = float(sys.argv[2])
    if pair_wait_seconds < 15:
        log(f"Warning: pairWaitSeconds ({pair_wait_seconds}) is too short. Enforcing 15s minimum.")
        pair_wait_seconds = 15.0

    attempts = int(sys.argv[3])
    interval_sec = float(sys.argv[4])

    if not addr or len(addr) < 17:
        # Basic MAC address length check
        log(f"Invalid Bluetooth address: '{addr}'")
        sys.exit(2)

    # Master/Slave PTY for interactive control
    master_fd, slave_fd = pty.openpty()

    # Start bluetoothctl
    proc = subprocess.Popen(['bluetoothctl'], stdin=slave_fd, stdout=slave_fd, stderr=slave_fd, close_fds=True, text=True)

    os.close(slave_fd)

    def send_command(cmd):
        log(f"Sending: {cmd}")
        os.write(master_fd, (cmd + "\n").encode('utf-8'))

    def read_output(timeout=1.0):
        # Reads available output from master_fd
        output = b""
        end_time = time.time() + timeout
        while time.time() < end_time:
            r, _, _ = select.select([master_fd], [], [], 0.1)
            if master_fd in r:
                try:
                    data = os.read(master_fd, 1024)
                    if not data:
                        break
                    output += data
                except OSError as e:
                    if e.errno == errno.EIO:
                        break
                    raise
            else:
                pass
        return output.decode('utf-8', errors='replace')

    log("Initializing bluetoothctl...")
    time.sleep(1)  # Wait for startup
    initial_out = read_output(timeout=1)
    # print(initial_out) # Debug

    send_command("agent on")
    send_command("default-agent")
    send_command("power on")
    time.sleep(1)

    # Clean start
    log(f"Removing {addr} to start fresh...")
    send_command(f"remove {addr}")
    time.sleep(2)

    # Scan and wait for discovery
    log("Scanning for device (30s timeout)...")
    send_command("scan on")
    found = False
    scan_start = time.time()
    while time.time() - scan_start < 30:  # Wait up to 30s to find it
        out = read_output(timeout=0.5)
        if out:
            print(out, end='')
            # Split lines to handle mixed output safely
            for line in out.splitlines():
                if addr in line:
                    if "[DEL]" in line:
                        continue
                    if "[NEW]" in line or "[CHG]" in line:
                        if "not available" not in line:
                            log(f"Device {addr} discovered!")
                            found = True
                            break
            if found:
                break

    if not found:
        log("Device not found in scan. Trying to pair anyway...")

    # Pair
    send_command(f"pair {addr}")

    # Loop to watch for confirmation or success
    start_time = time.time()
    paired = False

    log("Waiting for pairing logic...")
    while time.time() - start_time < pair_wait_seconds:
        out = read_output(timeout=0.5)
        if out:
            print(out, end='')
            # Numberic Comparison (NC) 1 of 4 - Tested pairing with my iPhone.
            if "Confirm passkey" in out or "yes/no" in out or "Request confirmation" in out:
                log("Detected passkey prompt. Sending 'yes'.")
                send_command("yes")

            # Authorization Request
            if "Authorize service" in out or "Request authorization" in out:
                log("Detected authorization request. Sending 'yes'.")
                send_command("yes")

            # Passkey Display (User needs to type this on the remote device, e.g. Keyboard)
            if "Passkey:" in out:
                for line in out.splitlines():
                    if "Passkey:" in line:
                        log(f"ACTION REQUIRED: {line.strip()} (Type this on the device)")

            # Interactive PIN/Passkey Entry (Device displays code, User must enter on PC)
            if "Enter passkey" in out or "Enter PIN code" in out:
                log("Device requested PIN/Passkey. Waiting for user input...")
                print("[PIN_REQ]")
                sys.stdout.flush()
                
                try:
                    # Read PIN from stdin (blocking)
                    user_pin = sys.stdin.readline().strip()
                    if user_pin:
                        log(f"Sending PIN: {user_pin}")
                        send_command(user_pin)
                    else:
                        log("Empty PIN received. Aborting.")
                        break
                except Exception as e:
                    log(f"Error reading stdin: {e}")
                    break

            # Just Works (JW) is implicit (no prompt)

            if "Pairing successful" in out or "Paired: yes" in out or "Bonded: yes" in out:
                paired = True
                log("Pairing successful detected in stream.")
                break

            if "Failed to pair" in out:
                log("Pairing failed explicitly.")
                break

            if "Already joined" in out or "Already exists" in out:
                paired = True
                log("Device already paired.")
                break

    # Double check pairing status via info command if not sure
    if not paired:
        send_command(f"info {addr}")
        time.sleep(1)
        out = read_output(timeout=1)
        if "Paired: yes" in out:
            paired = True

    if paired:
        log("Device is paired. Trusting...")
        send_command(f"trust {addr}")
        time.sleep(1)

        log("Connecting...")
        connected = False
        for i in range(attempts):
            send_command(f"connect {addr}")
            # Wait a bit for connection
            time.sleep(interval_sec)

            # Check status
            send_command(f"info {addr}")
            time.sleep(1)
            out = read_output(timeout=1)
            if "Connected: yes" in out:
                log("Connected successfully.")
                connected = True
                break
            else:
                log(f"Connection attempt {i + 1}/{attempts} failed. Retrying...")

        if connected:
            send_command("quit")
            sys.exit(0)
        else:
            log("Failed to connect after all attempts.")
            send_command("quit")
            sys.exit(1)

    else:
        log("Failed to pair within timeout.")
        send_command("quit")
        sys.exit(1)


if __name__ == "__main__":
    main()
