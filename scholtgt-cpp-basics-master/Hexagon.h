#ifndef HEXAGON_H
#define HEXAGON_H
/*
 * Hexagon.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class implements a regular hexagon using the
 * Polygon interface.
 */
#include <iostream>

using namespace std;

class Hexagon : public Polygon {

public:

	// Constructor taking the side length
	Hexagon(double a) {
		side = a;
	}

	double perimeter() {
		return 6*side;
	}

	double area() {
		return side*side*AREA_COEFFICIENT;
	}

	// Destructor
	virtual ~Hexagon() {}
private:

	// Side length
	double side;

	// Coefficient used for calculating the area
	static const double AREA_COEFFICIENT;
};

const double Hexagon::AREA_COEFFICIENT = 2.598076211353316;

#endif