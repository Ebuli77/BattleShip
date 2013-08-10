/*
 * Fleet.h
 *
 *  Created on: Jun 4, 2013
 *      Author: opi
 *
 *      description: holds gaming area and fleet
 */

#ifndef FLEET_H_
#define FLEET_H_


#include <vector>
#include "Ship.h"


using namespace std;

const int X_MAX = 10;
const int Y_MAX = 10;

class Fleet {

private:



	vector<Ship *> *_p_fleet;
	int _x_max;
	int _y_max;

	void clearFleetArea();

public:

    //Fleet(QObject *parent = 0);
    Fleet();

    Fleet(int x, int y);
    virtual ~Fleet();

	int setSeaArea(int x, int y); 	//< set fleet's sea area

	bool addShip(Ship *p_ship); 	//< adds ship and tests fleet area for other ships
	bool removeShip(Ship *p_ship);
	int shuffleFleetAtArea(); //< randomize vessel locations into given coordinates

	bool setShipToArea(Ship *p_ship);		//< sets ship to fleet's sea
	bool testShipToSeaArea(Ship *p_ship);	//< tests if placement is possible

	Ship::hitstatus shootCoords(int x, int y, bool into_status = true, Ship *p_ship = 0);		//< fleet gets shooted at coordinates x, y
	//Ship::hitstatus shootCoords(int x, int y, bool into_status = true);		//< fleet gets shooted at coordinates x, y

	Ship *getShip(unsigned int idx);

	Ship::hitstatus getFleetStatus();
	int count();

};

#endif /* FLEET_H_ */
