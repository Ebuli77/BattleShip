/*
 * Ship.cpp
 *
 *  Created on: Jun 4, 2013
 *      Author: opi
 */

#include <iostream>
#include <QDebug>
#include "Ship.h"

using namespace std;


//Ship::Ship(QObject *parent) : QObject(parent), _size(0), _state(Ship::E_MISSED)
Ship::Ship() : _size(0), _state(Ship::E_MISSED)
{
	coords._x_coord = 0; coords._y_coord = 0; coords._x_length = 0; coords._y_length = 0;
	// create a blank board
	clearArray();
}

/**
 * Constructor
 *
 * set ships shape/size.
 */
Ship::Ship(int x_length, int y_length)
{
	coords._x_coord = 0; coords._y_coord = 0;
	setShip(x_length, y_length);
}

/**
 * Constructor
 *
 * Sets ship orientation, size and coordinates at map.
 *
 */
Ship::Ship(int x_coord, int y_coord, int x_length, int y_length) :
													_state(Ship::E_MISSED)
{
	coords._x_coord = x_coord; coords._y_coord = y_coord;
	setShip(x_length, y_length);
}


Ship::~Ship() {
	// TODO Auto-generated destructor stub
}

//Ship::hitstatus Ship::shootCoord(int x, int y, bool into_status)
Ship::hitstatus Ship::shootCoord(int x, int y, bool into_status, Ship *p_ship)
{
	/*
	cout <<"\n\nShip shootCoord( " << x << " , " << y << " )" << endl;
	cout <<"   ship coords [x = " << coords._x_coord << "] [y = " << coords._y_coord <<"]" << endl;
	 */
	// TEST!!!

	if (this == p_ship)
		return Ship::E_MISSED;


	if (!_size && into_status)
		return Ship::E_SANK; //< already has sunk

	if ( (x > (coords._x_coord + coords._x_length)) || (y > (coords._y_coord + coords._y_length)) )
		return Ship::E_MISSED;
	else if ( (x < coords._x_coord) || (y < coords._y_coord) )
		return Ship::E_MISSED;

	//check if hit is inside the ship area where ship parts exist
	if (_ship_array[y - coords._y_coord][x - coords._x_coord])
	{
		// this is for testing if ship is in the area, not shooting it
		if (!into_status)
			return Ship::E_HIT;

        qDebug() << "   hit => _ship_array[" << y << " - " << coords._y_coord << "][" << x << " - " << coords._x_coord << "]" << endl;

		_ship_array[y - coords._y_coord][x - coords._x_coord] = 0; ///< mark as dead part

		//if (into_status)
		_state = Ship::E_HIT;

		if (!(--_size))
		{
			_state = Ship::E_SANK;
            qDebug() << "   sank => _ship_array[" << y << " - " << coords._y_coord << "][" << x << " - " << coords._x_coord << "]" << endl;
		}

		return _state;
	}

	return Ship::E_MISSED;
}

Ship::hitstatus Ship::getStatus()
{
	return _state;
}
bool Ship::setCoord(int x_coord, int y_coord)
{
	coords._x_coord = x_coord;
	coords._y_coord = y_coord;

	return true;
}

/**
 * Configure ship parameters.
 *
 */
bool Ship::setShip(int x_length, int y_length)
{
	//check if ship is too big or zero sized
	if ( ((x_length > maxXSize) || (y_length > maxYSize)) || (!x_length) || (!y_length))
	{
		_size = 0;
		_state = Ship::E_SANK; //< sank already
		return false;
	}

	coords._x_length = x_length;
	coords._y_length = y_length;

    qDebug() << "Ship location [x = " << coords._x_coord <<"] [y = " << coords._y_coord << "]" << endl;

	setShootArray();

	_size = x_length * y_length;

	return true;
}

void Ship::setShootArray()
{
	clearArray();

	//reserve space for ship in array
	for (int y = 0; y < coords._y_length; y++)
	{
		for (int x = 0; x < coords._x_length; x++)
		{
			_ship_array[y][x] = 1;

            //qDebug() <<" _ship_array[" << y << "][" << x << "] = 1" << endl;
		}
	}
}

/**
 * Flips ship position at its place.
 *
 * @return ShipCoord structure holding flipped ship shape
 */
ShipCoord Ship::flipShip()
{
	int temp_coord_val = coords._x_length;
	coords._x_length = coords._y_length;
	coords._y_length = temp_coord_val;

	// update shooting array
	setShootArray();
	return coords;
}

void Ship::clearArray()
{
	for (int y = 0; y < maxYSize; y++)
	{
		for (int x = 0; x < maxXSize; x++)
		{
			_ship_array[y][x] = 0;
		}
	}
}
