#!/bin/bash

git clone https://github.com/zurg3/sah.git
cd sah
makepkg -si
cd ..
rm -rf sah
