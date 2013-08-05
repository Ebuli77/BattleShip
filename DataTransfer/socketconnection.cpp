#include "socketconnection.h"

SocketConnection::SocketConnection()
{

}

SocketConnection::SocketConnection(QHostAddress ip, unsigned int port)
{
    this->opponent_ip = ip;
    this->opponent_port = port;
}

SocketConnection::SocketConnection(QString ip, unsigned int port)
{
    this->opponent_ip.setAddress(ip);
    this->opponent_port = port;
}

bool SocketConnection::sendMessage(QString &msg)
{
    if (msg.isEmpty())
        return false;

    QByteArray message = msg.toUtf8();
    QByteArray data = QByteArray::number(msg.size()) + ' ' + message;
    return write(data) == data.size();
}
