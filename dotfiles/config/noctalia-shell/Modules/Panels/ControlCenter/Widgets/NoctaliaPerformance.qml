import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.Power
import qs.Widgets

NIconButtonHot {
  property ShellScreen screen

  icon: PowerProfileService.noctaliaPerformanceMode ? "rocket" : "rocket-off"
  tooltipText: PowerProfileService.noctaliaPerformanceMode ? I18n.tr("toast.noctalia-performance.enabled") : I18n.tr("toast.noctalia-performance.disabled")
  hot: PowerProfileService.noctaliaPerformanceMode
  onClicked: PowerProfileService.toggleNoctaliaPerformance()
}
