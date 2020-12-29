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

function RED {
    echo -e "${RED}$1${ENDC}"
}

function STATUS {
    if [ $? -eq 0 ]
    then
        GREEN ">> OK"
    else
        RED ">> Operation exited with code $?"
        exit $?
    fi
}

function build {
    sudo chmod +x buildme.sh && ./buildme.sh --clean
}

function usage {
    echo ">> Argument 1: either --static or --dynamic or --help"
    echo ">> Argument 2 (only if --dynamic was provided): either --explicit or implicit"
}

mode=$1
if [[ $mode == "--static" ]]
then
    YELLOW ">> Creating static library..."
    cd StaticLib && build && cd ..  
    STATUS

    YELLOW ">> Compiling driver program..."
    g++ static_driver.cpp -o static_driver -l:libEntity.a -lpthread
    STATUS

    YELLOW ">> Running executable..."
    ./static_driver

elif [[ $mode == "--dynamic" ]]
then
    YELLOW ">> Creating dynamic library..."
    cd DynamicLib && build && cd ..
    STATUS

    linking_mode=$2
    if [[ $linking_mode == "--explicit" ]]
    then
        YELLOW ">> Compiling driver program with explicit(run-time) .so linking..."
        g++ dynamic_driver.cpp -o dynamic_driver -lpthread -DEXPLICIT -ldl
        STATUS
        
        YELLOW ">> Running executable..."
        ./dynamic_driver
    
    elif [[ $linking_mode == "--implicit" ]]
    then
        YELLOW ">> Compiling driver program with implicit .so linking..."
        g++ dynamic_driver.cpp -o dynamic_driver -lEntity -lpthread 
        STATUS 

        YELLOW ">> Running executable..."
        ./dynamic_driver
    else
        RED ">> Invalid option $2 for linking mode!"
        exit 1
    fi
elif [[ $mode == "--help" ]]
then 
    usage
else
    RED ">> Invalid option $1 for library type!"
    exit 1
fi

YELLOW ">> Cleaning up..."
rm dynamic_driver || 1
rm static_driver || 1