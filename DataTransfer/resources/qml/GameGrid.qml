import QtQuick 2.0
Item {
    id: gameId

    property bool isOpponent: false

    property int gridHeight: 300
    property int gridWidth: 300
    //property alias height: rectId.height
    //property alias width: rectId.width

    Rectangle {
        id: rectId
        //width: 500; height: 500
        width: gameId.gridWidth; height: gameId.gridHeight
        property int numOfColumns: 10
        property int numOfElements: 100
        color: "white"

        Grid {
            id: gridAreasize
            /*
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            */
            columns: rectId.numOfColumns
            spacing:0
            Repeater{model:rectId.numOfElements
                Rectangle{
                    id:seaTile;
                    height: rectId.height/rectId.numOfColumns // rectId.height/gridAreasize.columns //50 //rectId.height/gridArea.columns
                    width: rectId.width/(rectId.numOfElements/rectId.numOfColumns)//50 //rectId.width/gridArea.columns
                    border.color: "black"
                    border.width: 2
                    color:"white"
                    opacity:0.6
                    radius:5
                    Image {
                        z:0
                        anchors.fill: parent
                        source : "Blue_Water.png"
                    }
                    Image {
                        id: explodeId
                        z:1
                        anchors.fill: parent
                        source : "explode.png"
                        visible: false;
                    }

                    MouseArea{
                        anchors.fill: parent
                        //hoverEnabled: true

                        onPressed:{
                            //console.log(seaTile.x/10)
                            console.log("Im grid index nbr:" + index)
                            console.log("Grid coords are x:" + seaTile.x + " , y:" + seaTile.y)


                            // We should check if it's players turn before enabling him to shoot ( == click the tile)
                            // After the tile has been shot, the 'seaTile' can be set as "enabled = false"
                            // We should also disable all of the tiles on players fleet after the game has started (when user presses 'connect'-button)
                            // We also need a short notification for the user to see that it's his turn.
                            // There should also be an area which always indicates if it's players or the opponents turn, maybe a colored border around the fleet or something
                            // For easier implementation we should separate the qml grids for players and opponents fleets
                            // as when the game has started the interaction with them will be different from each other
                            // Thanks,
                            // -Tomi  :D

                            // Testing the possibilities on shooting at a tile coords
                            seaTile.color = "black"

                            if (isOpponent)
                                explodeId.visible = true;
                            // Hit could be just "red" tile?
                        }
                        //onEntered:{console.log("little-enter")}

                    }
                }
            }

        }
    }
}
