import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

import Vedder.vesc.commands 1.0
import Vedder.vesc.utility 1.0

Rectangle {
    id: container;
    anchors.fill: parent;
    color: colorBg

    property Commands mCommands: VescIf.commands()
    property int verMajor: 0
    property int verMinor: 0
    property int verPatch: 0

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

    readonly property color colorRed: "#FF5252"
    readonly property color colorGreen: "#66BB6A"
    readonly property color colorAmber: "#FFC107"
    readonly property color colorBoostedOrange: "#F0401E"
    readonly property color colorBg: "#1D1D1D"
    readonly property color colorPanel: "#2D2D2D"
    readonly property color colorWhite: "#ffffff"
    readonly property color colorText: "#ffffff"
    readonly property color colorLightText: "#aaaaaa"


    property var lastUpdateTime: new Date()
    property string timeSinceUpdate: "0"
    property string statusText: "Status: connecting..."
    property color statusColor: colorRed

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
                color: colorText
                font.pointSize: 22
                font.bold: true
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

            //ColumnLayout {
                //width: scrollView.availableWidth

                //Rectangle {
                    //Layout.fillWidth: true
                    //Layout.preferredHeight: 30
                    //color: "red"
                //}

            GridLayout {
                columns: 2
                anchors.leftMargin: 10
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.right: parent.right
                rowSpacing: 0
                columnSpacing: 20



            Button {
                Layout.fillWidth: true
                Layout.columnSpan: 2
                text: "Demo Mode"
                highlighted: demoMode == true
                action: demoToggle
            }

                RowLayout {
                        anchors.topMargin: 20
                    Layout.columnSpan: 2
                Text {
                    text: "Lights"
                    font.bold: true
                    color: colorText
                }
                }

                ButtonGroup { id: lightsGroup }

                Button {
                Layout.fillWidth: true
                    highlighted: lightState == false
                    text: "Off"

                    action: lightOff
                }

                Button {
                Layout.fillWidth: true
                    //checked: lightState == true
                    highlighted: lightState == true
                    text: "On"

                    action: lightOn
                }

                Text {
                    text: "Wheel Lock"
                    font.bold: true
                    Layout.columnSpan: 2
                    color: colorText
                }

                Button {
                Layout.fillWidth: true
                    highlighted: lockState == 1
                    text: "Locked"

                    action: wheelLockLocked
                }

                Button {
                Layout.fillWidth: true
                    highlighted: lockState == 0
                    text: "Unlocked"

                    action: wheelLockUnlocked
                }

                Text {
                    text: "Ride Mode"
                    font.bold: true
                    Layout.columnSpan: 2
                    color: colorText
                }

                Button {
                Layout.fillWidth: true
                    highlighted: modeState == 1
                    text: "1 Compliant"

                    action: mode1
                }

                Button {
                Layout.fillWidth: true
                    highlighted: modeState == 2
                    text: "2 Unlimited"

                    action: mode2
                }

                //}
            }
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