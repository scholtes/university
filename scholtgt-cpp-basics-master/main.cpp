/* Author: Garrett Scholtes
 * Date: 2014-05-27
 * 
 * This is the interface for running the
 * Monopoly simulation, as described in 
 * the project description for project
 * number 4.
 */

#include <iostream>
#include <stdlib.h>
#include "Polygon.h"
#include "Triangle.h"
#include "IsoscelesTriangle.h"
#include "EquilateralTriangle.h"
#include "Quadrilateral.h"
#include "Rectangle.h"
#include "Square.h"
#include "Pentagon.h"
#include "Hexagon.h"
#include "Octagon.h"

using namespace std;

// Used for testing purposes - defined below main
int test();

// Used to interact with the user - defined below main
int interact();

int main(int argc, char* argv[]) {
	
	interact();

	return 0;
}

// Provides functionality to let user give input
int interact() { 
	cout << "Triangle:             " << 0 << endl;
	cout << "Isosceles Triangle:   " << 1 << endl;
	cout << "Equilateral Triangle: " << 2 << endl;
	cout << "Rectangle:            " << 3 << endl;
	cout << "Square:               " << 4 << endl;
	cout << "Pentagon:             " << 5 << endl;
	cout << "Hexagon:              " << 6 << endl;
	cout << "Octagon:              " << 7 << endl;
	cout << "Run predefined tests: " << 8 << endl;
	cout << endl;

	int choice;
	do {
		cout << "Enter a code digit from above: ";
		cin >> choice;
	} while(choice > 8 || choice < 0);

	int number_of_sides;
	switch(choice) {
		case 0:
			number_of_sides = 3;
			break;
		case 1:
			number_of_sides = 2;
			break;
		case 2:
			number_of_sides = 1;
			break;
		case 3:
			number_of_sides = 2;
			break;
		case 4:
			number_of_sides = 1;
			break;
		case 5:
			number_of_sides = 1;
			break;
		case 6:
			number_of_sides = 1;
			break;
		case 7:
			number_of_sides = 1;
			break;
		case 8:
			test();
			exit(0);
	}

	cout << "Enter " << number_of_sides << " side lengths" << endl;
	cout << "(separated by spaces): ";

	double* sides = new double[number_of_sides];
	for(int i = 0; i < number_of_sides; i++) {
		cin >> sides[i];
	}

	Polygon* shape;
	switch(choice) {
		case 0:
			shape = new Triangle(sides[0], sides[1], sides[2]);
			break;
		case 1:
			shape = new IsoscelesTriangle(sides[0], sides[1]);
			break;
		case 2:
			shape = new EquilateralTriangle(sides[0]);
			break;
		case 3:
			shape = new Rectangle(sides[0], sides[1]);
			break;
		case 4:
			shape = new Square(sides[0]);
			break;
		case 5:
			shape = new Pentagon(sides[0]);
			break;
		case 6:
			shape = new Hexagon(sides[0]);
			break;
		case 7:
			shape = new Octagon(sides[0]);
			break;
	}

	cout << "The polygon that you chose has the following properties: " << endl;
	cout << "Area:      " << shape->area() << endl;
	cout << "Perimeter: " << shape->perimeter() << endl;

	delete sides;

	return 0;
}


// Just used for testing purposes
int test() {
	cout << "Creating trialge of 3, 4, 5" << endl;
	Polygon* my_triangle = new Triangle(3.0, 4.0, 5.0);
	cout << "Perimeter: " << my_triangle->perimeter() << endl;
	cout << "Area:      " << my_triangle->area() << endl << endl;
	delete my_triangle;

	cout << "Creating isosceles triangle of 5, 5, 6" << endl;
	IsoscelesTriangle my_other_triangle = IsoscelesTriangle(5.0, 6.0);
	cout << "Perimeter: " << my_other_triangle.perimeter() << endl;
	cout << "Area:      " << my_other_triangle.area() << endl << endl;

	cout << "Creating equilateral triangle of 2, 2, 2" << endl;
	EquilateralTriangle equi_triangle = EquilateralTriangle(2.0);
	cout << "Perimeter: " << equi_triangle.perimeter() << endl;
	cout << "Area:      " << equi_triangle.area() << endl << endl;

	cout << "Creating a 4 by 5 rectangle" << endl;
	Rectangle my_rect = Rectangle(4.0, 5.0);
	cout << "Perimeter: " << my_rect.perimeter() << endl;
	cout << "Area:      " << my_rect.area() << endl << endl;

	cout << "Creating a 3 by 3 square" << endl;
	Square a_square = Square(3.0);
	cout << "Perimeter: " << a_square.perimeter() << endl;
	cout << "Area:      " << a_square.area() << endl << endl;

	cout << "Creating a regular pentagon of side length 6" << endl;
	Pentagon a_penta = Pentagon(6.0);
	cout << "Perimeter: " << a_penta.perimeter() << endl;
	cout << "Area:      " << a_penta.area() << endl << endl;

	cout << "Creating a regular hexagon of side length 6" << endl;
	Hexagon a_hexa = Hexagon(6.0);
	cout << "Perimeter: " << a_hexa.perimeter() << endl;
	cout << "Area:      " << a_hexa.area() << endl << endl;

	cout << "Creating a regular octagon of side length 6" << endl;
	Octagon an_oct = Octagon(6.0);
	cout << "Perimeter: " << an_oct.perimeter() << endl;
	cout << "Area:      " << an_oct.area() << endl << endl;

	return 0;
}