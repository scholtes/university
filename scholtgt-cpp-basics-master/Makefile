CC=g++
CFLAGS=-c -Wall -ggdb -I. 
LDFLAGS=
# List your CPP files here - space delimited
SOURCES=main.cpp
EXECUTABLE=a.out

OBJECTS=$(SOURCES:.cpp=.o)
# List your .o files that should be part of tests here
# Usually everything except for main.o
OBJECTSTEST=Monopoly.o Player.o

FLAGS   = -I.

all: $(SOURCES) $(EXECUTABLE)
	

# These next lines do a bit of magic found from http://stackoverflow.com/questions/2394609/makefile-header-dependencies
# Essentially it asks the compiler to read the .cpp files and generate the needed .h dependencies.
# This way if any .h file changes the correct .cpp files will be recompiled
depend: .depend
	

.depend: $(SOURCES)
	rm -f ./.depend
	$(CC) $(CFLAGS) -MM $^ >> ./.depend;

include .depend
# End .h file magic

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	-rm -rf *o $(EXECUTABLE)
	-rm -f testrunner testrunner.cpp
	-rm -f ./.depend
