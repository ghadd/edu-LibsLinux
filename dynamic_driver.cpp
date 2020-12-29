#ifdef EXPLICIT

#include <dlfcn.h>
#include <unistd.h>
#include <iostream>

int main() {
  using foo_t = void(void);

  const char *libEntityPath = "/usr/lib/libEntity.so";
  auto libEntity = dlopen(libEntityPath, RTLD_LAZY);
  if (!libEntity) {
      std::cerr << "Error loading library." << std::endl;
      exit(1);
  }
  else {
      std::cout << "Library was opened successfully." << std::endl;
  }

  typedef void (*func_t)(void);

  func_t foo = (func_t)dlsym(libEntity, "foo");
  func_t bar = (func_t)dlsym(libEntity, "bar");
  if (!foo || !bar) {
    std::cerr << "Error loading function foo &| bar" << std::endl;
  }
  else {
    std::cout << "foo & bar loaded successfully" << std::endl;
  }

  foo();
  bar();

  dlclose(libEntity);

  return 0;
}

#else

#include "DynamicLib/Entity.h"

int main() {
    Entity e(4);
    e.run();
    e.joinAllThreads();
}

#endif