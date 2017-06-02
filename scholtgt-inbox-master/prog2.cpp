/*
 * prog2.cpp
 * Team: Garrett Scholtes
 * 
 * Jun 10, 2014
 *
 * The classes in this project form the structure for an email inbox,
 * utilizing a linked list.  The main loop allows the user to input different
 * email subjects to simulate adding emails to the inbox.  At the end, the
 * user will be able to view statistics on the inbox.
 *
 */

#include <iostream>
#include <stdexcept>

 using namespace std;

// This class implements a doubly-linked list, providing the functions
// that will be used by the Inbox and Communication classes.
template <class T> class List {
public:

	// Default constructor - empty list
	List() {
		head = NULL;
		tail = NULL;
		size = 0;
	}

	// Copy constructor
	List(const List& other) {
		head = NULL;
		tail = NULL;
		size= 0;
		node_t* currentOther = other.head;
		while(currentOther != NULL) {
			this->append(currentOther->value);
			currentOther = currentOther->next;
		}
	}

	// Destructor
	~List() {
		node_t* currentNode = head;
		while(currentNode != NULL) {
			node_t* victim = currentNode;
			currentNode = currentNode->next;
			victim = NULL;
		}
	}

	// Add an item to the end of the list
	void append(T& value) {
		size++;
		tail = createNode(value, tail, NULL);
		if(tail->prev != NULL) {
			tail->prev->next = tail;
		} else {
			head = tail;
		}
	}

	// Get value of item at index n (0 based), also allowing for
	// negative indexing (i.e., -1 is last element)
	T& at(int n) {
		int pos = n < 0 ? n + size : n;
		if(pos < 0 || pos >= size) {
			throw length_error("Index out of range");
		}
		node_t* currentNode = head;
		int counter = 0;
		while(counter != pos) {
			currentNode = currentNode->next;
			counter++;
		}
		return currentNode->value;
	}

	// Delete the element at index n, also allowing negative indexing
	void deleteNth(int n) {
		int pos = n < 0 ? n + size : n;
		if(head == NULL || pos < 0 || pos >= size) {
			throw length_error("Index out of range");
		}
		size--;

		if(n == 0) {
			node_t* victim = head;
			head = head->next;
			if(head == NULL) {
				tail = NULL;
			}
			delete victim;
		} else {
			int counter = 0;
			node_t* currentNode = head;
			while(counter < pos - 1) {
				currentNode = currentNode->next;
				counter++;
			}
			node_t* victim = currentNode->next;
			currentNode->next = victim->next;
			if(victim->next != NULL) {
				victim->next->prev = currentNode;
			} else {
				tail = currentNode;
			}
			delete victim;
		}
	}

	// Get the length of the list
	int length() {
		return size;
	}

	// Prints out the list
	void print() {
		if(head == NULL) {
			cout << "[]" << endl;
			return;
		}

		cout << "[";
		node_t* currentNode = head;
		while(currentNode->next != NULL) {
			cout << currentNode->value << ", ";
			currentNode =  currentNode->next;
		}
		cout << currentNode->value << "]" << endl;
	}

private:

	// This implements a node structures, that holds a value and
	// pointers to the previous and next nodes.
	struct node_t {
		T value;
		node_t* prev;
		node_t* next;
	};

	// Pointers to the first and last nodes, respectively
	node_t* head;
	node_t* tail;

	// Field used to memoize the length of the list
	int size;

	// This private function will come handy for creating nodes as needed
	node_t* createNode(T value, node_t* prev, node_t* next) {
		node_t* node = new node_t;
		node->value = value;
		node->prev = prev;
		node->next = next;
		return node;
	}
};

class Email {
public:

	// Default constructor
	Email() {}

	// Constructor that accepts a to, from, and message body
	Email(string t, string f, string msg) {
		to_f = t;
		from_f = f;
		message_f = msg;
	}

	// Returns who the email is to
	string to() {
		return to_f;
	}

	// Returns who the email was from
	string from() {
		return from_f;
	}

	// Returns the message body (string)
	string message() {
		return message_f;
	}

private:

	// Fields corresponding to functions above
	string to_f;
	string from_f;
	string message_f;
};

class Communication {
public:

	// Default constructor
	Communication() {}

	// Constructor to add a subject
	Communication(string subj) {
		subject = subj;
	}

	// Return the subject
	string getSubject() {
		return subject;
	}

	// Returns number of emails in communication
	int size() {
		return emails.length();
	}

	// Adds an email to the beginning of the communication.
	// Emails are chronologically added to the BACK of the linked-list,
	// i.e., the LATEST received email is at the END of the list.
	void addEmail(Email email) {
		emails.append(email);
	}

private:

	// Subject of emails in this communication
	string subject;

	// Doubly-linked list of emails
	List<Email> emails;
};

class Inbox {
public:

	// Default constructor
	Inbox() {}

	// Copy constructor
	Inbox(const Inbox& other) {
		communications = List<Communication>(other.communications);
	}

	// Destructor - memory management happens elsewhere (Linked List)
	~Inbox() {}

	// This emulates adding an email to the inbox, following the communication
	// chain as described in the assignment description.  The END of the linked
	// list represents the MOST RECENT communication
	void insertEmail(Email email, string subject) {
		for(int i = 0; i < communications.length(); i++) {
			if(communications.at(i).getSubject() == subject) {
				communications.at(i).addEmail(email);
				communications.append(communications.at(i));
				communications.deleteNth(i);
				return;
			}
		}
		Communication newConv = Communication(subject);
		newConv.addEmail(email);
		communications.append(newConv);
	}

	// This deletes the communication with the given subject, if it exists
	void deleteCommunication(string subject) {
	for(int i = 0; i < communications.length(); i++) {
			if(communications.at(i).getSubject() == subject) {
				communications.deleteNth(i);
				return;
			}
		}
	}

	// Returns a reference to the communication
	Communication& searchCommunication(string subject) {
		for(int i = 0; i < communications.length(); i++) {
			if(communications.at(i).getSubject() == subject) {
				return communications.at(i);
			}
		}
	}

	// Prints the inbox by listing communications chronologically, with the
	// number of emails per communication displayed
	void displayInbox() {
		int emailCount = 0;
		for(int i = 0; i < communications.length(); i++) {
			emailCount += communications.at(i).size();
		}
		cout << "Inbox: total number of emails is " << emailCount << ".\n";
		for(int i = communications.length()-1; i >= 0; i--) {
			cout << communications.at(i).getSubject() << " - " << communications.at(i).size() << "\n";
		}
	}

private:

	// Stores the communications
	List<Communication> communications;
};

// Used for testing purposes only
int test();

// Program's main function
int main(int argc, char*argv[]) {

	// Uncomment below to run linked-list tests, if desired
	//test();


	Inbox inbox = Inbox();
	inbox.displayInbox();
	cout << endl << "Receiving emails...." << endl << endl;

	Email sample = Email("me@goofyEmail.com", "foo@bar.com", "Hello stranger");
	inbox.insertEmail(sample, "Weather");
	inbox.insertEmail(sample, "Weather");
	inbox.insertEmail(sample, "Weather");
	inbox.insertEmail(sample, "Picnic");
	inbox.insertEmail(sample, "Picnic");
	inbox.insertEmail(sample, "Birthday Party");
	inbox.insertEmail(sample, "Picnic");
	inbox.insertEmail(sample, "Weather");
	inbox.insertEmail(sample, "Greetings");
	inbox.insertEmail(sample, "Birthday Party");

	inbox.displayInbox();

	return 0;
}

// Here is where the tests are defined
int test() {
	// Append elements to our list
	List<int> list;
	list.print();
	cout << "^size: " << list.length();
	for(int i = 0; i < 10; i++) {
		list.append(i);
		list.print();
		cout << "^size: " << list.length() << endl;
	}
	//Check values at indecies for correctness
	for(int i = 0; i < 10; i++) {
		cout << list.at(i) << " ";
	}
	cout << endl << endl;
	// Delete odd-numbered elements
	for(int i = 1; i <=5; i++) {
		list.deleteNth(i);
		list.print();
		cout << "^size: " << list.length() << endl;
	}
	// Delete remaining elements
	for(int i = 1; i <= 5; i++) {
		list.deleteNth(0);
		list.print();
		cout << "^size: " << list.length() << endl;
	}


	// Test for memory leaks
	for(int i = 0; i < 10; i++) { list.append(i); }
}