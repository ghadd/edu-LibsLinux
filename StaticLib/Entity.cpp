#include "Entity.h"

Entity::Entity(size_t n_threads, size_t n)
	: n_threads_(n_threads), n_(n), processed_(0) {
	threads_.resize(n_threads);
}

void Entity::func() {
	std::mutex mutex;
	for (size_t i = 0; i < n_; i++) {
		mutex.lock();
		processed_++;
		mutex.unlock();
		std::this_thread::sleep_for(0.2s);
	}
}

void Entity::run() {
	for (size_t i = 0; i < n_threads_; i++) {
		std::thread* t = new std::thread(&Entity::func, this);
		threads_.push_back(t);
	}

	std::thread* t = new std::thread(&Entity::printBar, this);
	threads_.push_back(t);
}

void Entity::joinAllThreads() {
	for (auto& thread : threads_) {
		if (thread) {
			thread->join();
		}
	}
}

void Entity::printBar() {
	while (true) {
		std::mutex mutex;
		mutex.lock();
		int progress = processed_ * 100 / (n_ * n_threads_);
		mutex.unlock();

		if (progress == 100) {
			break;
		}

		std::cout << "\r";
		for (int i = 0; i < progress; i++) {
			std::cout << "#";
		}
		for (int i = 0; i < 100 - progress; i++) {
			std::cout << "-";
		}

		std::this_thread::sleep_for(0.2s);
	}
}