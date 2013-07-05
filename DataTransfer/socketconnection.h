#ifndef SOCKETCONNECTION_H
#define SOCKETCONNECTION_H

#include <QTcpSocket>
#include <QHostAddress>

class SocketConnection: public QTcpSocket
{
public:
    SocketConnection();
    SocketConnection(QHostAddress ip, unsigned int port);
    SocketConnection(QString ip, unsigned int port);
    bool sendMessage(QString &msg);

private:
    QHostAddress opponent_ip;
    unsigned int opponent_port;
};

#endif // SOCKETCONNECTION_H
