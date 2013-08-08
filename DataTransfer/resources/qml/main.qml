import QtQuick 2.0

Rectangle {
    id: gameBoardId
    width: 700
    height: 250

    z: -5
    color: "lightgray"
    property int shipHeight : (gameBoardId.height + 20)/(2*10)//20
    property int shipWidth : shipHeight * 4

    //signal qmlSignal(string msg)
    signal shipMovedSignal(int shipId, int x_coord, int y_coord)

    //Row {
    //    opacity: 1
    Rectangle {
        id: shipRectId
        color: parent.color
        height: gameBoardId.height
        width: gameBoardId.shipWidth
        z:1
        //z:-4

        property bool placeShipsRunning: false
        Column {
            id : shipContainer
            spacing: 5
            //anchors.left: gameBoardId.left
            property int shipWidth: gameBoardId.shipWidth
            property int shipHeight: gameBoardId.shipHeight

            Ship {
                id : ship1
                shipid: 0
                width : parent.shipWidth
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 0
                targetY: 0
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
                //horizontalPlacement: false
            }
            Ship {
                id : ship2
                shipid: 1
                width : parent.shipWidth*3/4
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 2
                targetY: 2
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
            }
            Ship {
                id : ship3
                shipid: 2
                width : parent.shipWidth/2
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 4
                targetY: 4
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
            }
            Ship {
                id : ship4
                shipid: 3
                width : parent.shipWidth/2
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 6
                targetY: 6
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
            }
            Ship {
                id : ship5
                shipid: 4
                width : parent.shipWidth/4
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 8
                targetY: 8
                triggerPlacing: shipRectId.placeShipsRunning

                onShipMoveSignal: gameBoardId.shipMovedSignal(shipid,targetX,targetY)
                //horizontalPlacement: false
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
                width: connectRectId.width
                height: 20
                Text {
                    text: "Ip address:"
                }
            }

            Rectangle {
                width: connectRectId.width
                height: 20
                Text {
                    text: "Port number:"
                }
            }

            Button {
                text: "Connect"
                width: connectRectId.width
                onClicked: {
                    console.log("This is to Tomi's Connection manager!")
                    //gameBoardId.qmlSignal("Hou")
                }
            }

        }

    }

    //} // Row
}
