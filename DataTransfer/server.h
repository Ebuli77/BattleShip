#ifndef SERVER_H
#define SERVER_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>

//#include "socketconnection.h"
#include "status.h"

class Server : public QTcpServer
{
    Q_OBJECT

public:
    explicit Server(QObject *parent = 0);
    explicit Server(QString port, QObject *parent = 0);
    //void onNewConnection();
    
signals:
    //void gotNewConn(SocketConnection *);
    void protocolDataReady(Status::Protocol &protocol);


public slots:
   // void newConnRequest(qintptr socketdescription);
    void onNewConnection();
    void sendData(Status::Protocol &protocol);
    void receiveData();

private:
    QString port;
    QTcpSocket* socket;

    Status::StatusEnum serverstatus;

};

#endif // SERVER_H
