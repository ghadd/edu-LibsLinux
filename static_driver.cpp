#include "StaticLib/Entity.h"

int main() {
    Entity e(4);
    e.run();
    e.joinAllThreads();

    return 0;
}