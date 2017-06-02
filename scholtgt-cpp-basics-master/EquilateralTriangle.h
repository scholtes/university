#ifndef EQUILATERAL_TRIANGLE_H
#define EQUILATERAL_TRIANGLE_H
/*
 * EquilateralTriangle.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class extends IsoscelesTriangle to represent equilateral triangles,
 * which form a subset of isosceles triangles.
 * 
 * Note that we could have extended Triangle directly, instead... however,
 * doing it this way better represents the relationship between the types
 * of triangles.
 */
#include <iostream>

using namespace std;

class EquilateralTriangle : public IsoscelesTriangle {

public:

	// Constructor taking a side length
	EquilateralTriangle(double a) : IsoscelesTriangle(a, a) {
	}

	// Destructor
	virtual ~EquilateralTriangle() {}

};

#endif