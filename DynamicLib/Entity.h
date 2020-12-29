#ifndef ENTITY_H
#define ENTITY_H

#include <thread>
#include <vector>
#include <string>
#include <iostream>
#include <chrono>
#include <mutex>

using namespace std::literals::chrono_literals;

class Entity {
public:
	Entity(size_t n_threads, size_t n = 100);

	void func();

	void run();
	void joinAllThreads();

	void printBar();

private:
	size_t n_;
	size_t n_threads_;
	size_t processed_;
	std::vector<std::thread*> threads_;
};

extern "C" {
	void foo();
}


#endif // !ENTITY_H