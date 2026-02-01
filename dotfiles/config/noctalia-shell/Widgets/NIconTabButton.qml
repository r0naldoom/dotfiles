import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Widgets

Item {
  id: root

  property string icon: ""
  property string tooltipText: ""
  property bool checked: false
  property int tabIndex: 0
  property bool isHovered: false

  signal clicked

  // Internal
  readonly property int pwSize: PowerlineConfig.sizeSmall
  readonly property color btnColor: root.checked ? Color.mPrimary : (root.isHovered ? Color.mHover : Color.mSurface)

  Layout.fillWidth: true
  Layout.fillHeight: true

  // Standard style
  Rectangle {
    anchors.fill: parent
    visible: !PowerlineConfig.enabled
    radius: Style.iRadiusXS
    color: root.btnColor
    Behavior on color { ColorAnimation { duration: Style.animationFast } }
  }

  // Powerline style
  Item {
    anchors.fill: parent
    visible: PowerlineConfig.enabled

    PowerlineTriangle { position: "left"; width: root.pwSize; fillColor: root.btnColor }
    Rectangle {
      anchors.left: parent.left; anchors.right: parent.right
      anchors.leftMargin: root.pwSize; anchors.rightMargin: root.pwSize
      height: parent.height; color: root.btnColor
      Behavior on color { ColorAnimation { duration: Style.animationFast } }
    }
    PowerlineTriangle { position: "right"; width: root.pwSize; fillColor: root.btnColor }
  }

  NIcon {
    anchors.centerIn: parent
    icon: root.icon
    pointSize: Style.fontSizeL
    color: root.checked ? Color.mOnPrimary : root.isHovered ? Color.mOnHover : Color.mOnSurface
    Behavior on color { ColorAnimation { duration: Style.animationFast } }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onEntered: { root.isHovered = true; if (root.tooltipText) TooltipService.show(parent, root.tooltipText) }
    onExited: { root.isHovered = false; if (root.tooltipText) TooltipService.hide() }
    onClicked: {
      if (root.tooltipText) TooltipService.hide();
      root.clicked();
      if (root.parent && root.parent.parent && root.parent.parent.currentIndex !== undefined)
        root.parent.parent.currentIndex = root.tabIndex;
    }
  }
}
