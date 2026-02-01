pragma Singleton

import QtQuick
import Quickshell
import qs.Commons

Singleton {
  id: root

  // Track if the settings window is open
  property bool isWindowOpen: false

  // Reference to the window (set by SettingsPanelWindow)
  property var settingsWindow: null

  // Requested tab when opening
  property int requestedTab: 0

  signal windowOpened
  signal windowClosed

  function openWindow(tab) {
    requestedTab = tab !== undefined ? tab : 0;
    if (settingsWindow) {
      settingsWindow.visible = true;
      isWindowOpen = true;
      windowOpened();
    }
  }

  function closeWindow() {
    if (settingsWindow) {
      settingsWindow.visible = false;
      isWindowOpen = false;
      windowClosed();
    }
  }

  function toggleWindow(tab) {
    if (isWindowOpen) {
      closeWindow();
    } else {
      openWindow(tab);
    }
  }
}
