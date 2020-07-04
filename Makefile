all: java py

js:
# https://stackoverflow.com/questions/53540811/swig-for-javascript-module-did-not-self-register-on-load
# https://github.com/swig/swig/issues/1520
	cp example.c example.cxx
	swig -javascript -node -c++ example.i
	node-gyp build

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
	rm -rf __pycache__ build
	rm -f example_wrap.c
	rm -f example_wrap.cxx
	rm -f example.cxx
	rm -f package-lock.json
