#include "qmlaccess.h"
#include "Ship.h"
#include "Fleet.h"

QMLAccess::QMLAccess(QObject *parent) :
    QObject(parent), pRootQml(0)
{
    pFleet = new Fleet();

    Ship *shipArray[] = { new Ship(0,0,4,1), new Ship(0,2,3,1), new Ship(0,4,3,1) };
}

void QMLAccess::setQmlRoot(QObject *pObject)
{
    pRootQml = pObject;
}

void QMLAccess::startClient(QString, QString)
{
    qDebug() << "Start the client!";
}

void QMLAccess::startServer(QString)
{
    qDebug() << "Start the server!";
}

void QMLAccess::shipMovement(int shipId, int x_coord, int y_coord)
{
    qDebug() << "Ship id #" <<shipId << " moved to coords: x = " << x_coord << ", y = " << y_coord;

    QString strShip = QString("ship%1").arg(shipId);
    QObject *pShip = pRootQml->findChild<QObject *>(strShip);
    if (!pShip)
    {
        qDebug() << "no ship0 found!!!";
        return;
    }

    qDebug() << "Found sibling!";

    QVariant x = 1;
    QVariant y = 2;
    QVariant horizontal = 3;

    QMetaObject::invokeMethod(pShip, "setCoords", Q_ARG(QVariant, x), Q_ARG(QVariant, y), Q_ARG(QVariant, horizontal));
    //pShip->setProperty("targetX", x_coord + 1);
    //pShip->setProperty("targetY", y_coord + 1);


}
