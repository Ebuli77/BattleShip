import QtQuick 2.0

Rectangle {
    id: gameBoardId
    width: 700
    height: 250

    z: -5
    color: "lightgray"

    // Ship size config
    property int shipUnitLength : (gameBoardId.height + 20)/(2*10)

    property int shipHeight : (gameBoardId.height + 20)/(2*10)//20
    property int shipWidth : shipHeight * 4

    property bool startedAsServer: false
    property bool startedAsClient: false

    property bool gameStarted: false;

    /////////////////


    Rectangle {

        id: startupView
        width: 800
        height: 480
        //color: "darkgrey"
        z: +15

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#8C8F8C" }
            GradientStop { position: 0.17; color: "#6A6D6A" }
            GradientStop { position: 0.98;color: "#3F3F3F" }
            GradientStop { position: 1.0; color: "#0e1B20" }
        }

        Text{
            anchors.top: parent.top
            anchors.verticalCenter: parent.center
            anchors.horizontalCenter: parent.horizontalCenter
            color: "lightgray"
            font.pixelSize: 26
            text: "Battleship Online"
        }

        Row{
            anchors.centerIn: parent
            spacing: parent.width/12

            Rectangle {
                id: buttonServer
                color: "lightgrey"
                width: 150; height: 75

                Text{
                    anchors.centerIn: parent
                    font.pixelSize: 12
                    text: "Start the game as Server"
                }

                MouseArea{
                    id: buttonServerMouseArea
                    hoverEnabled: true

                    onEntered: parent.border.color = "gold"
                    onExited:  parent.border.color = "white"
                    anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
                    //onClicked handles valid mouse button clicks
                    onClicked:
                    {
                        console.log("Server clicked" ),
                                startupView.visible = false,
                                startedAsServer = true
                    }
                }
            }

            Rectangle {
                id: simplebutton
                color: "lightgrey"
                width: 150; height: 75

                Text{
                    anchors.centerIn: parent
                    font.pixelSize: 12
                    text: "Start the game as Client"
                }

                MouseArea{
                    id: buttonClientMouseArea
                    hoverEnabled: true
                    onEntered: parent.border.color = "gold"
                    onExited:  parent.border.color = "white"
                    anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
                    //onClicked handles valid mouse button clicks
                    onClicked: {
                        console.log("Client clicked" ),
                                startupView.visible = false,
                                startedAsClient = true
                    }
                }
            }
        }
    }

    /////////////////


    //signal qmlSignal(string msg)
    signal shipMovedSignal(int shipId)
    signal addShipToFleetSignal(int shipId)
    signal shootCoords(int x_coord, int y_coord)

    signal startClientSignal(string ip, string port)
    signal startServerSignal(string port)

    //Row {
    //    opacity: 1
    Rectangle {
        id: shipRectId
        objectName: "shipRectId"
        color: parent.color
        height: gameBoardId.height
        width: gameBoardId.shipWidth
        z:1
        //z:-4

        property bool placeShipsRunning: false

        /*
        Column {
            id : shipContainer
            objectName: "shipContainer"
            spacing: 5
            //anchors.left: gameBoardId.left
            property int shipWidth: gameBoardId.shipWidth
            property int shipHeight: gameBoardId.shipHeight
        */
            Ship {
                id : ship0
                shipid: 0
                objectName: "ship" + shipid

                //anchors.top: shipRectId.top

                unitLength: gameBoardId.shipUnitLength

                width : gameBoardId.shipUnitLength * 4
                height : gameBoardId.shipUnitLength * 1

                originX: gameRectId.x
                originY: gameRectId.y

                coordX: 0
                coordY: 0

                lengthX: 4
                lengthY: 1

                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid)
                onAddShipToFleetSignal: gameBoardId.addShipToFleetSignal(shipid)

            }
            Ship {
                id : ship1
                shipid: 1
                objectName: "ship" + shipid

                /*
                anchors.top: ship0.bottom
                anchors.topMargin: 5
                */
                x: 0
                y: height + 5;

                unitLength: gameBoardId.shipUnitLength

                width : gameBoardId.shipUnitLength * 3
                height : gameBoardId.shipUnitLength * 1

                originX: gameRectId.x
                originY: gameRectId.y

                coordX: 2
                coordY: 2
                lengthX: 3
                lengthY: 1

                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid)
                onAddShipToFleetSignal: gameBoardId.addShipToFleetSignal(shipid)
            }
            Ship {
                id : ship2
                shipid: 2
                objectName: "ship" + shipid

                /*
                anchors.top: ship1.bottom
                anchors.topMargin: 5
                */

                x: 0
                y: (height + 5)*2;

                unitLength: gameBoardId.shipUnitLength

                width : gameBoardId.shipUnitLength * 2
                height : gameBoardId.shipUnitLength * 1

                originX: gameRectId.x
                originY: gameRectId.y

                coordX: 4
                coordY: 4
                lengthX: 2
                lengthY: 1

                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid)
                onAddShipToFleetSignal: gameBoardId.addShipToFleetSignal(shipid)
            }
            Ship {
                id : ship3
                shipid: 3
                objectName: "ship" + shipid

                /*
                anchors.top: ship2.bottom
                anchors.topMargin: 5
                */

                x: 0
                y: (height + 5)*3;

                unitLength: gameBoardId.shipUnitLength

                width : gameBoardId.shipUnitLength * 2
                height : gameBoardId.shipUnitLength * 1

                originX: gameRectId.x
                originY: gameRectId.y

                coordX: 6
                coordY: 6
                lengthX: 2
                lengthY: 1

                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid)
                onAddShipToFleetSignal: gameBoardId.addShipToFleetSignal(shipid)
            }
            Ship {
                id : ship4
                shipid: 4
                objectName: "ship" + shipid

                /*
                anchors.top: ship3.bottom
                anchors.topMargin: 5
                */

                x: 0
                y: (height + 5)*4;

                unitLength: gameBoardId.shipUnitLength

                width : gameBoardId.shipUnitLength * 1
                height : gameBoardId.shipUnitLength * 1

                originX: gameRectId.x
                originY: gameRectId.y

                coordX: 8
                coordY: 8
                lengthX: 1
                lengthY: 1

                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid)
                onAddShipToFleetSignal: gameBoardId.addShipToFleetSignal(shipid)
            }
        /*
        } //column
        */
    }

    /*
    Button {
        anchors.bottom: shipRectId.bottom
        z: 1
        text: "Randomize"
        width: shipRectId.width
        onClicked: {
            if (!shipRectId.placeShipsRunning)
                shipRectId.placeShipsRunning = true;
            else
                shipRectId.placeShipsRunning = false;

            console.log("jou")
        }
    }
    */

    Rectangle {
        color: parent.color
        id: spacerOneId
        width: 20
        anchors.left:shipRectId.right
    }

    Rectangle {
        id: gameRectId
        z: 0
        color: parent.color
        height: gameBoardId.shipHeight * 10
        width: gameBoardId.shipHeight * 10
        anchors.top: parent.top
        //anchors.left: shipRectId.right
        anchors.left: spacerOneId.right

        GameGrid {
            id: gameAreaId

            gameStarted: false
            isOpponent: false

            gridHeight: gameBoardId.shipHeight * 10
            gridWidth: gameBoardId.shipHeight * 10
        }
        Text {
            id: playerTextId
            anchors.top: parent.bottom
            font.pixelSize: 26
            text: qsTr("Your fleet")
        }
    }

    Text {
        id: gameStatusTextId
        anchors.top: gameRectId.bottom
        anchors.left: spacerOneId.right
        anchors.topMargin: 30
        anchors.leftMargin: 30
        font.pixelSize: 50
        text: qsTr("Place Your Ships!")
    }

    Rectangle {
        color: parent.color
        id: spacerTwoId
        width: 20
        anchors.left:gameRectId.right
    }

    //shooting range!!
    Rectangle {
        id: shootRectId
        z: 0
        color: parent.color
        height: gameBoardId.shipHeight * 10
        width: gameBoardId.shipHeight * 10
        //y: 20
        anchors.left: spacerTwoId.right

        GameGrid {
            id: shootAreaId

            gameStarted: false
            isOpponent: true

            gridHeight: gameBoardId.shipHeight * 10
            gridWidth: gameBoardId.shipHeight * 10
        }
        Text {
            anchors.top: parent.bottom
            font.pixelSize: 26
            text: qsTr("Opponent's fleet")
        }

        Component.onCompleted: {
            shootAreaId.shootCoords.connect(shootCoords);
        }
    }

    Rectangle {
        color: parent.color
        id: spacerThreeId
        width: 20
        anchors.left:shootRectId.right
    }

    Rectangle {
        id: connectRectId
        color: parent.color
        anchors.top: parent.top
        anchors.left: spacerThreeId.right
        height: parent.height
        width: parent.width/6


        Column {
            spacing: 5

            Rectangle {
                visible: startedAsServer? false : true;
                width: connectRectId.width
                height: 20
                TextInput {
                    id: ipaddresstext
                    text: "Ip address:"
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {ipaddresstext.text = "", parent.focus = true}
                    }
                }

            }

            Rectangle {
                width: connectRectId.width
                height: 20
                TextInput {
                    id: porttext
                    text: "Port number:"
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {porttext.text = "", parent.focus = true}
                    }
                }
            }

            Button {
                text: "Connect"
                width: connectRectId.width
                onClicked: {
                    console.log("This is to Connection manager!");

                    startedAsServer? gameBoardId.startServerSignal(porttext.text) : gameBoardId.startClientSignal (ipaddresstext.text, porttext.text);

                    // Give user information about game status.
                    gameStatusTextId.text = qsTr("Connecting...");

                    // inform all components that game has started
                    gameBoardId.gameStarted = true;
                }
            }

        }

    }



    //} // Row
}
