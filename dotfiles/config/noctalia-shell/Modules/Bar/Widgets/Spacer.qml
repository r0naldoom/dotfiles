import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Widgets

Item {
  id: root

  property ShellScreen screen

  // Widget properties passed from Bar.qml for per-instance settings
  property string widgetId: ""
  property string section: ""
  property int sectionWidgetIndex: -1
  property int sectionWidgetsCount: 0

  property var widgetMetadata: BarWidgetRegistry.widgetMetadata[widgetId]
  property var widgetSettings: {
    if (section && sectionWidgetIndex >= 0) {
      var widgets = Settings.getBarWidgetsForScreen(screen?.name)[section];
      if (widgets && sectionWidgetIndex < widgets.length) {
        return widgets[sectionWidgetIndex];
      }
    }
    return {};
  }

  readonly property string barPosition: Settings.getBarPositionForScreen(screen?.name)
  readonly property bool isBarVertical: barPosition === "left" || barPosition === "right"
  readonly property real barHeight: Style.getBarHeightForScreen(screen?.name)
  readonly property int spacerSize: widgetSettings.width !== undefined ? widgetSettings.width : widgetMetadata.width

  implicitWidth: isBarVertical ? barHeight : spacerSize
  implicitHeight: isBarVertical ? spacerSize : barHeight
  width: implicitWidth
  height: implicitHeight
}
