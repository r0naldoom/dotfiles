import QtQuick
import qs.Commons

// Wrapper that adds powerline triangles to any content
Item {
  id: root

  property color fillColor: Color.mSurface
  property int triangleSize: PowerlineConfig.sizeMedium
  property real sharpness: PowerlineConfig.sharpness
  property real radius: Style.iRadiusM
  property alias border: standardRect.border

  // Content goes here
  default property alias content: contentContainer.data

  // Standard style (rounded rectangle)
  Rectangle {
    id: standardRect
    anchors.fill: parent
    visible: !PowerlineConfig.enabled
    color: root.fillColor
    radius: root.radius

    Behavior on color {
      ColorAnimation { duration: Style.animationFast }
    }
  }

  // Powerline style (triangles + center rectangle)
  Item {
    id: powerlineContainer
    anchors.fill: parent
    visible: PowerlineConfig.enabled

    PowerlineTriangle {
      id: leftTriangle
      position: "left"
      width: root.triangleSize
      fillColor: root.fillColor
      sharpness: root.sharpness
    }

    Rectangle {
      id: centerRect
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.leftMargin: root.triangleSize
      anchors.rightMargin: root.triangleSize
      height: parent.height
      color: root.fillColor

      Behavior on color {
        ColorAnimation { duration: Style.animationFast }
      }
    }

    PowerlineTriangle {
      id: rightTriangle
      position: "right"
      width: root.triangleSize
      fillColor: root.fillColor
      sharpness: root.sharpness
    }
  }

  // Content container - positioned with margins when powerline is active
  Item {
    id: contentContainer
    anchors.fill: parent
    anchors.leftMargin: PowerlineConfig.enabled ? root.triangleSize : 0
    anchors.rightMargin: PowerlineConfig.enabled ? root.triangleSize : 0
  }
}
