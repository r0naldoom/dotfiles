import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Services.UI

Item {
  id: root

  // Public properties
  property string text: ""
  property string icon: ""
  property string tooltipText
  property color backgroundColor: Color.mPrimary
  property color textColor: Color.mOnPrimary
  property color hoverColor: Color.mHover
  property color textHoverColor: Color.mOnHover
  property real fontSize: Style.fontSizeM
  property int fontWeight: Style.fontWeightSemiBold
  property real iconSize: Style.fontSizeL
  property bool outlined: false
  property int horizontalAlignment: Qt.AlignHCenter
  property real buttonRadius: Style.iRadiusS

  // Signals
  signal clicked
  signal rightClicked
  signal middleClicked
  signal entered
  signal exited

  // Internal
  property bool hovered: false
  readonly property int pwSize: PowerlineConfig.sizeMedium
  readonly property color contentColor: {
    if (!root.enabled) return Color.mOnSurfaceVariant;
    if (root.hovered) return root.textHoverColor;
    if (root.outlined) return root.backgroundColor;
    return root.textColor;
  }
  readonly property color btnColor: {
    if (!root.enabled) return outlined ? "transparent" : Qt.lighter(Color.mSurfaceVariant, 1.2);
    if (root.hovered) return hoverColor;
    return root.outlined ? "transparent" : root.backgroundColor;
  }

  // Dimensions
  implicitWidth: contentRow.implicitWidth + (fontSize * 2) + (PowerlineConfig.enabled ? pwSize * 2 : 0)
  implicitHeight: contentRow.implicitHeight + (fontSize)
  opacity: enabled ? 1.0 : 0.6

  // Standard style
  Rectangle {
    anchors.fill: parent
    visible: !PowerlineConfig.enabled
    radius: root.buttonRadius
    color: root.btnColor
    border.width: root.outlined ? Style.borderS : 0
    border.color: !root.enabled ? Color.mOutline : root.hovered ? root.backgroundColor : root.outlined ? root.backgroundColor : "transparent"
    Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
    Behavior on border.color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
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
      Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
    }
    PowerlineTriangle { position: "right"; width: root.pwSize; fillColor: root.btnColor }
  }

  // Content
  RowLayout {
    id: contentRow
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: root.horizontalAlignment === Qt.AlignLeft ? parent.left : undefined
    anchors.horizontalCenter: root.horizontalAlignment === Qt.AlignHCenter ? parent.horizontalCenter : undefined
    anchors.leftMargin: root.horizontalAlignment === Qt.AlignLeft ? Style.marginL + (PowerlineConfig.enabled ? root.pwSize : 0) : 0
    spacing: Style.marginXS

    NIcon {
      Layout.alignment: Qt.AlignVCenter
      visible: root.icon !== ""
      icon: root.icon
      pointSize: root.iconSize
      color: contentColor
      Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
    }

    NText {
      Layout.alignment: Qt.AlignVCenter
      visible: root.text !== ""
      text: root.text
      pointSize: root.fontSize
      font.weight: root.fontWeight
      color: contentColor
      Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
    }
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    enabled: root.enabled
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
    cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

    onEntered: { root.hovered = true; root.entered(); if (tooltipText) TooltipService.show(root, root.tooltipText) }
    onExited: { root.hovered = false; root.exited(); if (tooltipText) TooltipService.hide() }
    onPressed: mouse => {
      if (tooltipText) TooltipService.hide();
      if (mouse.button === Qt.LeftButton) root.clicked();
      else if (mouse.button == Qt.RightButton) root.rightClicked();
      else if (mouse.button == Qt.MiddleButton) root.middleClicked();
    }
    onCanceled: { root.hovered = false; if (tooltipText) TooltipService.hide() }
  }
}
