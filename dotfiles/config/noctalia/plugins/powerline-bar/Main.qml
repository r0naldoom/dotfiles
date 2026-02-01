import QtQuick
import Quickshell
import qs.Commons

// Main entry point - syncs powerline setting on load
Singleton {
  id: root

  property var pluginApi: null

  Component.onCompleted: {

    // Sync powerline widget setting with global Settings
    if (pluginApi && pluginApi.pluginSettings) {
      var enabled = pluginApi.pluginSettings.powerlineWidgets
      if (enabled === undefined) {
        // First run - read from global setting
        enabled = Settings.data.ui.powerlineStyle ?? false
        pluginApi.pluginSettings.powerlineWidgets = enabled
        pluginApi.saveSettings()
      }

      // Apply to global setting
      Settings.data.ui.powerlineStyle = enabled
      console.log("[Powerline Suite] Powerline widgets:", enabled ? "enabled" : "disabled")
    }
  }
}
