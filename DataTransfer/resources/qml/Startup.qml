import QtQuick 2.0

Rectangle {
    width: 700
    height: 250
    //color: "darkgrey"

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
                onClicked: console.log("Server clicked" )
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
                onClicked: console.log("Client clicked" )
            }
        }
    }
}
