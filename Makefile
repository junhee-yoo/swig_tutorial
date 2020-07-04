all: java py

java:
	swig -java example.i
	gcc -c example.c example_wrap.c -I/Users/jhyoo/.jenv/versions/1.8/include -I/Users/jhyoo/.jenv/versions/1.8/include/darwin
	ld -ldl -dylib example.o example_wrap.o -o libexample.so
	javac main.java
	java main

py:
	swig -python example.i
	gcc -c example.c example_wrap.c `python3-config --include`
	ld `python3-config --ldflag` -dylib example.o example_wrap.o -o _example.so
	python3 -c "import example;print(example.get_time())"

clean:
	rm -f example.py
	rm -f example.so
	rm -f _example.so
	rm -f example.o
	rm -f example_wrap.o
	rm -f exampleJNI.java
	rm -f example.class
	rm -f example.java
	rm -f exampleJNI.java
	rm -f exampleJNI.class
	rm -f main.class
	rm -f libexample.dylib
	rm -f libexample.so
	rm -rf __pycache__
	rm -f example_wrap.c
