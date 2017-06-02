#ifndef POLYGON_H
#define POLYGON_H
/*
 * Polygon.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class defines an interface for the abstract
 * type Polygon.
 */
#include <iostream>

using namespace std;

class Polygon {

public:
	// Interface for computing the area of a polygon
	virtual double area() = 0;

	// Interface for computing the perimeter of a polygon
	virtual double perimeter() = 0;

	// Destructor - unused here
	virtual ~Polygon() {}
};

#endif