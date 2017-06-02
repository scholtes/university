/* 
 * sorting.h
 * Name: Garrett Scholtes
 * 
 * This file contains the implementation of various sorting algorithms, as defined in the
 * assignment description.  We will be using the vector implementation of a list and be working
 * with integers.
 * 
 * All sorting algorithms are implemented in-place, i.e., they will modify the list.
 * 
 * 2014-07-12
 */
#include <vector>

// Namespace where sorting functions reside.
// All sorting functions will not return a new vector, but rather mutate the given vector!
namespace sorting {

	// Hybrid sort options
	const int QUICKSORT = 1;
	const int MERGESORT = 2;
	const int INSERTIONSORT = 4;
	const int BUBBLESORT = 8;

	// Tracks number of comparisons
	int compares = 0;

	// Sorts a vector via insertion sort algorithm.
	void insertionSort(std::vector<int>& array) {
		for(unsigned int i = 1; i < array.size(); i++) {
			int current = array[i];
			unsigned int j = i;
			while(j > 0 && array[j-1] > current) {
				array[j] = array[j-1];
				j--;
				compares++;
			}
			if(j > 0) { compares++; }
			array[j] = current;
		}
	}

	// Sorts a vector via bubble sort algorithm.
	void bubbleSort(std::vector<int>& array) {
		unsigned int size = array.size();
		bool unsorted;
		do {
			unsorted = false;
			for(unsigned int i = 1; i < size; i++) {
				if(array[i-1] > array[i]) {
					int temp = array[i];
					array[i] = array[i-1];
					array[i-1] = temp;
					unsorted = true;
				}
				compares++;
			}
			size--;
		} while(unsorted);
	}

	// Quicksort helper function.
	// Performs quicksort on a vector in the range left<=index<=right
	// This is not the function the user should call.  The quicksort function that the
	// user should call is defined below and has less parameters.
	void __quicksort__(std::vector<int>& array, unsigned int left, unsigned int right) {
		if(left < right) {
			// Choose the pivot in the middle-ish
			unsigned int pidx = (left+right)/2;
			// Move pivot to end of list
			int pval = array[pidx];
			array[pidx] = array[right];
			array[right] = pval;
			pidx = left;
			// Compare all values to pivot and swap accordingly
			for(unsigned int i = left; i < right; i++) {
				if(array[i] <= pval) {
					int temp = array[i];
					array[i] = array[pidx];
					array[pidx] = temp;
					pidx++;
				}
				compares++;
			}
			int temp = array[pidx];
			array[pidx] = array[right];
			array[right] = temp;
			// Recursive step
			if(pidx > 0) {
				__quicksort__(array, left, pidx-1);
			}
			__quicksort__(array, pidx+1, right);
		}
	}

	// Sorts a vector via quicksort algorithm.
	// Notice that this uses a helper function that allows us to sort particular partitions
	// of a vector, that way we can perform quicksort in-place without excess allocations.
	// This function just provides the cleaner user interface without extra parameters.
	void quicksort(std::vector<int>& array) {
		if(array.size() > 1) {
			__quicksort__(array, 0, array.size()-1);
		}
	}

	// Merge sort helper function.
	// Performs merge sort on a vector, but not in place.
	std::vector<int> __mergeSort__(const std::vector<int>& array) {
		if(array.size() > 1) {
			// Partition arrays
			unsigned int middle = array.size()/2-1;
			std::vector<int> first(middle+1,0);
			std::vector<int> second(array.size()-middle-1,0);
			for(unsigned int i = 0; i <= middle; i++) {
				first[i] = array[i];
			}
			for(unsigned int i = middle+1; i < array.size(); i++) {
				second[i-middle-1] = array[i];
			}
			// Recursive step
			first = __mergeSort__(first);
			second = __mergeSort__(second);
			// Merge step
			std::vector<int> final(array.size(),0);
			unsigned int i = 0;
			unsigned int j = 0;
			unsigned int pos = 0;
			while(i < middle+1 && j < array.size()-middle-1) {
				if(first[i] < second[j]) {
					final[pos] = first[i];
					i++;
				} else {
					final[pos] = second[j];
					j++;
				}
				pos++;
				compares++;
			}
			if(i == middle+1) {
				for(unsigned int k = j; k < array.size()-middle-1; k++) {
					final[pos] = second[k];
					pos++;
				}
			} else {
				for(unsigned int k = i; k < middle+1; k++) {
					final[pos] = first[k];
					pos++;
				}
			}
			return final;
		} else {
			return std::vector<int>(array);
		}
	}

	// Sorts a vector via merge sort algorithm.
	// Like quicksort, this is the interface for the user.  Most of the logic occurs in a
	// helper function above.
	void mergeSort(std::vector<int>& array) {
		if(array.size() > 1) {
			std::vector<int> temp = std::vector<int>(array);
			array = __mergeSort__(temp);
		}
	}

	// Helper function for hybrid sort
	// Uses quicksort for large partitions, appropriate small sort for smaller partitions
	void __hybridQuicksort__(std::vector<int>& array, int small, int threshold,
			unsigned int left, unsigned int right) {
		if(left < right) {
			// Choose the pivot in the middle-ish
			unsigned int pidx = (left+right)/2;
			// Move pivot to end of list
			int pval = array[pidx];
			array[pidx] = array[right];
			array[right] = pval;
			pidx = left;
			// Compare all values to pivot and swap accordingly
			for(unsigned int i = left; i < right; i++) {
				if(array[i] <= pval) {
					int temp = array[i];
					array[i] = array[pidx];
					array[pidx] = temp;
					pidx++;
				}
				compares++;
			}
			int temp = array[pidx];
			array[pidx] = array[right];
			array[right] = temp;
			// Recursive step - must take into account smaller partitions
			if(pidx > 0 && pidx-left > threshold) {
				__hybridQuicksort__(array, small, threshold, left, pidx-1);
			} else {
				std::vector<int> temp(pidx-left, 0);
				for(unsigned int i = left; i < pidx; i++) {
					temp[i-left] = array[i];
				}
				if(small == INSERTIONSORT) {
					insertionSort(temp);
				} else {
					bubbleSort(temp);
				}
				for(unsigned int i = left; i < pidx; i++) {
					array[i] = temp[i-left];
				}
			}
			if(right-pidx > threshold) {
				__hybridQuicksort__(array, small, threshold, pidx+1, right);
			} else {
				std::vector<int> temp(right-pidx, 0);
				for(unsigned int i = pidx+1; i < right+1; i++) {
					temp[i-pidx-1] = array[i];
				}
				if(small == INSERTIONSORT) {
					insertionSort(temp);
				} else {
					bubbleSort(temp);
				}
				for(unsigned int i = pidx+1; i < right+1; i++) {
					array[i] = temp[i-pidx-1];
				}
			}
		}
	}

	// Helper function for hybrid sort
	// Uses merge sort for large partitions, appropriate small sort for smaller partitions
	std::vector<int> __hybridMergeSort__(const std::vector<int>& array, int small, int threshold) {
		if(array.size() > 1) {
			// Partition arrays
			unsigned int middle = array.size()/2-1;
			std::vector<int> first(middle+1,0);
			std::vector<int> second(array.size()-middle-1,0);
			for(unsigned int i = 0; i <= middle; i++) {
				first[i] = array[i];
			}
			for(unsigned int i = middle+1; i < array.size(); i++) {
				second[i-middle-1] = array[i];
			}
			// Recursive step
			if(first.size() > threshold) {
				first = __hybridMergeSort__(first, small, threshold);
			} else {
				if(small == INSERTIONSORT) {
					insertionSort(first);
				} else {
					bubbleSort(first);
				}
			}
			if(second.size() > threshold) {
				second = __hybridMergeSort__(second, small, threshold);
			} else {
				if(small == INSERTIONSORT) {
					insertionSort(second);
				} else {
					bubbleSort(second);
				}
			}
			// Merge step
			std::vector<int> final(array.size(),0);
			unsigned int i = 0;
			unsigned int j = 0;
			unsigned int pos = 0;
			while(i < middle+1 && j < array.size()-middle-1) {
				if(first[i] < second[j]) {
					final[pos] = first[i];
					i++;
				} else {
					final[pos] = second[j];
					j++;
				}
				pos++;
				compares++;
			}
			if(i == middle+1) {
				for(unsigned int k = j; k < array.size()-middle-1; k++) {
					final[pos] = second[k];
					pos++;
				}
			} else {
				for(unsigned int k = i; k < middle+1; k++) {
					final[pos] = first[k];
					pos++;
				}
			}
			return final;
		} else {
			return std::vector<int>(array);
		}
	}

	// Sorts a vector via hybrid sort algorithm.
	// This uses one of the large sorting algorithms for sorting large partitions and a
	// small sorting algorithm for sorting small partitions.  Parameters:
	//     large: QUICKSORT or MERGESORT
	//     small: INSERTIONSORT or BUBBLESORT
	//     threshold: the array will recursively use a large sort for arrays with size
	//                greater than threshold and will use a small sort for partitions
	//                with size less than or equal to the partition
	// This algorithm has some helper functions to aid in performing quicksort (which is)
	// simpler to do with extra parameters) and mergesort (which returns different types).
	void hybridSort(std::vector<int>& array, int large, int small, int threshold) {
		if(array.size() <= threshold) {
			// Use small array sort
			// We can reuse the implementations above because they do not recurse
			if(small == INSERTIONSORT) {
				insertionSort(array);
			} else {
				bubbleSort(array);
			}
		} else {
			// Use large array sort
			// We cannot directly call implementations above because we must make sure
			// that smaller partitions will use the proper small sort.
			if(large == QUICKSORT) {
				// Quicksort
				if(array.size() > 1) {
					__hybridQuicksort__(array, small, threshold, 0, array.size()-1);
				}
			} else {
				// Merge sort
				if(array.size() > 1) {
					std::vector<int> temp = std::vector<int>(array);
					array = __hybridMergeSort__(temp, small, threshold);
				}
			}
		}
	}

	// Reset the comparison counter to zero
	void resetCounter() {
		compares = 0;
	}

	// Helper function that prints a vector to the screen
	void printVector(const std::vector<int>& array) {
		std::cout << "[";
		for(unsigned int i = 0; i < array.size(); i++) {
			std::cout << array[i];
			if(i < array.size() - 1) {
				std::cout << ", ";
			}
		}
		std::cout << "]";
	}

}
