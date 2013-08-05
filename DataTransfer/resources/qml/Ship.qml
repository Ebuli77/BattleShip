import QtQuick 2.0

Item {
    id: currentShipId
    //signal clicked(color shipColor)
    width: 200
    height: 50

    state: "UNPLACED"

    property bool horizontalPlacement: true

    //these are for setting origin in parent
    property int offsetX: 0
    property int offsetY: 0

    // ship coordinates in the fleet
    property int targetX: 0
    property int targetY: 0

    // triggers placing animation
    property bool triggerPlacing: false
    property bool runPlacing: false

    // if horizontalPlacement == false then this is 90
    property int shipAngle: 0

    Image {
        width: parent.width; height: parent.height
        source: "row.png"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: parent
        drag.axis: Drag.XAndYAxis
        drag.minimumX: 0

        onDoubleClicked: {

            horizontalPlacement = !horizontalPlacement;
            shipAngle = horizontalPlacement?0:90;

        }

    }

    NumberAnimation on x {
        running: currentShipId.runPlacing
        //from: ship4.x;
        to: currentShipId.targetX * currentShipId.height + offsetX
        duration: 2500
        easing.type: Easing.OutExpo
    }

    NumberAnimation on y {
        running: currentShipId.runPlacing//placeShipsRunning
        //from: ship4.x;
        to: currentShipId.targetY * currentShipId.height + offsetY
        duration: 2500
        easing.type: Easing.OutExpo
    }

    Behavior on shipAngle {
        NumberAnimation { duration: 500}
    }

    transform : Rotation {
        id: rotationId
        origin.x: currentShipId.height/2
        origin.y: currentShipId.height/2
        angle: shipAngle
    }

    states: [
        State {
            name: "UNPLACED"
            PropertyChanges { target: currentShipId; shipAngle: 0}
        },
        State {
            name: "PLACED"
            PropertyChanges { target: currentShipId; shipAngle: horizontalPlacement?0:90}
        }
    ]


    transitions: [
        Transition {
            from: "*"
            to: "PLACED"
            NumberAnimation { properties: "shipAngle"; easing.type: Easing.OutExpo; duration: 2500 }
        },
        Transition {
            from: "*"
            to: "UNPLACED"
            NumberAnimation { properties: "shipAngle"; easing.type: Easing.OutExpo; duration: 2500 }
        }
    ]

    onTriggerPlacingChanged: {

        runPlacing = triggerPlacing;
        state = "PLACED";
    }
}


