import QtQuick
import qs.Commons

// Reusable powerline triangle component
Canvas {
  id: root

  property color fillColor: Color.mSurface
  property string position: "left"  // "left" or "right"
  property real sharpness: 0.6      // triangle point position (0.0-1.0)

  width: PowerlineConfig.sizeMedium
  height: parent.height

  anchors.left: position === "left" ? parent.left : undefined
  anchors.right: position === "right" ? parent.right : undefined

  onPaint: {
    var ctx = getContext("2d")
    ctx.reset()
    ctx.fillStyle = root.fillColor

    ctx.beginPath()
    if (root.position === "left") {
      // Left triangle: point facing left
      ctx.moveTo(0, 0)
      ctx.lineTo(width, 0)
      ctx.lineTo(width, height)
      ctx.lineTo(0, height)
      ctx.lineTo(width * root.sharpness, height / 2)
    } else {
      // Right triangle: point facing right
      ctx.moveTo(0, 0)
      ctx.lineTo(width, 0)
      ctx.lineTo(width * (1 - root.sharpness), height / 2)
      ctx.lineTo(width, height)
      ctx.lineTo(0, height)
    }
    ctx.closePath()
    ctx.fill()
  }

  onFillColorChanged: requestPaint()
  onSharpnessChanged: requestPaint()
  onPositionChanged: requestPaint()
  onWidthChanged: requestPaint()
  onHeightChanged: requestPaint()
}
