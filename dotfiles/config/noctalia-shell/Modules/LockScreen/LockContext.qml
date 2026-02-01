import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam
import qs.Commons
import qs.Services.System

Scope {
  id: root
  signal unlocked
  signal failed

  property string currentText: ""
  property bool waitingForPassword: false
  property bool unlockInProgress: false
  property bool showFailure: false
  property bool showInfo: false
  property string errorMessage: ""
  property string infoMessage: ""
  property bool pamAvailable: typeof PamContext !== "undefined"
  property bool fprintdAvailable: false

  readonly property string pamConfigDirectory: Quickshell.env("NOCTALIA_PAM_CONFIG") ? "/etc/pam.d" : Settings.configDir + "pam"
  readonly property string pamConfig: Quickshell.env("NOCTALIA_PAM_CONFIG") || "password.conf"

  Component.onCompleted: {
    checkFprintdProc.running = true;

    if (Quickshell.env("NOCTALIA_PAM_CONFIG")) {
      Logger.i("LockContext", "NOCTALIA_PAM_CONFIG is set, using system PAM config: /etc/pam.d/" + pamConfig);
    } else {
      Logger.i("LockContext", "Using generated PAM config:", pamConfigDirectory + "/" + pamConfig);
    }
  }

  onCurrentTextChanged: {
    if (currentText !== "") {
      showInfo = false;
      infoMessage = "";
      showFailure = false;
      errorMessage = "";
      if (!waitingForPassword) {
        pam.abort();
      }
      if (fprintdAvailable) {
        occupyFingerprintSensorProc.running = true;
      }
    } else {
      occupyFingerprintSensorProc.running = false;
      pam.start();
    }
  }

  function tryUnlock() {
    if (!pamAvailable) {
      errorMessage = "PAM not available";
      showFailure = true;
      return;
    }

    if (waitingForPassword) {
      pam.respond(currentText);
      unlockInProgress = true;
      waitingForPassword = false;
      showInfo = false;
      return;
    }

    errorMessage = "";
    showFailure = false;

    Logger.i("LockContext", "Starting PAM authentication for user:", pam.user);
    pam.start();
  }

  Process {
    id: checkFprintdProc
    command: ["sh", "-c", "command -v fprintd-verify"]
    onExited: function (exitCode) {
      fprintdAvailable = (exitCode === 0);
    }
  }

  Process {
    id: occupyFingerprintSensorProc
    command: ["fprintd-verify"]
  }

  PamContext {
    id: pam
    configDirectory: root.pamConfigDirectory
    config: root.pamConfig
    user: HostService.username

    onPamMessage: {
      Logger.i("LockContext", "PAM message:", message, "isError:", messageIsError, "responseRequired:", responseRequired);

      if (messageIsError) {
        errorMessage = message;
      } else {
        infoMessage = message;
      }

      if (this.responseRequired) {
        Logger.i("LockContext", "Responding to PAM with password");
        if (root.currentText !== "") {
          this.respond(root.currentText);
        } else {
          root.waitingForPassword = true;
          showFailure = false;
          infoMessage = I18n.tr("lock-screen.password");
          showInfo = true;
        }
      } else if (messageIsError) {
        showInfo = false;
        showFailure = true;
      } else {
        showFailure = false;
        showInfo = true;
      }
    }

    onCompleted: result => {
                   Logger.i("LockContext", "PAM completed with result:", result);
                   if (result === PamResult.Success) {
                     Logger.i("LockContext", "Authentication successful");
                     root.unlocked();
                   } else {
                     Logger.i("LockContext", "Authentication failed");
                     root.currentText = "";
                     errorMessage = I18n.tr("authentication.failed");
                     showFailure = true;
                     root.failed();
                   }
                   root.unlockInProgress = false;
                 }

    onError: {
      Logger.i("LockContext", "PAM error:", error, "message:", message);
      errorMessage = message || "Authentication error";
      showFailure = true;
      root.unlockInProgress = false;
      root.failed();
    }
  }
}
