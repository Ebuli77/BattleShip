/*
 * Fleet.cpp
 *
 *  Created on: Jun 4, 2013
 *      Author: opi
 */
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <QDebug>
#include "Fleet.h"
#include "Ship.h"

using namespace std;

Fleet::Fleet()
{
	_x_max = X_MAX;
	_y_max = Y_MAX;

	_p_fleet = new vector<Ship *>();

	clearFleetArea();
}

Fleet::Fleet(int x, int y)
{
	_x_max = (x<=X_MAX)?x:X_MAX; //HAH
	_y_max = (y<=Y_MAX)?y:Y_MAX; //HAH

	_p_fleet = new vector<Ship *>();

	clearFleetArea();
}

Fleet::~Fleet()
{
	delete _p_fleet;
}

/**
 * Put vessels to fleets x * y area
 *
 * @return number of vessels not fitting to area
 */
int Fleet::shuffleFleetAtArea()
{
	// for time out in placing
	time_t now, start;

	srand(time(NULL));

	int failed = 0;
	int x_rand = 0;
	int y_rand = 0;
	int x_length, y_length = 0;

	clearFleetArea();

    Ship *testShip = new Ship(0,0,0,0,0); ///< generate template ship for testing area before setting ship

	for (unsigned int i = 0; i < _p_fleet->size(); i++)
	{
        qDebug() << "Placing Ship #" << i << endl;

		_p_fleet->at(i)->getShip(x_length,y_length);
		testShip->setShip(x_length,y_length);

		time(&start);
		while (true)
		{
			x_rand = rand()%_x_max;
			y_rand = rand()%_y_max;

			//_p_fleet->at(i)->getShip(x_length,y_length);

			testShip->setCoord(x_rand, y_rand);

			// try setting ship to sea area
			if (setShipToArea(testShip))
			{
                qDebug() << "Setting ship #" << i << " x_length = " << x_length << " y_length = " << y_length << " to position [x = " << x_rand << "] [y = " << y_rand << "]" <<endl;
				_p_fleet->at(i)->setCoord(x_rand, y_rand);
				break;
			}

			if (difftime(time(&now), start) > 3) //if it takes over 3 secs then fails
			{
				failed++;
				break;
			}
		}
		//succeeded++;
	}

	delete testShip; ///< remove test ship

	return failed;
	//return _p_fleet->size() - succeeded; ///< check this
}

/**
 * Set ship to given sea area.
 *
 * Ship contains its coordinates and this function tests if these coordinates
 * are possible for current ship.
 *
 * @param[in] p_ship Ship pointer
 * @return true if ship has valid coordinates, false if ship can't fit to fleet's area
 */
bool Fleet::setShipToArea(Ship *p_ship)
{
	// test if ship fits to area and set area reserved
	if ( testShipToSeaArea(p_ship) )
	{
		return true;
	}

	//Throw ship out of gaming area! Take it to the reserve
	p_ship->setCoord(_x_max,_y_max);

	return false;
}

bool Fleet::testShipToSeaArea(Ship *p_ship)
{
	int x_size, y_size = 0;
	int x_coord, y_coord = 0;

    if (!p_ship) return false;

	// get ship information coordinates and size
	p_ship->getShip(x_size, y_size);
	p_ship->getCoord(x_coord, y_coord);

	// is ship over border?
	if ( ((x_coord + x_size) > _x_max) || ((y_size + y_coord) > _y_max) )
		return false;

	// test if ship fits to area
	for (int y = y_coord; y < (y_coord + y_size); y++)
	{
		for (int x = x_coord; x < (x_coord + x_size); x++)
		{
            //qDebug() << " **** x = " << x <<", y = " << y << endl;
			// is there empty space at map
			if ( shootCoords(x,y,false,p_ship) )
			{
                qDebug() << "!!!!!" << endl;
				return false;
			}

			// test coordinates around object!!!
			if ( y > 0)
			{
				if ( shootCoords(x,y-1,false,p_ship) != Ship::E_MISSED )
					return false;
			}
			//else
			if (y < (_y_max - 1))
			{
				if ( shootCoords(x,y+1,false,p_ship) != Ship::E_MISSED )
					return false;
			}

			if (x > 0)
			{
				if ( shootCoords(x-1,y,false,p_ship) != Ship::E_MISSED )
					return false;
			}
			//else
			if (x < (_x_max - 1))
			{
				if ( shootCoords(x+1,y,false,p_ship) != Ship::E_MISSED )
					return false;
			}
		}
	}
	return true;
}

/**
 * Clear fleets sea area.
 *
 * Doesn't remove ships. Puts them to reserve out sidesea area _x_max, _y_max.
 */
void Fleet::clearFleetArea()
{
	for (unsigned int i = 0; i < _p_fleet->size(); i++)
	{
		// put all ships over the borders for replacing them back.
		_p_fleet->at(i)->setCoord(_x_max, _y_max); //
	}
}

/**
 * Resizes sea area.
 *
 * Removes ships overlapping borders.
 */
int Fleet::setSeaArea(int x, int y)
{
	/*
	int x_coord, y_coord = 0; ///< temp coordinates
	int x_length, y_length = 0;
	Ship *p_ship = new Ship(0,0,0,0);
	*/
	_x_max = x;
	_y_max = y;

    qDebug() << __FUNCTION__ << endl;
	for (unsigned int i = 0; i < _p_fleet->size(); i++)
	{
		//_p_fleet->at(i)->getCoord(x_coord,y_coord);
		//_p_fleet->at(i)->setCoord(_x_max,_y_max); // place out side

		if (!setShipToArea(_p_fleet->at(i)))
		{
            qDebug() << "  Ship #" << i << " didn't fit to new sea area!" << endl;
		}
	}
	return 0;
}

/**
 * Adds ship to game area
 *
 * Tests if ship coordinates are possible.
 *
 * @param[in] p_ship	ship pointer
 * @return 	true if ship was added to fleet with current set coordinates,
 * 			false when it was put into reserve.
 */
bool Fleet::addShip(Ship *p_ship)
{
	if ( setShipToArea(p_ship) )
	{
		_p_fleet->push_back(p_ship);
		return true;
	}
	_p_fleet->push_back(p_ship);
	return false; //< ship has been put to reserve => coordinates are x_max,y_max
}

bool Fleet::removeShip(int shipid)
{
	//_p_fleet->erase(p_ship);
    for (unsigned int i = 0; i < _p_fleet->size(); i++)
    {
        if (_p_fleet->at(i)->getId() == shipid)
        {
            qDebug() << "[Engine|Fleet] Removing Ship #" << shipid;
            _p_fleet->erase(_p_fleet->begin() + i);
            return true;
        }
    }

	return false;
}

/**
 * Returns ship at given index
 *
 * @return Ship pointer to given vector index when true, else 0
 */
Ship *Fleet::getShip(unsigned int shipid)
{
    /*
	if (idx > _p_fleet->size()) return 0;
    return _p_fleet->at(idx);*/

    for (unsigned int i = 0; i < _p_fleet->size(); i++)
    {
        if (_p_fleet->at(i)->getId() == shipid)
        {
            return _p_fleet->at(i);
        }
    }
    return 0;
}

int Fleet::count()
{
	return _p_fleet->size();
}

Ship::hitstatus Fleet::getFleetStatus()
{
	unsigned int i = 0;
	unsigned int sank_cnt = 0;
	for (i = 0; i < _p_fleet->size(); i++)
	{
		switch (_p_fleet->at(i)->getStatus())
		{
		case Ship::E_HIT:
			return Ship::E_HIT;
		case Ship::E_SANK:
			sank_cnt++;
			break;
		default:
			break;
		}
	}

	if (sank_cnt == _p_fleet->size())
		return Ship::E_SANK;

	if (sank_cnt > 0)
		return Ship::E_HIT;

	return Ship::E_MISSED;
}

/**
 * Shooting coordinates.
 *
 * @param[in] x	x-coord
 * @param[in] y	y-coord
 *
 * @return true if boat hit
 */
//Ship::hitstatus Fleet::shootCoords(int x, int y, bool into_status)
Ship::hitstatus Fleet::shootCoords(int x, int y, bool into_status, Ship *p_ship)
{
	Ship::hitstatus status = Ship::E_MISSED;

    //qDebug() << "  Shooting: **** x = " << x <<", y = " << y << endl;
    //qDebug() << "  Fleet shooting coords [x = " << x <<"][y = " << y << "]" << endl;
	for (unsigned int i = 0; i < _p_fleet->size(); i++)
	{
        //qDebug() << "  Shooting ship #" << i << " at Fleet!";
		//testing
		/*
		if (p_ship == _p_fleet->at(i))
			return Ship::E_MISSED;
		*/
		// return from first hit. it's not possible to have several ships in same coordinate
		if ( (status =  _p_fleet->at(i)->shootCoord(x,y,into_status,p_ship)) )
		{
			return status;
		}
	}
	return status;
}
