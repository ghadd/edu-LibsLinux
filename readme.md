# Compiling local header files 
- `$ g++ driver.cpp file1.cpp file2.cpp`
- `-std=c++14` - C++ version
- `-c` compiles without linking
- `-o <sth>` names your executable 


# Static & shared libraries linking

## Static 
Create the object files (only one here)

`$ g++ -c unuseful.cpp`

Create the archive (insert the lib prefix)

`$ ar rcsf libunuseful.a unuseful.o`

Moving to default libs folder

`$ (sudo) mv libunuseful.a /usr/lib/libunuseful.a`


## Shared

Create the object file with Position Independent Code

`$ g++ -fPIC -c unuseful.cpp`

Create the shared library (insert the lib prefix)

`$ g++ -shared -o libunuseful.so unuseful.o`

Moving to default libs folder

`$ (sudo) mv libunuseful.so /usr/lib/libunuseful.so`


## Compiling 

`g++ foo.cpp bar.cpp -lunuseful`

of if you want to specify your libs folder

`g++ foo.cpp bar.cpp -L/path/to/your/lib -lunuseful`