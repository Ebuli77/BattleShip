#ifndef QMLTARGET_H
#define QMLTARGET_H

#include <QObject>
#include <QDebug>

#include "client.h"
#include "server.h"

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



public:
    explicit QMLAccess(QObject *parent = 0);

    void setQmlRoot(QObject *pObject);

    
public slots:
    void shipMovement(int shipId, int x_coord, int y_coord);
    void startClient(QString ip, QString port);
    void startServer(QString port);
signals:

    
};

#endif // QMLTARGET_H
