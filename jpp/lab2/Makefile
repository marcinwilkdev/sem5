ada:
	gcc -c lib.adb test.adb && gnatbind test.ali && gnatlink test.ali && rm *.o *.ali && ./test

ada_req:
	gcc -c lib_req.adb test_req.adb && gnatbind test_req.ali && gnatlink test_req.ali && rm *.o *.ali && ./test_req

c:
	gcc lib.c test.c -o test && ./test

c_req:
	gcc lib_req.c test_req.c -o test_req && ./test_req

ada_c:
	gcc -c --shared lib.adb && gcc -c test.c && gcc lib.o test.o -lgnat -o test && rm *.o *.ali && ./test

ada_c_req:
	gcc -c --shared lib_req.adb && gcc -c test_req.c && gcc lib_req.o test_req.o -lgnat -o test_req && rm *.o *.ali && ./test_req

c_ada:
	gcc -c lib.c test.adb && gnatbind test.ali && gnatlink test.ali lib.o && rm *.o *.ali && ./test

c_ada_req:
	gcc -c lib_req.c test_req.adb && gnatbind test_req.ali && gnatlink test_req.ali lib_req.o && rm *.o *.ali && ./test_req

static:
	gcc -c lib.c && ar rcs lib.a lib.o

static_req:
	gcc -c lib_req.c && ar rcs lib_req.a lib_req.o
