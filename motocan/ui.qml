import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

import Vedder.vesc.commands 1.0
import Vedder.vesc.utility 1.0

Item {
	id: container;
	anchors.fill: parent;

	property string title: "MotoCAN"

	property Commands mCommands: VescIf.commands()

	readonly property int commDemoToggle: 100
	readonly property int commLightOff: 1
	readonly property int commLightOn: 2
	readonly property int commLockLocked: 3
	readonly property int commLockUnlocked: 4
	readonly property int commMode1: 5
	readonly property int commMode2: 6

	property bool demoMode: false
	property bool lightState: true
	property int modeState: 1
	property bool lockState: false

	Action {
		id: demoToggle
		onTriggered: {
			var buffer = new ArrayBuffer(1);
			var dv = new DataView(buffer);
			var ind = 0;
			dv.setUint8(ind, commDemoToggle);
			ind += 1;
			mCommands.sendCustomAppData(buffer);
		}
	}

	Action {
		id: lightOff
		onTriggered: {
			var buffer = new ArrayBuffer(1);
			var dv = new DataView(buffer);
			var ind = 0;
			dv.setUint8(ind, commLightOff);
			ind += 1;
			mCommands.sendCustomAppData(buffer);
		}
	}

	Action {
		id: lightOn
		onTriggered: {
			var buffer = new ArrayBuffer(1);
			var dv = new DataView(buffer);
			var ind = 0;
			dv.setUint8(ind, commLightOn);
			ind += 1;
			mCommands.sendCustomAppData(buffer);
		}
	}

	Action {
		id: wheelLockLocked
		onTriggered: {
			var buffer = new ArrayBuffer(1);
			var dv = new DataView(buffer);
			var ind = 0;
			dv.setUint8(ind, commLockLocked);
			ind += 1;
			mCommands.sendCustomAppData(buffer);
		}
	}

	Action {
		id: wheelLockUnlocked
		onTriggered: {
			var buffer = new ArrayBuffer(1);
			var dv = new DataView(buffer);
			var ind = 0;
			dv.setUint8(ind, commLockUnlocked);
			ind += 1;
			mCommands.sendCustomAppData(buffer);
		}
	}

	Action {
		id: mode1
		onTriggered: {
			var buffer = new ArrayBuffer(1);
			var dv = new DataView(buffer);
			var ind = 0;
			dv.setUint8(ind, commMode1);
			ind += 1;
			mCommands.sendCustomAppData(buffer);
		}
	}

	Action {
		id: mode2
		onTriggered: {
			var buffer = new ArrayBuffer(1);
			var dv = new DataView(buffer);
			var ind = 0;
			dv.setUint8(ind, commMode2);
			ind += 1;
			mCommands.sendCustomAppData(buffer);
		}
	}

	Item {
		id: header
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.margins: 10
		height: 60

		RowLayout {
			anchors.centerIn: parent
			spacing: 15

			Text {
				font.pointSize: 22
				font.bold: true
				color: Utility.getAppHexColor("normalText")
				text: "MotoCAN"
			}
		}

		ScrollView {
			id: scrollView
			anchors.top: header.bottom
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: parent.right

			contentWidth: availableWidth
			ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
			ScrollBar.horizontal.interactive: false
			ScrollBar.vertical.policy: ScrollBar.AsNeeded

			ColumnLayout {
				anchors.leftMargin: 20
				anchors.rightMargin: 20
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.bottomMargin: 2000

				GridLayout {
					columns: 2
					rowSpacing: 0
					columnSpacing: 20

					Text {
						Layout.columnSpan: 2
						text: "Text"
					}

					Button {
						Layout.fillWidth: true
						text: "Off"
					}

					Button {
						Layout.fillWidth: true
						text: "On"
					}
				}
			}


			//GridLayout {
				//columns: 2
				//anchors.leftMargin: 10
				//anchors.rightMargin: 20
				//anchors.left: parent.left
				//anchors.right: parent.right
				//rowSpacing: 0
				//columnSpacing: 20

				//Button {
				//Layout.fillWidth: true
				//Layout.columnSpan: 2
				//text: "Demo Mode"
				//highlighted: demoMode == true
				//action: demoToggle
				//}

				//RowLayout {
					//anchors.topMargin: 20
					//Layout.columnSpan: 2
					//Text {
						//text: "Lights"
						//color: Utility.getAppHexColor("normalText")
						//font.bold: true
					//}
				//}

				//Button {
					//Layout.fillWidth: true
					//highlighted: lightState == false
					//text: "Off"

					//action: lightOff
				//}

				//Button {
					//Layout.fillWidth: true
					//highlighted: lightState == true
					//text: "On"

					//action: lightOn
				//}

				//RowLayout {
					//Layout.columnSpan: 2
					//anchors.topMargin: 20

					//Text {
						//color: Utility.getAppHexColor("normalText")
						//text: "Wheel Lock"
						//font.bold: true
						//Layout.columnSpan: 2
					//}

				//}
				//Button {
					//Layout.fillWidth: true
					//highlighted: lockState == 1
					//text: "Locked"

					//action: wheelLockLocked
				//}

				//Button {
					//Layout.fillWidth: true
					//highlighted: lockState == 0
					//text: "Unlocked"

					//action: wheelLockUnlocked
				//}

				//Text {
					//color: Utility.getAppHexColor("normalText")

					//text: "Ride Mode"
					//font.bold: true
					//Layout.columnSpan: 2
				//}

				//Button {
					//Layout.fillWidth: true
					//highlighted: modeState == 1
					//text: "1 Compliant"

					//action: mode1
				//}

				//Button {
					//Layout.fillWidth: true
					//highlighted: modeState == 2
					//text: "2 Unlimited"

					//action: mode2
				//}
			//}
		}
	}

	Timer {
		interval: 100
		running: true
		repeat: true
		onTriggered: {
			var buffer = new ArrayBuffer(1);
			mCommands.sendCustomAppData(buffer)
		}
	}

	Connections {
		target: mCommands

		function onCustomAppDataReceived(data) {
			var state = data.toString().split(":")

			demoMode = state[0] == "1"
			lightState = state[1] == "1"
			lockState = state[2] == "1"
			modeState = parseInt(state[3])
		}
	}
}
