#include "client.h"
#include <QDebug>
#include <QDataStream>

Client::Client(QObject *parent) :
    QObject(parent), isstatusok(false)
{

}

Client::Client(QString ip, unsigned int port): isstatusok(false)
{
    qDebug() << "creating client with ip " << ip << " and port " << port;


    socket = new QTcpSocket(this);

     connect(socket, SIGNAL(readyRead()), this, SLOT(receiveData()));

    socket->connectToHost(ip, port);
    if(!socket->waitForConnected(5000))
    {
        qDebug() << "Client failed to connect!";
        this->isstatusok = false;
    }
    else
    {
        qDebug() << "Client connected!";
        this->isstatusok = true;
    }

}

bool Client::status()
{
    return this->isstatusok;
}

QString Client::playerName()
{
    return this->playername;
}

void Client::receiveData()
{
    //clientstatus = Initialising;

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

    qDebug() << "Client:\n";
    qDebug() << "datasize: " << datasize;
    qDebug() << "protocol.type: " << protocoltype;
    qDebug() << "protocol.shot.ammo: " << protocolammo;
    qDebug() << "protocol.shot.coordx: " << protocolcoordx;
    qDebug() << "protocol.shot.coordy: " << protocolcoordy;

    emit protocolDataReady(protocol);

}

void Client::sendData(Status::Protocol &protocol)
{
    qDebug() << "Client::sendData()";

    QByteArray byteArray;

    QDataStream stream(&byteArray, QIODevice::WriteOnly);
    stream.setVersion(QDataStream::Qt_5_0);
    quint16 datasize = 0; //we dont have the  size yet
    stream << datasize << quint16(protocol.type) << quint16(protocol.shot.ammo) << quint16(protocol.shot.coordx) << quint16(protocol.shot.coordy);

    stream.device()->seek(0); //Go to the position of the datasize (the '0' we set before)
    stream << quint16(byteArray.size() - sizeof(quint16));

    qDebug() << "Bytes to write from client: " <<  socket->bytesToWrite();
    socket->write(byteArray);

    socket->flush();
    socket->bytesToWrite();
    socket->waitForConnected(2000);
    socket->close();

}
