#ifndef PENTAGON_H
#define PENTAGON_H
/*
 * Pentagon.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class implements a regular pentagon using the
 * Polygon interface.
 */
#include <iostream>

using namespace std;

class Pentagon : public Polygon {

public:

	// Constructor taking the side length
	Pentagon(double a) {
		side = a;
	}

	double perimeter() {
		return 5*side;
	}

	double area() {
		return side*side*AREA_COEFFICIENT;
	}

	// Destructor
	virtual ~Pentagon() {}
private:

	// Side length
	double side;

	// Coefficient used for calculating the area
	static const double AREA_COEFFICIENT;
};

const double Pentagon::AREA_COEFFICIENT = 1.720477400588967;

#endif