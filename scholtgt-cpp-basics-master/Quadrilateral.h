#ifndef QUADRILATERAL_H
#define QUADRILATERAL_H
/*
 * Quadrilateral.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class provides an interface for other
 * quadrilaterals, based on the Polygon interface.
 */
#include <iostream>

using namespace std;

class Quadrilateral : public Polygon {

public:

	// Constructor that takes four sides.  Only usable by
	// extending classes, because area is not implemented.
	Quadrilateral(double a, double b, double c, double d) {
		side1 = a;
		side2 = b;
		side3 = c;
		side4 = d;
	}

	double perimeter() {
		return side1 + side2 + side3 + side4;
	}

	// Destructor
	virtual ~Quadrilateral() {}
protected:

	// Side lengths
	double side1;
	double side2;
	double side3;
	double side4;
};

#endif