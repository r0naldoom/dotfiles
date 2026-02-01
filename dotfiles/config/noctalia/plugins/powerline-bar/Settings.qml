import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root

  property var pluginApi: null

  spacing: Style.marginL
  Layout.fillWidth: true

  // Called by NPluginSettingsPopup when "Apply" button is clicked
  function saveSettings() {
    if (pluginApi) {
      pluginApi.pluginSettings.powerlineWidgets = powerlineToggle.checked
      pluginApi.pluginSettings.powerlineSize = sizeSpinBox.value
      pluginApi.pluginSettings.showLogo = logoToggle.checked
      pluginApi.pluginSettings.showLayout = layoutToggle.checked
      pluginApi.pluginSettings.showWorkspaces = workspacesToggle.checked
      pluginApi.pluginSettings.showClock = clockToggle.checked
      pluginApi.saveSettings()

      // Sync powerline to global setting
      Settings.data.ui.powerlineStyle = powerlineToggle.checked
      Settings.saveImmediate()
    }
  }

  // Initialize values after component is created
  Component.onCompleted: {
    if (pluginApi && pluginApi.pluginSettings) {
      powerlineToggle.checked = pluginApi.pluginSettings.powerlineWidgets ?? false
      sizeSpinBox.value = pluginApi.pluginSettings.powerlineSize ?? 15
      logoToggle.checked = pluginApi.pluginSettings.showLogo ?? true
      layoutToggle.checked = pluginApi.pluginSettings.showLayout ?? true
      workspacesToggle.checked = pluginApi.pluginSettings.showWorkspaces ?? true
      clockToggle.checked = pluginApi.pluginSettings.showClock ?? true
    }
  }

  // ══════════════════════════════════════════════════════════════════
  // WIDGET STYLE SECTION
  // ══════════════════════════════════════════════════════════════════
  NHeader {
    label: "Estilo dos Widgets"
  }

  NToggle {
    id: powerlineToggle
    label: "Powerline nos Widgets"
    description: "Ativar triângulos powerline em todos os widgets"
    Layout.fillWidth: true
    onToggled: newValue => {
      checked = newValue
      if (pluginApi) {
        pluginApi.pluginSettings.powerlineWidgets = newValue
        pluginApi.saveSettings()
        Settings.data.ui.powerlineStyle = newValue
        Settings.saveImmediate()
      }
    }
  }

  NSpinBox {
    id: sizeSpinBox
    label: "Tamanho do Separador"
    description: "Tamanho dos triângulos powerline em pixels"
    from: 8
    to: 30
    stepSize: 1
    suffix: "px"
    Layout.fillWidth: true
    onValueChanged: {
      if (pluginApi && pluginApi.pluginSettings) {
        pluginApi.pluginSettings.powerlineSize = value
        pluginApi.saveSettings()
      }
    }
  }

  NDivider { Layout.fillWidth: true }

  // ══════════════════════════════════════════════════════════════════
  // BAR COMPONENTS SECTION
  // ══════════════════════════════════════════════════════════════════
  NHeader {
    label: "Componentes da Barra"
  }

  NToggle {
    id: logoToggle
    label: "Mostrar Logo"
    description: "Exibir logo da distribuição na barra"
    Layout.fillWidth: true
    onToggled: newValue => {
      checked = newValue
      if (pluginApi) {
        pluginApi.pluginSettings.showLogo = newValue
        pluginApi.saveSettings()
      }
    }
  }

  NToggle {
    id: layoutToggle
    label: "Mostrar Layout"
    description: "Exibir indicador de layout de janelas"
    Layout.fillWidth: true
    onToggled: newValue => {
      checked = newValue
      if (pluginApi) {
        pluginApi.pluginSettings.showLayout = newValue
        pluginApi.saveSettings()
      }
    }
  }

  NToggle {
    id: workspacesToggle
    label: "Mostrar Workspaces"
    description: "Exibir indicadores de workspace"
    Layout.fillWidth: true
    onToggled: newValue => {
      checked = newValue
      if (pluginApi) {
        pluginApi.pluginSettings.showWorkspaces = newValue
        pluginApi.saveSettings()
      }
    }
  }

  NToggle {
    id: clockToggle
    label: "Mostrar Relógio"
    description: "Exibir data e hora na barra"
    Layout.fillWidth: true
    onToggled: newValue => {
      checked = newValue
      if (pluginApi) {
        pluginApi.pluginSettings.showClock = newValue
        pluginApi.saveSettings()
      }
    }
  }

  NDivider { Layout.fillWidth: true }

  // ══════════════════════════════════════════════════════════════════
  // QUICK APPS SECTION
  // ══════════════════════════════════════════════════════════════════
  NHeader {
    label: "Apps Rápidos"
    description: "Aplicativos na linha de acesso rápido do Control Center"
  }

  NText {
    text: {
      var apps = pluginApi?.pluginSettings?.quickApps ?? []
      if (apps.length === 0) return "Nenhum app configurado"
      var names = []
      for (var i = 0; i < apps.length; i++) {
        names.push(apps[i].tooltip || apps[i].command)
      }
      return names.join(" • ")
    }
    color: Color.mOnSurfaceVariant
    pointSize: Style.fontSizeS
    wrapMode: Text.WordWrap
    Layout.fillWidth: true
  }

  Item { Layout.fillHeight: true }
}
