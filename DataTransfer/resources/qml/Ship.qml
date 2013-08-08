import QtQuick 2.0

Item {
    id: currentShipId
     //signal clicked(color shipColor)
    width: 200
    height: 50

    state: "UNPLACED"

    property int shipid: 0
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


    // Position handler variables
    property int x_looper : 0
    property int y_looper : 0

    // Signal to game engine
    signal shipMoveSignal()

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

        onReleased: {
            /*
            console.log("Current coords are : x = " + currentShipId.x + ", y = " + currentShipId.y);
            console.log("offset x = " + offsetX + ", y = " + offsetY);
            */
            startGridSnap();

            currentShipId.x = currentShipId.targetX * currentShipId.height + offsetX;
            currentShipId.y = currentShipId.targetY * currentShipId.height + offsetY;

            shipMoveSignal();

        }
    }

    function setCoords(x_coord, y_coord, horizontal)
    {
        console.log("C++ set coords x = " + x_coord + ", y = " + y_coord + ", horizontal = " + horizontal);
    }

    /*
    // testing
    onTargetXChanged: {
        currentShipId.x = currentShipId.targetX * currentShipId.height + offsetX;
        currentShipId.y = currentShipId.targetY * currentShipId.height + offsetY;
    }

    // testing
    onTargetYChanged: {
        currentShipId.x = currentShipId.targetX * currentShipId.height + offsetX;
        currentShipId.y = currentShipId.targetY * currentShipId.height + offsetY;
    }
    */
    // Places Ship to grid
    function startGridSnap() {
        console.log("startGridSnap()");
        for (x_looper = offsetX; x_looper < (currentShipId.height * 10 + offsetX); x_looper += currentShipId.height)
        {
            for (y_looper = offsetY; y_looper < (currentShipId.height * 10 + offsetY); y_looper += currentShipId.height)
            {
                if ( (currentShipId.x > x_looper) && (currentShipId.x < (x_looper + currentShipId.height))
                        && (currentShipId.y > y_looper) && (currentShipId.y < (y_looper + currentShipId.height)) )
                {
                    console.log("Ship is inside limits x: " + x_looper + " - " + (x_looper + currentShipId.height) +
                                " and y: " + y_looper + " - " + (y_looper + currentShipId.height));

                    /*
                    console.log("coordinates are grid x: " + ((x_looper - offsetX)/currentShipId.height) );
                    console.log("coordinates are grid y: " + ((y_looper - offsetY)/currentShipId.height) );
                    */
                    currentShipId.targetX = (x_looper - offsetX)/currentShipId.height;
                    currentShipId.targetY = (y_looper - offsetY)/currentShipId.height;

                    return;
                }
            }
        }
        console.log("Ship is off the course!!!!");
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
        NumberAnimation { duration: 200; easing.type: Easing.OutExpo}
    }

    Behavior on x {
        NumberAnimation { duration: 200; easing.type: Easing.OutExpo}
    }
    Behavior on y {
        NumberAnimation { duration: 200; easing.type: Easing.OutExpo}
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


