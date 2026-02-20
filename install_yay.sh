#!/bin/bash

git clone https://aur.archlinux.org/yay-bin.git
cd yay
makepkg -sir --skippgpcheck
cd ..
rm -rf yay
