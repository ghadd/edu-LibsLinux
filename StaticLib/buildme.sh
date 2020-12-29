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

YELLOW ">> Starting static library build..."
YELLOW ">> Creating object file..."
g++ -c Entity.cpp
STATUS

YELLOW ">> Archiving static library..."
ar rcsf libEntity.a Entity.o
STATUS

YELLOW ">> Copying libEntity.a to /usr/lib"
sudo cp libEntity.a /usr/lib
STATUS

if [[ $1 == "--clean" ]]
then
    YELLOW "Cleaning up directory"
    rm Entity.o
    rm libEntity.a
    STATUS
fi

GREEN "\n========> [$(whereis libEntity.a)] <========"