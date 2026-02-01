import QtQuick

// Powerline-style diagonal separator
Item {
  id: root

  property color colorLeft: "#282828"
  property color colorRight: "#3c3836"
  property string direction: "forward"  // "forward" (/) or "back" (\)
  property int sepWidth: 15

  implicitWidth: sepWidth
  implicitHeight: parent.height

  // Background
  Rectangle {
    anchors.fill: parent
    anchors.leftMargin: -1
    anchors.rightMargin: -1
    color: root.colorRight
  }

  // Left side extension to cover gap
  Rectangle {
    anchors.left: parent.left
    anchors.leftMargin: -1
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: 2
    color: root.colorLeft
  }

  // Canvas draws the triangle
  Canvas {
    id: canvas
    anchors.fill: parent
    anchors.leftMargin: -1
    anchors.rightMargin: -1
    antialiasing: false

    onPaint: {
      var ctx = getContext("2d")
      ctx.reset()

      var w = width
      var h = height

      ctx.fillStyle = root.colorLeft

      if (root.direction === "forward") {
        // Forward slash: /
        ctx.beginPath()
        ctx.moveTo(0, 0)
        ctx.lineTo(0, h)
        ctx.lineTo(w, h)
        ctx.closePath()
        ctx.fill()
      } else {
        // Back slash: \
        ctx.beginPath()
        ctx.moveTo(0, 0)
        ctx.lineTo(0, h)
        ctx.lineTo(w, 0)
        ctx.closePath()
        ctx.fill()
      }
    }
  }

  // Right side extension (for "back" direction)
  Rectangle {
    visible: root.direction === "back"
    anchors.right: parent.right
    anchors.rightMargin: -1
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: 2
    color: root.colorRight
  }

  onColorLeftChanged: canvas.requestPaint()
  onColorRightChanged: canvas.requestPaint()
  onDirectionChanged: canvas.requestPaint()
}
