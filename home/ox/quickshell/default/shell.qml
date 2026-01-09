import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors
import "modules"

ShellRoot {
  PanelWindow {
    id: panelWindow
    color: "transparent"
    implicitHeight: 34

    anchors {
      left: true
      top: true
      right: true
    }

    margins {
      left: 10
      right: 10
      top: 5
    }

    RowLayout {
      anchors.fill: parent
      spacing: 10

      Item { Layout.fillWidth: true }

      Workspaces {}

      Clock {
        id: clockWidget
        calendarPopup: calendarPopup
      }

      Battery {}

      Item { Layout.fillWidth: true }
    }
  }

  CalendarPopup {
    id: calendarPopup
    parentWindow: panelWindow
  }
}
