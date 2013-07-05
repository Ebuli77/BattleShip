#include "client.h"
#include <QDebug>

Client::Client(QObject *parent) :
    QObject(parent)
{

}

Client::Client(QString ip, unsigned int port)
{
    qDebug() << "creating client with ip " << ip << " and port " << port;


    socket = new QTcpSocket(this);
    socket->connectToHost(ip, port);
    //clientstatus = Initialising;
    if(!socket->waitForConnected(5000))
    {
        qDebug() << "Client failed to connect!";
    }
    QByteArray array;
    array = socket->readAll();
    qDebug() << "received: " << array;
}

QString Client::playerName()
{
    return this->playername;
}
