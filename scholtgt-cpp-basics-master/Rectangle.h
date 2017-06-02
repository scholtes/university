#ifndef RECTANGLE_H
#define RECTANGLE_H
/*
 * Rectangle.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class implements the Quadrilateral interface, in order
 * to work with rectangles.
 */
#include <iostream>

using namespace std;

class Rectangle : public Quadrilateral {

public:

	// Constructor that takes two side lengths
	Rectangle(double a, double b) : Quadrilateral(a, a, b, b) {
	}

	// Computes area of a rectangle
	double area() {
		return side1*side3;
	}

	// Destructor
	virtual ~Rectangle() {}

};

#endif