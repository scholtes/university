#ifndef ISOSCELES_TRIANGLE_H
#define ISOSCELES_TRIANGLE_H
/*
 * IsoscelesTriangle.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class extends Triangle to create isosceles triangles.  Notice that
 * it does not need to define perimeter or area, as Triangle has already
 * implemented those functions.
 */
#include <iostream>

using namespace std;

class IsoscelesTriangle : public Triangle {

public:

	// Constructor that takes side lengths, where the first 
	// side length (a) is the one that occurs twice.
	IsoscelesTriangle(double a, double b) : Triangle(a, a, b) {
	}

	// Destructor
	virtual ~IsoscelesTriangle() {}

};

#endif