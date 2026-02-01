import QtQuick
import Quickshell
import qs.Commons

// Powerline-style card with triangular separators on left and right
Item {
  id: root

  property color cardColor: Color.mSurfaceVariant
  property int powerlineSize: 10
  property int radius: 0
  default property alias content: cardContent.data

  // Left powerline separator
  Canvas {
    id: leftSep
    width: root.powerlineSize
    height: parent.height
    anchors.left: parent.left

    onPaint: {
      var ctx = getContext("2d")
      ctx.reset()
      ctx.fillStyle = root.cardColor
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
      function onCardColorChanged() { leftSep.requestPaint() }
      function onPowerlineSizeChanged() { leftSep.requestPaint() }
    }
  }

  // Main content area
  Rectangle {
    id: mainRect
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: root.powerlineSize
    anchors.rightMargin: root.powerlineSize
    height: parent.height
    color: root.cardColor
    radius: root.radius

    Item {
      id: cardContent
      anchors.fill: parent
    }
  }

  // Right powerline separator
  Canvas {
    id: rightSep
    width: root.powerlineSize
    height: parent.height
    anchors.right: parent.right

    onPaint: {
      var ctx = getContext("2d")
      ctx.reset()
      ctx.fillStyle = root.cardColor
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
      function onCardColorChanged() { rightSep.requestPaint() }
      function onPowerlineSizeChanged() { rightSep.requestPaint() }
    }
  }
}
