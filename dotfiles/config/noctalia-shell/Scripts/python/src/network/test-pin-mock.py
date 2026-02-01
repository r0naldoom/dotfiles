#!/usr/bin/env python3
import sys
import time

print("Mocking Bluetooth Pairing...", flush=True)
time.sleep(1)

print("Simulating PIN request from device...", flush=True)
print("[PIN_REQ]", flush=True)

try:
    print("Waiting for PIN input...", flush=True)
    pin = sys.stdin.readline().strip()

    with open("/tmp/pin_test.log", "w") as f:
        f.write(f"SUCCESS: Received PIN from UI: '{pin}'\n")

    print(f"Received PIN: {pin}", flush=True)
    time.sleep(1)

    print("Pairing successful", flush=True)
    print("Connected successfully.", flush=True)
    sys.exit(0)

except Exception as e:
    with open("/tmp/pin_test_error.log", "w") as f:
        f.write(f"ERROR: {e}\n")
    sys.exit(1)
