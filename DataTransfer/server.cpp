#include "server.h"
//#include "socketconnection.h"

Server::Server(QObject *parent) : QTcpServer(parent)
{

}

Server::Server(QString port, QObject *parent) : QTcpServer(parent)
{
    qDebug() << "Creating server, port will be " << port;
    //serverstatus = Initialising;

    connect(this, SIGNAL(newConnection()), this, SLOT(onNewConnection()));


    if(this->listen(QHostAddress::Any, port.toInt()))
    {
        qDebug() << "Server started.";
    }
    else qDebug() << "Failed to start server!";
}

//void Server::newConnRequest(qintptr socketdescription)
//{
    //SocketConnection *conn = new SocketConnection();
    //conn->setSocketDescriptor(socketdescription);
    //emit gotNewConn(conn);
//}

void Server::onNewConnection()
{
    QTcpSocket* socket = this->nextPendingConnection();
    qDebug() << "onNewConnection..";
    // TEST
    socket->write(QString("Heps sanoo serveri").toLatin1());
    Status::Protocol protocol;
    protocol.type = Status::Shooting;
    protocol.shot.ammo = Status::Normal;
    protocol.shot.coordx = 2;
    protocol.shot.coordx = 4;

    //socket->write() << protocol;

    socket->flush();
    socket->bytesToWrite();
    socket->waitForConnected(2000);
    socket->close();
    // TEST END
}
