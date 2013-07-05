import QtQuick 2.0

Rectangle {
    id: gameBoardId
    width: 600
    height: 400

    z: -5
    color: "lightgray"
    property int shipHeight : (gameBoardId.height + 20)/(2*10)//20
    property int shipWidth : shipHeight * 4


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
                width : parent.shipWidth
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 0
                targetY: 0
                placingRunning: shipRectId.placeShipsRunning

                horizontalPlacement: false
            }
            Ship {
                id : ship2
                width : parent.shipWidth*3/4
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 2
                targetY: 2
                placingRunning: shipRectId.placeShipsRunning
            }
            Ship {
                id : ship3
                width : parent.shipWidth/2
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 4
                targetY: 4
                placingRunning: shipRectId.placeShipsRunning
            }
            Ship {
                id : ship4
                width : parent.shipWidth/2
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 6
                targetY: 6
                placingRunning: shipRectId.placeShipsRunning

            }
            Ship {
                id : ship5
                width : parent.shipWidth/4
                height : parent.shipHeight

                offsetX: gameRectId.x
                offsetY: gameRectId.y

                targetX: 8
                targetY: 8
                placingRunning: shipRectId.placeShipsRunning
                horizontalPlacement: false
            }

        } //Grid ships
    }
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
        height: parent.height
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

    //shooting range!!
    Rectangle {
        id: shootRectId
        z: 7
        color: parent.color
        height: parent.height
        width: gameBoardId.shipHeight * 10
        anchors.top: gameRectId.bottom
        anchors.left: shipRectId.right

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
        id: spacerTwoId
        width: 20
        anchors.left:gameRectId.right
    }

    Rectangle {
        id: connectRectId
        color: parent.color
        anchors.top: parent.top
        anchors.left: spacerTwoId.right
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
                }
            }

        }

    }

    //} // Row
}
