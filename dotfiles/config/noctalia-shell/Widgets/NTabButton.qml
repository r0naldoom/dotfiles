import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

Item {
  id: root

  property string text: ""
  property bool checked: false
  property int tabIndex: 0
  property real pointSize: Style.fontSizeM
  property bool isFirst: false
  property bool isLast: false
  property bool isHovered: false

  signal clicked

  // Internal
  readonly property int pwSize: PowerlineConfig.sizeMedium
  readonly property color buttonColor: root.isHovered ? Color.mHover : (root.checked ? Color.mPrimary : Color.mSurface)

  Layout.fillHeight: true
  implicitWidth: tabText.implicitWidth + Style.marginXL + (PowerlineConfig.enabled ? pwSize * 2 : 0)

  // Standard style
  Rectangle {
    id: standardStyle
    anchors.fill: parent
    visible: !PowerlineConfig.enabled
    topLeftRadius: root.isFirst ? Style.iRadiusM : Style.iRadiusXXXS
    bottomLeftRadius: root.isFirst ? Style.iRadiusM : Style.iRadiusXXXS
    topRightRadius: root.isLast ? Style.iRadiusM : Style.iRadiusXXXS
    bottomRightRadius: root.isLast ? Style.iRadiusM : Style.iRadiusXXXS
    color: root.buttonColor
    border.color: Color.mOutline
    border.width: Style.borderS
    Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
  }

  // Powerline style
  Item {
    anchors.fill: parent
    visible: PowerlineConfig.enabled

    PowerlineTriangle { position: "left"; width: root.pwSize; fillColor: root.buttonColor }
    Rectangle {
      anchors.left: parent.left; anchors.right: parent.right
      anchors.leftMargin: root.pwSize; anchors.rightMargin: root.pwSize
      height: parent.height; color: root.buttonColor
      Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
    }
    PowerlineTriangle { position: "right"; width: root.pwSize; fillColor: root.buttonColor }
  }

  NText {
    id: tabText
    y: Style.pixelAlignCenter(parent.height, height)
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: PowerlineConfig.enabled ? root.pwSize + Style.marginS : Style.marginS
    anchors.rightMargin: PowerlineConfig.enabled ? root.pwSize + Style.marginS : Style.marginS
    text: root.text
    pointSize: root.pointSize
    font.weight: Style.fontWeightSemiBold
    color: root.isHovered ? Color.mOnHover : (root.checked ? Color.mOnPrimary : Color.mOnSurface)
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    Behavior on color { enabled: !Color.isTransitioning; ColorAnimation { duration: Style.animationFast } }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onEntered: root.isHovered = true
    onExited: root.isHovered = false
    onClicked: {
      root.clicked();
      if (root.parent && root.parent.parent && root.parent.parent.currentIndex !== undefined)
        root.parent.parent.currentIndex = root.tabIndex;
    }
  }
}
