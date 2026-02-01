import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

Item {
  id: root
  objectName: "NTabBar"

  // Public properties
  property int currentIndex: 0
  property real spacing: Style.marginXS
  property real margins: 0
  property real tabHeight: Style.baseWidgetSize
  property bool distributeEvenly: false
  default property alias content: tabRow.children

  // Styling
  property color color: Color.mSurfaceVariant
  property real radius: Style.iRadiusM
  property alias border: standardRect.border

  // Internal
  readonly property int pwSize: PowerlineConfig.sizeMedium

  onDistributeEvenlyChanged: _applyDistribution()
  Component.onCompleted: _applyDistribution()

  function _updateFirstLast() {
    var kids = tabRow.children;
    var len = kids.length;
    var firstVisible = -1, lastVisible = -1;
    for (var i = 0; i < len; i++) {
      var child = kids[i];
      if (child.visible && "isFirst" in child) {
        if (firstVisible === -1) firstVisible = i;
        lastVisible = i;
      }
    }
    for (var i = 0; i < len; i++) {
      var child = kids[i];
      if ("isFirst" in child) child.isFirst = (i === firstVisible);
      if ("isLast" in child) child.isLast = (i === lastVisible);
    }
  }

  function _applyDistribution() {
    for (var i = 0; i < tabRow.children.length; i++) {
      var child = tabRow.children[i];
      child.Layout.fillWidth = true;
      if (distributeEvenly) child.Layout.preferredWidth = 1;
    }
  }

  implicitWidth: tabRow.implicitWidth + (margins * 2) + (PowerlineConfig.enabled ? pwSize * 2 : 0)
  implicitHeight: tabHeight + (margins * 2)

  // Standard style
  Rectangle {
    id: standardRect
    anchors.fill: parent
    visible: !PowerlineConfig.enabled
    color: root.color
    radius: root.radius
  }

  // Powerline style
  Item {
    anchors.fill: parent
    visible: PowerlineConfig.enabled

    PowerlineTriangle { position: "left"; width: root.pwSize; fillColor: root.color }
    Rectangle {
      anchors.left: parent.left; anchors.right: parent.right
      anchors.leftMargin: root.pwSize; anchors.rightMargin: root.pwSize
      height: parent.height; color: root.color
    }
    PowerlineTriangle { position: "right"; width: root.pwSize; fillColor: root.color }
  }

  RowLayout {
    id: tabRow
    anchors.fill: parent
    anchors.margins: margins
    anchors.leftMargin: PowerlineConfig.enabled ? root.pwSize + margins : margins
    anchors.rightMargin: PowerlineConfig.enabled ? root.pwSize + margins : margins
    spacing: root.spacing

    onChildrenChanged: {
      for (var i = 0; i < children.length; i++)
        children[i].visibleChanged.connect(root._updateFirstLast);
      root._updateFirstLast();
      root._applyDistribution();
    }
  }
}
