import QtQuick 2.0
Item {
    id: gameId

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
                        anchors.fill: parent
                        source : "Blue_Water.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        //hoverEnabled: true
                        onPressed:{
                            //console.log(seaTile.x/10)
                            console.log("Im grid index nbr:" + index)
                            console.log("Grid coords are x:" + seaTile.x + " , y:" + seaTile.y)
                        }
                        //onEntered:{console.log("little-enter")}

                    }
                }
            }

        }
    }
}
