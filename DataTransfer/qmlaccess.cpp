#include "qmlaccess.h"
#include "Ship.h"
#include "Fleet.h"

QMLAccess::QMLAccess(QObject *parent) :
    QObject(parent), pRootQml(0), pClient(0), pServer(0)
{
    pFleet = new Fleet();

    //Ship *shipArray[] = { new Ship(0,0,4,1), new Ship(0,2,3,1), new Ship(0,4,3,1), new Ship(0,6,2,1), new Ship(0,8,1,1) };
}

void QMLAccess::setQmlRoot(QObject *pObject)
{
    pRootQml = pObject;
}

void QMLAccess::startClient(QString ip, QString port)
{
    qDebug() << "Start the client!";
    pClient = new Client(ip, port.toInt());
}

void QMLAccess::startServer(QString port)
{
    qDebug() << "Start the server!";
    pServer = new Server(port);
}

/**
 * @brief   QMLAccess::shipMovement.
 *          Ship movement in UI triggers this function to check action against game engine
 *          and then providing information back to UI.
 *
 * @param shipId    qml ship id
 */
void QMLAccess::shipMovement(int shipId)
{
    //qDebug() << "Ship id #" <<shipId << ". moved";

    int x_coord, y_coord, x_length, y_length = 0;
    getShipProperties(shipId, x_coord, y_coord, x_length, y_length);


    qDebug() << "[Engine] Ship #" << shipId << " coordX: " << x_coord << ", coordY: " << y_coord
             << ", lengthX: " << x_length << ", lengthY: " << y_length;
    /*
    QVariant x = 1;
    QVariant y = 2;
    QVariant horizontal = 3;

    QMetaObject::invokeMethod(pShip, "setCoords", Q_ARG(QVariant, x), Q_ARG(QVariant, y), Q_ARG(QVariant, horizontal));
    */
    //pShip->setProperty("targetX", x_coord + 1);
    //pShip->setProperty("targetY", y_coord + 1);


}

void QMLAccess::addShipToFleet(int shipId)
{
    int x_coord, y_coord, x_length, y_length = 0;
    getShipProperties(shipId, x_coord, y_coord, x_length, y_length);

    qDebug() << "[Engine] Adding Ship #" << shipId << " to Fleet!";

    qDebug() << "[Engine] Ship #" << shipId << " coordX: " << x_coord << ", coordY: " << y_coord
             << ", lengthX: " << x_length << ", lengthY: " << y_length;

    if (pFleet->addShip(new Ship(x_coord, y_coord, x_length, y_length)))
    {
        qDebug() << "\tSuccess";
    }
    else
        qDebug() << "\tFailed";

}


void QMLAccess::getShipProperties(int &shipid, int &x_coord, int &y_coord, int &x_length, int &y_length)
{
    QString strShip = QString("ship%1").arg(shipid);
    QObject *pShip = pRootQml->findChild<QObject *>(strShip);
    if (!pShip)
    {
        qDebug() << "No" << strShip << " found!!!";
        return;
    }

    // Now we have access to ship thorugh QObject pShip and can read properties from ship
    x_coord = pShip->property("coordX").toInt();
    y_coord = pShip->property("coordY").toInt();
    x_length = pShip->property("lengthX").toInt();
    y_length = pShip->property("lengthY").toInt();
}
