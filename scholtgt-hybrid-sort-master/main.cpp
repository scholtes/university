/* 
 * main.cpp
 * Name: Garrett Scholtes
 * 
 * Main user interface to test and analyze the implemented sorting algorithms.
 * 
 * 2014-07-12
 */

#include <iostream>
#include <stdlib.h>
#include <time.h>
#include "sorting.h"

using namespace std;
using namespace sorting;

// Handles the menu logic for the user interface
void runUserInterface() {
	cout << "SORTING ALGORITHM TESTING SUITE" << endl;
	cout << "-------------------------------" << endl;
	cout << "This program will allow to you perform some basic experimentation" << endl;
	cout << "with various sorting algorithms. Please use the following id codes" << endl;
	cout << "below whenever you are prompted to use an algorithm:" << endl;
	cout << "    Insertion sort: 0" << endl;
	cout << "    Bubble sort:    1" << endl;
	cout << "    Quicksort:      2" << endl;
	cout << "    Merge sort:     3" << endl;
	cout << "    Hybrid sort:    4" << endl;
	cout << "Hybrid sort will prompt you to choose a threshold, 'large' sorting" << endl;
	cout << "algorithm, and a 'small' sorting algorithm. When entering an array of" << endl;
	cout << "integers, enter each element followed by a space.  For example, to" << endl;
	cout << "create the array [2, 7, -3, 42, 9], you would enter the size, then" << endl;
	cout << "enter the array as:" << endl;
	cout << "    2 7 -3 42 9" << endl;
	cout << "Do not use any other delimiters such as commas or semicolons." << endl;
	cout << "Answer yes or no questions with 1 or 0, respectively; i.e., 1 means" << endl;
	cout << "yes and 0 means no." << endl << endl;

	cout << "Enter random seed (non-negative integer): ";
	unsigned int seed;
	cin >> seed;

	int input;
	while(true) {
		srand(seed);
		resetCounter();
		cout << endl << "Enter size of array to create (non-negative integer): ";
		unsigned int size;
		cin >> size;
		bool display, generate;
		if(size > 100) {
			display = false;
			generate = true;
		} else {
			cout << "Automatically generate list? (1-yes, 0-no): ";
			cin >> input;
			generate = input == 1 ? true : false;
			cout << "Display sorted array? (1-yes, 0-no): ";
			cin >> input;
			display = input == 1 ? true : false;
		}
		vector<int> list;
		if(!generate) {
			cout << "Enter " << size << " values, separated by spaces:\n  ";
			for(unsigned int i = 0; i < size; i++) {
				cin >> input;
				list.push_back(input);
			}
		} else {
			for(unsigned int i = 0; i < size; i++) {
				list.push_back(rand() % size);
			}
		}
		if(display) {
			cout << "Using list:" << endl << "  ";
			printVector(list);
			cout << endl;
		}
		cout << "Choose a sorting algorithm (use id number 0-4): ";
		cin >> input;
		if(input == 0) { insertionSort(list); }
		else if(input == 1) { bubbleSort(list); }
		else if(input == 2) { quicksort(list); }
		else if(input == 3) { mergeSort(list); }
		else if(input == 4) {
			int bigSort, smallSort, threshold;
			cout << "Choose a 'large' sort (2 or 3): ";
			cin >> input;
			if(input == 2) { bigSort = QUICKSORT; }
			else if(input == 3) { bigSort = MERGESORT; }
			else {
				cout << "That is not a valid option." << endl;
				continue;
			}
			cout << "Choose a 'small' sort (0 or 1): ";
			cin >> input;
			if(input == 0) { smallSort = INSERTIONSORT; }
			else if(input == 1) { smallSort = BUBBLESORT; }
			else {
				cout << "That is not a valid option." << endl;
				continue;
			}
			cout << "Enter a threshold between 0 and " << size << ": ";
			cin >> threshold;
			hybridSort(list, bigSort, smallSort, threshold);
		} else {
			cout << "That is not a valid option." << endl;
			continue;
		}
		if(display) {
			cout << "Sorted list:" << endl << "  ";
			printVector(list);
		}
		cout << endl << "Number of element comparisons: ";
		cout << compares << endl;
	}

}

int main(int argc, char* argv[]){

	runUserInterface();

	return 0;
}

// A set of test cases for insertion sort
void testInsertionSort() {
	cout << "INSERTION SORT" << endl << endl;

	// Empty list test
	vector<int> a1;
	cout << "Empty list: ";
	printVector(a1);
	cout << endl;
	insertionSort(a1);
	cout << "Sorted:     ";
	printVector(a1);
	cout << endl << endl;

	// Single element list test
	a1 = vector<int>(1,rand()%10);
	cout << "Single list: ";
	printVector(a1);
	cout << endl;
	insertionSort(a1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;

	// Larger list test
	a1 = vector<int>();
	for(int i=0; i<10; i++) { a1.push_back(rand()%10); }
	cout << "Larger list: ";
	printVector(a1);
	cout << endl;
	insertionSort(a1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;
}

// A set of test cases for bubble sort
void testBubbleSort() {
	cout << "BUBBLE SORT" << endl << endl;

	// Empty list test
	vector<int> a1;
	cout << "Empty list: ";
	printVector(a1);
	cout << endl;
	bubbleSort(a1);
	cout << "Sorted:     ";
	printVector(a1);
	cout << endl << endl;

	// Single element list test
	a1 = vector<int>(1,rand()%10);
	cout << "Single list: ";
	printVector(a1);
	cout << endl;
	bubbleSort(a1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;

	// Larger list test
	a1 = vector<int>();
	for(int i=0; i<10; i++) { a1.push_back(rand()%10); }
	cout << "Larger list: ";
	printVector(a1);
	cout << endl;
	bubbleSort(a1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;
}

// A set of test cases for quicksort
void testQuicksort() {
	cout << "QUICKSORT" << endl << endl;

	// Empty list test
	vector<int> a1;
	cout << "Empty list: ";
	printVector(a1);
	cout << endl;
	quicksort(a1);
	cout << "Sorted:     ";
	printVector(a1);
	cout << endl << endl;

	// Single element list test
	a1 = vector<int>(1,rand()%10);
	cout << "Single list: ";
	printVector(a1);
	cout << endl;
	quicksort(a1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;

	// Larger list test
	a1 = vector<int>();
	for(int i=0; i<10; i++) { a1.push_back(rand()%10); }
	cout << "Larger list: ";
	printVector(a1);
	cout << endl;
	quicksort(a1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;
}

// A set of test cases for merge sort
void testMergeSort() {
	cout << "MERGE SORT" << endl << endl;

	// Empty list test
	vector<int> a1;
	cout << "Empty list: ";
	printVector(a1);
	cout << endl;
	mergeSort(a1);
	cout << "Sorted:     ";
	printVector(a1);
	cout << endl << endl;

	// Single element list test
	a1 = vector<int>(1,rand()%10);
	cout << "Single list: ";
	printVector(a1);
	cout << endl;
	mergeSort(a1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;

	// Larger list test
	a1 = vector<int>();
	for(int i=0; i<10; i++) { a1.push_back(rand()%10); }
	cout << "Larger list: ";
	printVector(a1);
	cout << endl;
	mergeSort(a1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;
}

// A set of test cases for merge sort
void testHybridSort() {
	cout << "HYBRID SORT" << endl << endl;

	// Empty list test
	vector<int> a1;
	cout << "Empty list: ";
	printVector(a1);
	cout << endl;
	hybridSort(a1, MERGESORT, BUBBLESORT, 0);
	cout << "Sorted:     ";
	printVector(a1);
	cout << endl << endl;

	// Single element list test
	a1 = vector<int>(1,rand()%10);
	cout << "Single list: ";
	printVector(a1);
	cout << endl;
	hybridSort(a1, MERGESORT, BUBBLESORT, 1);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;

	// Larger list test
	a1 = vector<int>();
	for(int i=0; i<10; i++) { a1.push_back(rand()%10); }
	cout << "Larger list: ";
	printVector(a1);
	cout << endl;
	hybridSort(a1, MERGESORT, BUBBLESORT, 4);
	cout << "Sorted:      ";
	printVector(a1);
	cout << endl << endl;
}
