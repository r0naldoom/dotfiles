pragma Singleton
import QtQuick

// Centralized powerline configuration
QtObject {
  id: root

  // Main toggle - reads from Settings (reactive binding)
  property bool enabled: Settings.data.ui.powerlineStyle ?? false

  // Standard sizes for different widget types
  readonly property int sizeSmall: 6    // NIconButton, NIconButtonHot
  readonly property int sizeMedium: 8   // NButton, NTextInput, NTabBar, NComboBox
  readonly property int sizeLarge: 10   // Cards, containers

  // Triangle sharpness (how pointy the triangle is)
  readonly property real sharpness: 0.6
}
