import QtQuick
import "../colors.js" as Colors

Rectangle {
  id: clockWidget
  color: Colors.base00
  radius: 8
  implicitWidth: timeText.implicitWidth + 16
  implicitHeight: timeText.implicitHeight + 12

  property var calendarPopup

  Text {
    id: timeText
    anchors.centerIn: parent
    color: Colors.base05
    font.pixelSize: 12
    text: Qt.formatDateTime(new Date(), "HH:mm / dd.MM.yyyy")

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: parent.text = Qt.formatDateTime(new Date(), "HH:mm / dd.MM.yyyy")
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onEntered: {
      if (calendarPopup) {
        calendarPopup.visible = true
      }
    }

    onExited: {
      if (calendarPopup) {
        calendarPopup.visible = false
      }
    }
  }
}
