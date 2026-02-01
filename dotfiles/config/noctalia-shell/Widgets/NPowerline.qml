import QtQuick
import qs.Commons

// Powerline-style container with triangular edges
// Reads Settings.data.ui.powerlineStyle - falls back to normal box if disabled
Item {
  id: root

  property color fillColor: Color.mSurfaceVariant
  property int triangleSize: 10
  property alias border: fallbackRect.border
  default property alias content: contentContainer.data

  // Read global setting
  property bool usePowerline: Settings.data.ui.powerlineStyle

  // Fallback rectangle (when powerline disabled)
  Rectangle {
    id: fallbackRect
    anchors.fill: parent
    visible: !root.usePowerline
    color: root.fillColor
    radius: Style.radiusM
    border.color: Style.boxBorderColor
    border.width: Style.borderS
  }

  // Powerline style (when enabled)
  Item {
    anchors.fill: parent
    visible: root.usePowerline

    // Left triangle
    Canvas {
      id: leftTriangle
      width: root.triangleSize
      height: parent.height
      anchors.left: parent.left

      onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        ctx.fillStyle = root.fillColor
        ctx.beginPath()
        ctx.moveTo(0, 0)
        ctx.lineTo(width, 0)
        ctx.lineTo(width, height)
        ctx.lineTo(0, height)
        ctx.lineTo(width * 0.6, height / 2)
        ctx.closePath()
        ctx.fill()
      }

      Connections {
        target: root
        function onFillColorChanged() { leftTriangle.requestPaint() }
        function onTriangleSizeChanged() { leftTriangle.requestPaint() }
      }
    }

    // Center rectangle
    Rectangle {
      id: centerRect
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.leftMargin: root.triangleSize
      anchors.rightMargin: root.triangleSize
      height: parent.height
      color: root.fillColor
    }

    // Right triangle
    Canvas {
      id: rightTriangle
      width: root.triangleSize
      height: parent.height
      anchors.right: parent.right

      onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        ctx.fillStyle = root.fillColor
        ctx.beginPath()
        ctx.moveTo(0, 0)
        ctx.lineTo(width, 0)
        ctx.lineTo(width * 0.4, height / 2)
        ctx.lineTo(width, height)
        ctx.lineTo(0, height)
        ctx.closePath()
        ctx.fill()
      }

      Connections {
        target: root
        function onFillColorChanged() { rightTriangle.requestPaint() }
        function onTriangleSizeChanged() { rightTriangle.requestPaint() }
      }
    }
  }

  // Content container (for child items)
  Item {
    id: contentContainer
    anchors.fill: parent
    anchors.leftMargin: root.usePowerline ? root.triangleSize : 0
    anchors.rightMargin: root.usePowerline ? root.triangleSize : 0
  }
}
