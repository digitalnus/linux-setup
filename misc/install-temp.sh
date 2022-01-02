#!/bin/sh

sudo apt-get install gcc
gcc temp.c -o temp
./temp
sudo mv ./temp /usr/local/bin/
