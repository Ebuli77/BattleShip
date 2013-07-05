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
    //void sendMsg(QString msg);

signals:
    void gotMsg(QString msg);


private slots:
    //void newConn(SocketConnection *conn);
    //void connectionClosed();


private:

    Server server;
    //ConnManager *manager;
    QString playername;
    QTcpSocket *socket;

    //StatusEnum clientstatus;



};

#endif // CLIENT_H
