import QtQuick
import Quickshell.Services.UPower
import "../colors.js" as Colors

Rectangle {
  id: batteryWidget

  property var battery: UPower.displayDevice
  property bool hasBattery: battery?.isLaptopBattery ?? false

  visible: hasBattery

  color: Colors.base00
  radius: 8
  implicitWidth: batteryText.implicitWidth + 16
  implicitHeight: batteryText.implicitHeight + 12

  Text {
    id: batteryText
    anchors.centerIn: parent
    color: {
      if (!batteryWidget.hasBattery) return Colors.base05

      var pct = batteryWidget.battery.percentage
      if (pct <= 20) return Colors.base08  // red
      if (pct <= 50) return Colors.base09  // orange
      return Colors.base05  // normal
    }
    font.pixelSize: 12
    text: batteryWidget.hasBattery ? Math.round(batteryWidget.battery.percentage) + "%" : ""
  }
}
