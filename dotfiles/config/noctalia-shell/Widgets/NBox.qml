import QtQuick
import qs.Commons

// Rounded group container using the variant surface color.
// Uses PowerlineConfig for centralized powerline settings.
Item {
  id: root

  property color boxColor: Color.mSurfaceVariant
  property alias color: root.boxColor
  property alias radius: wrapper.radius
  property alias border: wrapper.border
  property int powerlineSize: PowerlineConfig.sizeLarge

  NPowerlineWrapper {
    id: wrapper
    anchors.fill: parent
    fillColor: root.boxColor
    triangleSize: root.powerlineSize
    radius: Style.radiusM
    border.color: Style.boxBorderColor
    border.width: Style.borderS
  }
}
