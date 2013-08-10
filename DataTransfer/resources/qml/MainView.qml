import QtQuick 2.0

Rectangle {
    id: gameBoardId
    width: 700
    height: 250

    z: -5
    color: "lightgray"
    property int shipHeight : (gameBoardId.height + 20)/(2*10)//20
    property int shipWidth : shipHeight * 4

    property bool startedAsServer: false
    property bool startedAsClient: false

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
    signal shipMovedSignal(int shipId, int x_coord, int y_coord)
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
        Column {
            id : shipContainer
            objectName: "shipContainer"
            spacing: 5
            //anchors.left: gameBoardId.left
            property int shipWidth: gameBoardId.shipWidth
            property int shipHeight: gameBoardId.shipHeight

            Ship {
                id : ship0
                shipid: 0
                objectName: "ship0"

                width : parent.shipWidth
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 0
                targetY: 0
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
                horizontalPlacement: true
            }
            Ship {
                id : ship1
                shipid: 1
                objectName: "ship" + shipid

                width : parent.shipWidth*3/4
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 2
                targetY: 2
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
                horizontalPlacement: true
            }
            Ship {
                id : ship2
                shipid: 2
                objectName: "ship" + shipid

                width : parent.shipWidth/2
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 4
                targetY: 4
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
                horizontalPlacement: true
            }
            Ship {
                id : ship3
                shipid: 3
                objectName: "ship" + shipid

                width : parent.shipWidth/2
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 6
                targetY: 6
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
                horizontalPlacement: true
            }
            Ship {
                id : ship4
                shipid: 4
                objectName: "ship" + shipid

                width : parent.shipWidth/4
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 8
                targetY: 8
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
                horizontalPlacement: true
            }

        } //Grid ships
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
            gridHeight: gameBoardId.shipHeight * 10
            gridWidth: gameBoardId.shipHeight * 10
            /*
                    height: 500
                    width: 500
                    */
            id: gameAreaId
            //anchors.right: gameBoardId.right
        }
        Text {
            anchors.top: parent.bottom
            font.pixelSize: 26
            text: qsTr("Your fleet")
        }
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
        z: 7
        color: parent.color
        height: gameBoardId.shipHeight * 10
        width: gameBoardId.shipHeight * 10
        //y: 20
        anchors.left: spacerTwoId.right

        GameGrid {
            gridHeight: gameBoardId.shipHeight * 10
            gridWidth: gameBoardId.shipHeight * 10
            /*
                    height: 500
                    width: 500
                    */
            id: shootAreaId
            //anchors.right: gameBoardId.right
        }
        Text {
            anchors.top: parent.bottom
            font.pixelSize: 26
            text: qsTr("Opponent's fleet")
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
        width: parent.width/4

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
                    console.log("This is to Connection manager!")
                    //gameBoardId.qmlSignal("Hou")
                    startedAsServer? gameBoardId.startServerSignal(porttext.text) : gameBoardId.startClientSignal (ipaddresstext.text, porttext.text);
                }
            }

        }

    }

    //} // Row
}
