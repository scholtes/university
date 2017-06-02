#ifndef OCTAGON_H
#define OCTAGON_H
/*
 * Octagon.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class implements a regular octagon using the
 * Polygon interface.
 */
#include <iostream>

using namespace std;

class Octagon : public Polygon {

public:

	// Constructor taking the side length
	Octagon(double a) {
		side = a;
	}

	double perimeter() {
		return 8*side;
	}

	double area() {
		return side*side*AREA_COEFFICIENT;
	}

	// Destructor
	virtual ~Octagon() {}
private:

	// Side length
	double side;

	// Coefficient used for calculating the area
	static const double AREA_COEFFICIENT;
};

const double Octagon::AREA_COEFFICIENT = 4.82842712474619;

#endif