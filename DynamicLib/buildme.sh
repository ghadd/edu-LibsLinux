#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
ENDC='\033[0m'

function GREEN {
    echo -e "${GREEN}$1${ENDC}"
}

function YELLOW {
    echo -e "${YELLOW}$1${ENDC}"
}


function STATUS {
    if [ $? -eq 0 ]
    then
        GREEN ">> OK"
    else
        echo -e "${RED}>> Operation exited with code $?"
        exit $?
    fi
}

YELLOW ">> Starting dynamic library build..."
YELLOW ">> Creating object file with position independent code..."
g++ -c -fPIC Entity.cpp
STATUS

YELLOW ">> Creating shared library..."
g++ -shared -o libEntity.so Entity.o
STATUS

YELLOW ">> Copying libEntity.a to /usr/lib"
sudo cp libEntity.so /usr/lib
STATUS

if [[ $1 == "--clean" ]]
then
    YELLOW "Cleaning up directory"
    rm Entity.o
    rm libEntity.so
    STATUS
fi

GREEN "\n========> [$(whereis libEntity)] <========"