#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>

//#include "socketconnection.h"
#include "server.h"
//#include "status.h"

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = 0);
    Client(QString ip, unsigned int port);

    QString playerName();
    bool status();
    //void sendMsg(QString msg);

signals:
    void gotMsg(QString msg);
    void protocolDataReady(Status::Protocol &protocol);


private slots:
    //void newConn(SocketConnection *conn);
    //void connectionClosed();
    void receiveData();
    void sendData(Status::Protocol &protocol);


private:

    Server server;
    //ConnManager *manager;
    QString playername;
    QTcpSocket *socket;
    bool isstatusok;

    //StatusEnum clientstatus;



};

#endif // CLIENT_H
