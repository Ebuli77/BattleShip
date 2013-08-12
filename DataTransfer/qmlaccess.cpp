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
    updateFleetStatus();
    //pClient = new Client(ip, port.toInt());
}

void QMLAccess::startServer(QString port)
{
    qDebug() << "Start the server!";
    updateFleetStatus();
    //pServer = new Server(port);
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


    qDebug() << "[Engine|QMLAccess] Moving Ship #" << shipId << " coordX: " << x_coord << ", coordY: " << y_coord
             << ", lengthX: " << x_length << ", lengthY: " << y_length;

    // get ship from fleet and set new coordinates and dimentions
    Ship *pShip = pFleet->getShip(shipId);
    pShip->setCoord(x_coord, y_coord);
    pShip->setShip(x_length, y_length);

    // test location with new settings
    if (pFleet->testShipToSeaArea(pShip))
    {
        getShipQObj(shipId)->setProperty("shipPlacedCorrectly", true);
        qDebug() << "\tNew location success!";
    }
    else
    {
        getShipQObj(shipId)->setProperty("shipPlacedCorrectly", false);
        qDebug() << "\tNew location prohibited!";
    }

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

    //qDebug() << "[Engine|QMLAccess] Adding Ship #" << shipId << " to Fleet!";

    qDebug() << "[Engine|QMLAccess] Adding Ship #" << shipId << " coordX: " << x_coord << ", coordY: " << y_coord
             << ", lengthX: " << x_length << ", lengthY: " << y_length;

    if (pFleet->addShip(new Ship(shipId, x_coord, y_coord, x_length, y_length)))
    {
        qDebug() << "\tSuccess";
    }
    else
    {
        qDebug() << "\tFailed";
    }

}

void QMLAccess::shootFleetCoords(int x_coord, int y_coord)
{
    qDebug() << "[Engine|QMLAccess] shooting coords x:" << x_coord <<", y:" << y_coord;
}

void QMLAccess::getShipProperties(int &shipid, int &x_coord, int &y_coord, int &x_length, int &y_length)
{
    //QString strShip = QString("ship%1").arg(shipid);
    //QObject *pShip = pRootQml->findChild<QObject *>(strShip);
    QObject *pQShip = getShipQObj(shipid);
    if (!pQShip)
    {
        qDebug() << "[Engine|QMLAccess] No Ship #" << shipid << " found!!!";
        return;
    }

    // Now we have access to ship thorugh QObject pShip and can read properties from ship
    x_coord = pQShip->property("coordX").toInt();
    y_coord = pQShip->property("coordY").toInt();
    x_length = pQShip->property("lengthX").toInt();
    y_length = pQShip->property("lengthY").toInt();
}

QObject *QMLAccess::getShipQObj(int shipid)
{
    QString strShip = QString("ship%1").arg(shipid);
    return pRootQml->findChild<QObject *>(strShip);
}

/**
 * @brief QMLAccess::updateFleetStatus
 *
 * Syncronizes backend with QML.
 */
void QMLAccess::updateFleetStatus()
{
    QObject *pQShip = 0;
    int shipid, countOfRemovable = 0;
    int removeArray[5] = {0};

    qDebug() << "Fleet size for removing is " << pFleet->count();
    for (unsigned int i = 0; i < pFleet->count(); i++)
    {
        shipid = pFleet->getShipAt(i)->getId();
        pQShip = getShipQObj(shipid);
        if (pQShip)
        {
            // if ship is not placed correctly then move back to start position
            if (!pQShip->property("shipPlacedCorrectly").toBool())
            {
                removeArray[countOfRemovable] = shipid;
                countOfRemovable++;

                QVariant falseVal = 0;
                pQShip->setProperty("shipAddedToFleet", falseVal);


                QMetaObject::invokeMethod(pQShip, "initStartPosition");

            }
        }
    }

    // No remove ships from fleet
    for (unsigned int i = 0; i < countOfRemovable; i++)
    {
        qDebug() << "[Engine|QMLAccess] Removing ship #" << removeArray[i];
        pFleet->removeShip(removeArray[i]);
    }
}
