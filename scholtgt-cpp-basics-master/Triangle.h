#ifndef TRIANGLE_H
#define TRIANGLE_H
/*
 * Triangle.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class implements the Polygon interface to
 * handle working with triangles.
 */
#include <iostream>
#include <cmath>

using namespace std;

class Triangle : public Polygon {

public:

	// Constructor that takes side lengths
	Triangle(double a, double b, double c) {
		side1 = a;
		side2 = b;
		side3 = c;
	};

	// Destructor
	virtual ~Triangle() {}

	// Implementation of area
	double area() {
		// Heron's formula
		double s = (side1 + side2 + side3) / 2.0;
		return sqrt(s*(s-side1)*(s-side2)*(s-side3));
	}

	// Implementation of perimeter
	double perimeter() {
		return side1 + side2 + side3;
	}
private:
	
	// Side lengths
	double side1;
	double side2;
	double side3;
};

#endif