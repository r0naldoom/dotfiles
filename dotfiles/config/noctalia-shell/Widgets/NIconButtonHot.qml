import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import qs.Commons
import qs.Services.UI

Item {
  id: root

  property real baseSize: Style.baseWidgetSize
  property bool applyUiScale: true
  property string icon: ""
  property string tooltipText: ""
  property string tooltipDirection: "auto"
  property bool allowClickWhenDisabled: false
  property bool hot: false
  property bool hovering: false
  property bool pressed: false

  property color colorBg: Color.mSurfaceVariant
  property color colorFg: Color.mPrimary
  property color colorBgHover: Color.mHover
  property color colorFgHover: Color.mOnHover
  property color colorBorder: Color.mOutline
  property color colorBorderHover: Color.mOutline
  property color colorBgHot: Color.mPrimary
  property color colorFgHot: Color.mOnPrimary
  property alias border: standardRect.border

  signal entered
  signal exited
  signal clicked
  signal rightClicked
  signal middleClicked

  // Internal
  readonly property int pwSize: PowerlineConfig.sizeSmall
  readonly property color btnBgColor: pressed ? colorBgHover : hot ? colorBgHot : (root.enabled && root.hovering) ? colorBgHover : colorBg
  readonly property color fgColor: pressed ? colorFgHover : hot ? colorFgHot : (root.enabled && root.hovering) ? colorFgHover : colorFg

  implicitWidth: (applyUiScale ? Math.round(baseSize * Style.uiScaleRatio) : Math.round(baseSize)) + (PowerlineConfig.enabled ? pwSize * 2 : 0)
  implicitHeight: applyUiScale ? Math.round(baseSize * Style.uiScaleRatio) : Math.round(baseSize)
  opacity: root.enabled ? Style.opacityFull : Style.opacityMedium

  // Standard style
  Rectangle {
    id: standardRect
    anchors.fill: parent
    visible: !PowerlineConfig.enabled
    color: root.btnBgColor
    radius: Math.min(Style.iRadiusL, width / 2)
    border.color: root.enabled && root.hovering ? root.colorBorderHover : root.colorBorder
    border.width: Style.borderS
    Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
  }

  // Powerline style
  Item {
    anchors.fill: parent
    visible: PowerlineConfig.enabled

    PowerlineTriangle { position: "left"; width: root.pwSize; fillColor: root.btnBgColor }
    Rectangle {
      anchors.left: parent.left; anchors.right: parent.right
      anchors.leftMargin: root.pwSize; anchors.rightMargin: root.pwSize
      height: parent.height; color: root.btnBgColor
      Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
    }
    PowerlineTriangle { position: "right"; width: root.pwSize; fillColor: root.btnBgColor }
  }

  NIcon {
    icon: root.icon
    pointSize: Math.max(1, Math.round((PowerlineConfig.enabled ? root.width - root.pwSize * 2 : root.width) * 0.48))
    applyUiScale: root.applyUiScale
    color: root.fgColor
    anchors.centerIn: parent
    Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
  }

  MouseArea {
    enabled: true
    anchors.fill: parent
    cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
    hoverEnabled: true

    onEntered: { hovering = root.enabled; if (tooltipText) TooltipService.show(parent, tooltipText, tooltipDirection); root.entered() }
    onExited: { hovering = false; if (tooltipText) TooltipService.hide(); root.exited() }
    onPressed: function (mouse) { if (root.enabled) root.pressed = true; if (tooltipText) TooltipService.hide() }
    onReleased: function (mouse) {
      root.scale = 1.0; root.pressed = false;
      if (!root.enabled && !allowClickWhenDisabled) return;
      if (root.hovering) {
        if (mouse.button === Qt.LeftButton) root.clicked();
        else if (mouse.button === Qt.RightButton) root.rightClicked();
        else if (mouse.button === Qt.MiddleButton) root.middleClicked();
      }
    }
    onCanceled: { root.hovering = false; root.pressed = false; root.scale = 1.0; if (tooltipText) TooltipService.hide() }
  }
}
