import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "colors.js" as Colors

PanelWindow {
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

    // Workspaces module
    Rectangle {
      color: Colors.base00
      opacity: 0.85
      radius: 8
      implicitWidth: workspacesRow.implicitWidth + 16
      implicitHeight: workspacesRow.implicitHeight + 12

      Row {
        id: workspacesRow
        anchors.centerIn: parent
        spacing: 8

        Repeater {
          model: Hyprland.workspaces

          Item {
            required property var modelData
            property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id
            property bool isSpecial: modelData.id < 0

            visible: !isSpecial

            width: isActive ? 24 : 8
            height: 8

            Behavior on width {
              NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
              }
            }

            Rectangle {
              anchors.centerIn: parent
              width: parent.width
              height: 8
              radius: 4
              color: parent.isActive ? Colors.base0D : Colors.base03

              Behavior on color {
                ColorAnimation {
                  duration: 200
                  easing.type: Easing.OutCubic
                }
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace " + parent.parent.modelData.id)
              }
            }
          }
        }

        // Separator
        Rectangle {
          width: 2
          height: 8
          radius: 1
          color: Colors.base02
          opacity: 0.5
          visible: Hyprland.workspaces.values.some(ws => ws.id < 0)
        }

        // Special workspace
        Repeater {
          model: Hyprland.workspaces

          Item {
            required property var modelData
            property bool isSpecial: modelData.id < 0

            visible: isSpecial

            width: 8
            height: 8

            Rectangle {
              anchors.centerIn: parent
              width: parent.width
              height: 8
              radius: 4
              color: Colors.base0E

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("togglespecialworkspace magic")
              }
            }
          }
        }
      }
    }

    Item { Layout.fillWidth: true }
  }
}
