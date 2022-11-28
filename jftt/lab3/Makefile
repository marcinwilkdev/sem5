all: test.y test.l
	bison -d test.y -o test_y.c 
	flex -o test_l.c test.l  
	clang test_y.c test_l.c -o test
