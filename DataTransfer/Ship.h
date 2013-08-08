/*
 * Ship.h
 *
 *  Created on: Jun 4, 2013
 *      Author: opi
 */

#ifndef SHIP_H_
#define SHIP_H_

/**
 * class to hold ships coord and size info
 */
class ShipCoord
{
public:
	int _x_coord, _y_coord;	// starting point on the board
	int _x_length, _y_length; // end point of ship
};

/**
 * Ship
 */
class Ship {
public:
	static const int maxYSize = 4;
	static const int maxXSize = 4;
	enum hitstatus {
		E_MISSED = 0,
		E_HIT,
		E_SANK
	};

private:

	ShipCoord coords;
	/*
	int _x_coord, _y_coord;	// starting point on the board
	int _x_length, _y_length; // end point of ship
	*/
	int _size;
	hitstatus _state;

	// ships hit point holder
	int _ship_array[maxYSize][maxXSize];

protected:
	void clearArray();
	void setShootArray();

public:
    Ship();
	Ship(int x_length, int y_length);
	Ship(int x_coord, int y_coord, int x_length, int y_length);
    virtual ~Ship();

	// set ship position
	bool setCoord(int x_coord, int y_coord);
	inline void getCoord(int &x_coord, int &y_coord)
	{	x_coord = coords._x_coord; y_coord = coords._y_coord; }

	// set ship shape
	bool setShip(int x_length, int y_length);
	inline void getShip(int &x_length, int &y_length)
	{	x_length = coords._x_length; y_length = coords._y_length; }

	// flips ship position. eg x_length = 3, y_length = 1 => x_length = 1, y_length = 3.
	// origin is always x = 0, y = 0;
	ShipCoord flipShip();

	// shooting coordinates that ship sees and replies to
	hitstatus shootCoord(int x, int y, bool into_status = true, Ship *p_ship = 0);
	//hitstatus shootCoord(int x, int y, bool into_status = true);
	hitstatus getStatus();

};

#endif /* SHIP_H_ */
