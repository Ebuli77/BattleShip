import QtQuick 2.0

Item {
    id: currentShipId
     //signal clicked(color shipColor)
    width: 200
    height: 50

    state: "UNPLACED"

    property int shipid: 0
    //these are for setting origin in parent
    property int originX: 0
    property int originY: 0

    property int startX: 0
    property int startY: 0

    /////////////////////////////////////////////
    // ship coordinates in the fleet
    property int coordX: 0
    property int coordY: 0

    property int lengthX: 0
    property int lengthY: 0
    /////////////////////////////////////////////

    // triggers placing animation
    property bool triggerPlacing: false
    property bool runPlacing: false

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

            if (shipAngle == 0)
                shipAngle = 90;
            else
                shipAngle = 0;

        }

        onReleased: {
            /*
            console.log("Current coords are : x = " + currentShipId.x + ", y = " + currentShipId.y);
            console.log("offset x = " + originX + ", y = " + originY);
            */
            startGridSnap();

            currentShipId.x = currentShipId.coordX * currentShipId.height + originX;
            currentShipId.y = currentShipId.coordY * currentShipId.height + originY;

            shipMoveSignal();

        }
    }

    function setCoords(x_coord, y_coord, horizontal)
    {
        console.log("Ship #" + shipid + ". C++ set coords x = " + x_coord + ", y = " + y_coord + ", horizontal = " + horizontal);
    }

    /*
    // testing
    oncoordXChanged: {
        currentShipId.x = currentShipId.coordX * currentShipId.height + originX;
        currentShipId.y = currentShipId.coordY * currentShipId.height + originY;
    }

    // testing
    oncoordYChanged: {
        currentShipId.x = currentShipId.coordX * currentShipId.height + originX;
        currentShipId.y = currentShipId.coordY * currentShipId.height + originY;
    }
    */
    // Places Ship to grid
    function startGridSnap() {
        console.log("startGridSnap()");
        for (x_looper = originX; x_looper < (currentShipId.height * 10 + originX); x_looper += currentShipId.height)
        {
            for (y_looper = originY; y_looper < (currentShipId.height * 10 + originY); y_looper += currentShipId.height)
            {
                if ( (currentShipId.x > x_looper) && (currentShipId.x < (x_looper + currentShipId.height))
                        && (currentShipId.y > y_looper) && (currentShipId.y < (y_looper + currentShipId.height)) )
                {
                    console.log("Ship is inside limits x: " + x_looper + " - " + (x_looper + currentShipId.height) +
                                " and y: " + y_looper + " - " + (y_looper + currentShipId.height));

                    /*
                    console.log("coordinates are grid x: " + ((x_looper - originX)/currentShipId.height) );
                    console.log("coordinates are grid y: " + ((y_looper - originY)/currentShipId.height) );
                    */
                    currentShipId.coordX = (x_looper - originX)/currentShipId.height;
                    currentShipId.coordY = (y_looper - originY)/currentShipId.height;

                    return;
                }
            }
        }
        console.log("Ship is off the course!!!!");
    }

    /*
    NumberAnimation on x {
        running: currentShipId.runPlacing
        //from: ship4.x;
        to: currentShipId.coordX * currentShipId.height + originX
        duration: 2500
        easing.type: Easing.OutExpo
    }

    NumberAnimation on y {
        running: currentShipId.runPlacing//placeShipsRunning
        //from: ship4.x;
        to: currentShipId.coordY * currentShipId.height + originY
        duration: 2500
        easing.type: Easing.OutExpo
    }
    */

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
            PropertyChanges { target: currentShipId; x: startX; y: startY}
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
            NumberAnimation { properties: "x"; easing.type: Easing.OutExpo; duration: 2500 }
            NumberAnimation { properties: "y"; easing.type: Easing.OutExpo; duration: 2500 }
        }
    ]

    onTriggerPlacingChanged: {

        /*
        runPlacing = triggerPlacing;
        state = "PLACED";
        */
    }

    // Run only once in startup

    Component.onCompleted: {
        console.log("Ship #" + shipid + " start coords x:" + currentShipId.x + ", y:" + currentShipId.y);
        startX = currentShipId.x;
        startY = currentShipId.y;
    }



}


