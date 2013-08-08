#ifndef QMLTARGET_H
#define QMLTARGET_H

#include <QObject>
#include <QDebug>

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
    Fleet *pFleet;

public:
    explicit QMLAccess(QObject *parent = 0);

    
public slots:
    void shipMovement(int shipId, int x_coord, int y_coord) {
        qDebug() << "Ship id #" <<shipId << " moved to coords: x = " << x_coord << ", y = " << y_coord;
         }
signals:

    
};

#endif // QMLTARGET_H
