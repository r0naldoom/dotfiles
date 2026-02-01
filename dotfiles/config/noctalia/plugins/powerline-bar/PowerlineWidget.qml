import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons
import qs.Services.UI
import qs.Widgets

// Powerline-style bar widget
Rectangle {
  id: root

  // Required Noctalia properties
  property var pluginApi: null
  property ShellScreen screen
  property string widgetId: ""
  property string section: ""

  // Settings from plugin
  readonly property int powerlineSize: pluginApi?.pluginSettings?.powerlineSize ?? 15
  readonly property int barPadding: 12
  readonly property bool showLogo: pluginApi?.pluginSettings?.showLogo ?? true
  readonly property bool showLayout: pluginApi?.pluginSettings?.showLayout ?? true
  readonly property bool showWorkspaces: pluginApi?.pluginSettings?.showWorkspaces ?? true
  readonly property bool showClock: pluginApi?.pluginSettings?.showClock ?? true

  // Theme colors
  readonly property color bg: Color.mSurface
  readonly property color bgAlt: Color.mSurfaceVariant
  readonly property color bgHighlight: Color.mOutline
  readonly property color fg: Color.mOnSurface
  readonly property color fgDim: Color.mOnSurfaceVariant
  readonly property color accent: Color.mPrimary

  // Section colors
  readonly property color sectionLogo: bgAlt
  readonly property color sectionLayout: bgHighlight
  readonly property color sectionSpacer: bg
  readonly property color sectionGroups: bgAlt
  readonly property color sectionClock: bgAlt

  // Monitor and workspace tracking
  readonly property var monitor: Hyprland.focusedMonitor
  readonly property int activeWorkspaceId: monitor?.activeWorkspace?.id ?? 1
  readonly property int workspacesShown: 6
  readonly property var workspaceIcons: ["󰼏", "󰼐", "󰼑", "󰼒", "󰼓", "󰼔"]

  // Fill entire bar width
  implicitWidth: screen?.width ?? 1920
  implicitHeight: Style.barHeight
  color: "transparent"

  // Check if workspace has windows
  function isWorkspaceOccupied(wsId) {
    return Hyprland.workspaces.values.some(ws => ws.id === wsId)
  }

  RowLayout {
    id: content
    anchors.fill: parent
    spacing: 0

    // === LEFT PADDING ===
    Rectangle {
      visible: root.showLogo
      Layout.fillHeight: true
      Layout.preferredWidth: 5
      color: logoMouse.containsMouse ? root.accent : root.sectionLogo
      Behavior on color { ColorAnimation { duration: 150 } }
    }

    Rectangle {
      visible: !root.showLogo && root.showLayout
      Layout.fillHeight: true
      Layout.preferredWidth: 5
      color: root.sectionLayout
    }

    Rectangle {
      visible: !root.showLogo && !root.showLayout
      Layout.fillHeight: true
      Layout.preferredWidth: 5
      color: root.sectionSpacer
    }

    // === LOGO SECTION ===
    Rectangle {
      visible: root.showLogo
      Layout.fillHeight: true
      Layout.preferredWidth: logoText.implicitWidth + root.barPadding * 2
      color: logoMouse.containsMouse ? root.accent : root.sectionLogo

      Behavior on color { ColorAnimation { duration: 150 } }

      Text {
        id: logoText
        anchors.centerIn: parent
        text: "󰣇"
        color: logoMouse.containsMouse ? root.bg : root.fg
        font.family: "Symbols Nerd Font"
        font.pixelSize: 18

        Behavior on color { ColorAnimation { duration: 150 } }
      }

      MouseArea {
        id: logoMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
          var launcher = PanelService.getPanel("launcherPanel", root.screen)
          if (launcher) launcher.open()
        }
      }
    }

    // Separator: Logo -> Layout
    PowerlineSep {
      visible: root.showLogo && root.showLayout
      Layout.fillHeight: true
      colorLeft: logoMouse.containsMouse ? root.accent : root.sectionLogo
      colorRight: root.sectionLayout
      sepWidth: root.powerlineSize
      direction: "forward"
    }

    // Separator: Logo -> Spacer
    PowerlineSep {
      visible: root.showLogo && !root.showLayout
      Layout.fillHeight: true
      colorLeft: logoMouse.containsMouse ? root.accent : root.sectionLogo
      colorRight: root.sectionSpacer
      sepWidth: root.powerlineSize
      direction: "forward"
    }

    // === LAYOUT SECTION ===
    Rectangle {
      visible: root.showLayout
      Layout.fillHeight: true
      Layout.preferredWidth: layoutRow.implicitWidth + root.barPadding * 2
      color: root.sectionLayout

      Row {
        id: layoutRow
        anchors.centerIn: parent
        spacing: 6

        Text {
          text: "󰕘"
          color: root.fg
          font.family: "Symbols Nerd Font"
          font.pixelSize: 18
          anchors.verticalCenter: parent.verticalCenter
        }

        Text {
          text: "Tiling"
          color: root.fg
          font.family: "JetBrainsMono Nerd Font"
          font.pixelSize: 14
          anchors.verticalCenter: parent.verticalCenter
        }
      }
    }

    // Separator: Layout -> Spacer
    PowerlineSep {
      visible: root.showLayout
      Layout.fillHeight: true
      colorLeft: root.sectionLayout
      colorRight: root.sectionSpacer
      sepWidth: root.powerlineSize
      direction: "forward"
    }

    // === SPACER LEFT ===
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      color: root.sectionSpacer
    }

    // Separator: Spacer -> Groups
    PowerlineSep {
      visible: root.showWorkspaces
      Layout.fillHeight: true
      colorLeft: root.sectionSpacer
      colorRight: root.sectionGroups
      sepWidth: root.powerlineSize
      direction: "forward"
    }

    // === WORKSPACES SECTION ===
    Rectangle {
      visible: root.showWorkspaces
      Layout.fillHeight: true
      Layout.preferredWidth: workspaceRow.implicitWidth + root.barPadding * 2
      color: root.sectionGroups

      Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 5

        Repeater {
          model: root.workspacesShown

          Item {
            id: wsItem
            property int wsId: index + 1
            property bool isActive: root.activeWorkspaceId === wsId
            property bool isOccupied: root.isWorkspaceOccupied(wsId)

            width: wsText.implicitWidth + 12
            height: wsText.implicitHeight + 8

            Rectangle {
              anchors.fill: parent
              radius: 4
              color: wsItem.isActive ? root.bgHighlight : "transparent"

              Behavior on color {
                ColorAnimation { duration: 150 }
              }
            }

            Text {
              id: wsText
              anchors.centerIn: parent
              text: root.workspaceIcons[index] || wsItem.wsId.toString()
              font.family: "Symbols Nerd Font"
              font.pixelSize: 20
              color: wsItem.isActive ? root.fg :
                     wsItem.isOccupied ? root.fg :
                     root.fgDim

              Behavior on color {
                ColorAnimation { duration: 150 }
              }
            }

            MouseArea {
              anchors.fill: parent
              onClicked: Hyprland.dispatch("workspace " + wsItem.wsId)
            }
          }
        }
      }

      WheelHandler {
        onWheel: (event) => {
          if (event.angleDelta.y < 0)
            Hyprland.dispatch("workspace r+1")
          else if (event.angleDelta.y > 0)
            Hyprland.dispatch("workspace r-1")
        }
      }
    }

    // Separator: Groups -> Spacer
    PowerlineSep {
      visible: root.showWorkspaces
      Layout.fillHeight: true
      colorLeft: root.sectionGroups
      colorRight: root.sectionSpacer
      sepWidth: root.powerlineSize
      direction: "forward"
    }

    // === SPACER RIGHT ===
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      color: root.sectionSpacer
    }

    // Separator: Spacer -> Clock
    PowerlineSep {
      visible: root.showClock
      Layout.fillHeight: true
      colorLeft: root.sectionSpacer
      colorRight: clockMouse.containsMouse ? root.accent : root.sectionClock
      sepWidth: root.powerlineSize
      direction: "back"
    }

    // === CLOCK SECTION ===
    Rectangle {
      id: clockSection
      visible: root.showClock
      Layout.fillHeight: true
      Layout.preferredWidth: clockRow.implicitWidth + root.barPadding * 2
      color: clockMouse.containsMouse ? root.accent : root.sectionClock

      Behavior on color { ColorAnimation { duration: 150 } }

      Row {
        id: clockRow
        anchors.centerIn: parent
        spacing: 6

        Text {
          id: dateText
          color: clockMouse.containsMouse ? root.bg : root.fg
          font.family: "JetBrainsMono Nerd Font"
          font.pixelSize: 14
          anchors.verticalCenter: parent.verticalCenter

          Behavior on color { ColorAnimation { duration: 150 } }
        }

        Text {
          text: "|"
          color: clockMouse.containsMouse ? root.bg : root.fgDim
          font.family: "JetBrainsMono Nerd Font"
          font.pixelSize: 14
          anchors.verticalCenter: parent.verticalCenter

          Behavior on color { ColorAnimation { duration: 150 } }
        }

        Text {
          id: timeText
          color: clockMouse.containsMouse ? root.bg : root.fg
          font.family: "JetBrainsMono Nerd Font"
          font.pixelSize: 14
          anchors.verticalCenter: parent.verticalCenter

          Behavior on color { ColorAnimation { duration: 150 } }
        }
      }

      MouseArea {
        id: clockMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
          PanelService.getPanel("clockPanel", root.screen)?.toggle(clockSection)
        }
      }

      Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
          var months = ["janeiro", "fevereiro", "março", "abril", "maio", "junho",
                       "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"]
          var d = new Date()
          dateText.text = d.getDate() + " " + months[d.getMonth()]
          timeText.text = d.getHours().toString().padStart(2, '0') + ":" +
                         d.getMinutes().toString().padStart(2, '0')
        }
      }
    }

    // Separator: Clock -> CC Button
    PowerlineSep {
      visible: root.showClock
      Layout.fillHeight: true
      colorLeft: clockMouse.containsMouse ? root.accent : root.sectionClock
      colorRight: ccMouse.containsMouse ? root.accent : root.bgHighlight
      sepWidth: root.powerlineSize
      direction: "back"
    }

    // Separator: Spacer -> CC Button (when Clock hidden)
    PowerlineSep {
      visible: !root.showClock
      Layout.fillHeight: true
      colorLeft: root.sectionSpacer
      colorRight: ccMouse.containsMouse ? root.accent : root.bgHighlight
      sepWidth: root.powerlineSize
      direction: "back"
    }

    // === CONTROL CENTER BUTTON ===
    Rectangle {
      Layout.fillHeight: true
      Layout.preferredWidth: ccIcon.implicitWidth + root.barPadding * 2 + 5
      color: ccMouse.containsMouse ? root.accent : root.bgHighlight

      Behavior on color { ColorAnimation { duration: 150 } }

      Text {
        id: ccIcon
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -2.5
        text: "󰒓"
        color: ccMouse.containsMouse ? root.bg : root.fg
        font.family: "Symbols Nerd Font"
        font.pixelSize: 18

        Behavior on color { ColorAnimation { duration: 150 } }
      }

      MouseArea {
        id: ccMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
          // Open Noctalia's default Control Center
          PanelService.getPanel("controlCenterPanel", root.screen)?.toggle(parent)
        }
      }
    }
  }
}
