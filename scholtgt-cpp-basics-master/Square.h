#ifndef SQUARE_H
#define SQUARE_H
/*
 * Square.h
 * Name: Garrett Scholtes
 *
 * May 27, 2014
 *
 * This class extends Rectangle to easily handle squares
 */
#include <iostream>

using namespace std;

class Square : public Rectangle {

public:

	// Constructor that takes the side length
	Square(double a) : Rectangle(a, a) {
	}

	// Destructor
	virtual ~Square() {}

};

#endif