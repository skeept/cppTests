# -----------------------------------------------------------------------------
# Compiler
# -----------------------------------------------------------------------------

CC  = g++

# -----------------------------------------------------------------------------
# Compiler options
# -----------------------------------------------------------------------------

ALL_WARNINGS = -Wall

BOOST_INC_DIR = $(HOME)/boost_1_59_0
# use -isystem instead of -I for this to treat boost files as system headers.
# one use is that warnings generated by these files will be ignored.

CPP_11 = -std=c++11

DEBUG = -g

CC_FLAGS = $(DEBUG) $(ALL_WARNINGS) $(CPP_11) -isystem$(BOOST_INC_DIR)

# -----------------------------------------------------------------------------
# make all: compiles the program. 
# make exe: compiles the program and runs exe.
#
# Note: when a dependency is listed for a .o file, the file is rebuilt when it
# is older than any of its dependencies. Hence, although h files are not
# necessary to be listed as dependencies, they are useful to be listed just to
# make sure that the .o file is not older than the .hpp files. Hence, we only
# need to include user-defined headers as dependencies and not standard/boost
# ones like <vector>.
# -----------------------------------------------------------------------------

SRC_DIR = cpp-tests

OBJS = main.o algos.o boost.o pointers.o strings.o

EXEC_NAME = out

all: $(OBJS)
	$(CC) $(OBJS) $(CC_FLAGS) -o $(EXEC_NAME)

main.o: $(SRC_DIR)/main.cpp $(SRC_DIR)/catch.hpp
	$(CC) $(CC_FLAGS) -c $(SRC_DIR)/main.cpp

algos.o: $(SRC_DIR)/algos.cpp $(SRC_DIR)/catch.hpp
	$(CC) $(CC_FLAGS) -c $(SRC_DIR)/algos.cpp

boost.o: $(SRC_DIR)/boost.cpp $(SRC_DIR)/catch.hpp
	$(CC) $(CC_FLAGS) -c $(SRC_DIR)/boost.cpp

pointers.o: $(SRC_DIR)/pointers.cpp $(SRC_DIR)/catch.hpp
	$(CC) $(CC_FLAGS) -c $(SRC_DIR)/pointers.cpp

strings.o: $(SRC_DIR)/strings.cpp $(SRC_DIR)/catch.hpp
	$(CC) $(CC_FLAGS) -c $(SRC_DIR)/strings.cpp

exe: all
	make all
	./$(EXEC_NAME)

clean:
	rm -f $(EXEC_NAME) *.o
