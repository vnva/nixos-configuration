import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../colors.js" as Colors

PopupWindow {
  id: calendarWindow
  visible: false
  implicitWidth: contentRect.implicitWidth
  implicitHeight: contentRect.implicitHeight
  color: "transparent"

  property var parentWindow

  anchor {
    window: parentWindow
    rect.x: parentWindow ? parentWindow.width / 2 - implicitWidth / 2 : 0
    rect.y: parentWindow ? 44 : 0
  }

  function toggle() {
    visible = !visible
  }

  MouseArea {
    width: contentRect.implicitWidth
    height: contentRect.implicitHeight
    hoverEnabled: true

    onEntered: calendarWindow.visible = true
    onExited: calendarWindow.visible = false

    Rectangle {
      id: contentRect
      implicitWidth: contentLayout.implicitWidth + 32
      implicitHeight: contentLayout.implicitHeight + 32
      color: Colors.base00
      radius: 12
      border.color: Colors.base02
      border.width: 1

      ColumnLayout {
        id: contentLayout
        anchors.centerIn: parent
        width: parent.width - 32
        spacing: 12

      // Month/Year header
      Text {
        Layout.alignment: Qt.AlignHCenter
        color: Colors.base05
        font.pixelSize: 16
        font.bold: true
        text: Qt.formatDateTime(new Date(), "MMMM yyyy")
      }

      // Weekday headers
      GridLayout {
        Layout.fillWidth: true
        columns: 7
        columnSpacing: 8
        rowSpacing: 8

        Repeater {
          model: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

          Text {
            Layout.preferredWidth: 32
            Layout.preferredHeight: 20
            horizontalAlignment: Text.AlignHCenter
            color: Colors.base04
            font.pixelSize: 10
            text: modelData
          }
        }
      }

      // Calendar grid
      GridLayout {
        Layout.fillWidth: true
        columns: 7
        columnSpacing: 8
        rowSpacing: 8

        Repeater {
          id: daysRepeater
          model: 42 // 6 weeks

          Rectangle {
            required property int index

            property var currentDate: new Date()
            property int year: currentDate.getFullYear()
            property int month: currentDate.getMonth()

            // Get first day of month (0 = Sunday, 1 = Monday, etc)
            property var firstDay: new Date(year, month, 1)
            property int firstDayOfWeek: (firstDay.getDay() + 6) % 7 // Convert to Monday = 0

            // Calculate day number
            property int dayNumber: index - firstDayOfWeek + 1
            property bool validDay: dayNumber > 0 && dayNumber <= new Date(year, month + 1, 0).getDate()
            property bool isToday: validDay && dayNumber === currentDate.getDate()

            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            radius: 4
            color: isToday ? Colors.base0D : "transparent"
            opacity: validDay ? 1.0 : 0.3

            Text {
              anchors.centerIn: parent
              color: parent.isToday ? Colors.base00 : (parent.validDay ? Colors.base05 : Colors.base03)
              font.pixelSize: 12
              font.bold: parent.isToday
              text: parent.validDay ? parent.dayNumber : ""
            }
          }
        }
      }
      }
    }
  }
}
