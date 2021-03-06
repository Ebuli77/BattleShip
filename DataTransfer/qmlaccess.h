#ifndef QMLTARGET_H
#define QMLTARGET_H

#include <QObject>
#include <QDebug>

#include "client.h"
#include "server.h"

#include "status.h"

/**
 * @brief   The QMLAccess class is aggregate class holding BattleShip games Fleet with ships.
 *
 *
 */

class Fleet;

class QMLAccess : public QObject
{
    Q_OBJECT

private:
    QObject *pRootQml;
    Client *pClient;
    Server *pServer;
    Fleet *pFleet;


    void getShipProperties(int &shipid, int &x_coord, int &y_coord, int &x_length, int &y_length);
protected:
    QObject *getShipQObj(int shipid); // returns handle to qml ship object
    void updateFleetStatus();
public:
    explicit QMLAccess(QObject *parent = 0);

    void setQmlRoot(QObject *pObject);
    
public slots:
    void shipMovement(int shipId);
    void addShipToFleet(int shipId);

    void shootFleetCoords(int x_coord, int y_coord);
    //void shootFleet(Status::Protocol &protocol);
    void startClient(QString ip, QString port);
    void startServer(QString port);
signals:

    
};

#endif // QMLTARGET_H
