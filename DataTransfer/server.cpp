#include "server.h"
#include <QDataStream>
//#include "socketconnection.h"

Server::Server(QObject *parent) : QTcpServer(parent), isstatusok(false)
{

}

Server::Server(QString port, QObject *parent) : QTcpServer(parent), isstatusok(false)
{
    qDebug() << "Creating server, port will be " << port;
    //serverstatus = Initialising;

    connect(this, SIGNAL(newConnection()), this, SLOT(onNewConnection()));


    if(this->listen(QHostAddress::Any, port.toInt()))
    {
        qDebug() << "Server started.";
        this->isstatusok = true;
    }
    else
    {
        qDebug() << "Failed to start server!";
        this->isstatusok = false;
    }
}

//void Server::newConnRequest(qintptr socketdescription)
//{
    //SocketConnection *conn = new SocketConnection();
    //conn->setSocketDescriptor(socketdescription);
    //emit gotNewConn(conn);
//}

bool Server::status()
{
    return this->isstatusok;
}

void Server::onNewConnection()
{
    socket = new QTcpSocket();

    socket = this->nextPendingConnection();
    qDebug() << "onNewConnection..";
    receiveData();
//    // TEST
//    // socket->write(QString("Heps sanoo serveri").toLatin1());

//    Status::Protocol protocol;
//    /// Test Data, use the actual data instead
//        protocol.type = Status::Shooting;
//        protocol.shot.ammo = Status::Normal;
//        protocol.shot.coordx = 5;
//        protocol.shot.coordy = 6;

//    /// Test Data end


//    QByteArray byteArray;

//    QDataStream stream(&byteArray, QIODevice::WriteOnly);
//    stream.setVersion(QDataStream::Qt_5_0);
//    quint16 datasize = 0; //we dont have the  size yet
//    stream << datasize << quint16(protocol.type) << quint16(protocol.shot.ammo) << quint16(protocol.shot.coordx) << quint16(protocol.shot.coordy);

//    stream.device()->seek(0); //Go to the point of the datasize (the '0' we set before)
//    stream << quint16(byteArray.size() - sizeof(quint16));

//    qDebug() << "Bytes to write from server: " <<  socket->bytesToWrite();
//    socket->write(byteArray);

//    socket->flush();
//    socket->bytesToWrite();
//    socket->waitForConnected(2000);
//    socket->close();
    // TEST END
}

void Server::sendData(Status::Protocol &protocol)
{
    QByteArray byteArray;

    QDataStream stream(&byteArray, QIODevice::WriteOnly);
    stream.setVersion(QDataStream::Qt_5_0);
    quint16 datasize = 0; //we dont have the  size yet
    stream << datasize << quint16(protocol.type) << quint16(protocol.shot.ammo) << quint16(protocol.shot.coordx) << quint16(protocol.shot.coordy);

    stream.device()->seek(0); //Go to the point of the datasize (the '0' we set before)
    stream << quint16(byteArray.size() - sizeof(quint16));

    qDebug() << "Bytes to write from server: " <<  socket->bytesToWrite();
    socket->write(byteArray);

    socket->flush();
    socket->bytesToWrite();
    socket->waitForConnected(2000);
    socket->close();
}

void Server::receiveData()
{
    QDataStream in(socket->readAll());

    quint16 datasize;
    in >> datasize;
    Status::Protocol protocol;

    quint16 protocoltype;
    quint16 protocolammo;
    quint16 protocolcoordx;
    quint16 protocolcoordy;
    in >> protocoltype;
    in >> protocolammo;
    in >> protocolcoordx;
    in >> protocolcoordy;

    qDebug() << "Server:\n";
    qDebug() << "datasize: " << datasize;
    qDebug() << "protocol.type: " << protocoltype;
    qDebug() << "protocol.shot.ammo: " << protocolammo;
    qDebug() << "protocol.shot.coordx: " << protocolcoordx;
    qDebug() << "protocol.shot.coordy: " << protocolcoordy;

    emit protocolDataReady(protocol);

}
