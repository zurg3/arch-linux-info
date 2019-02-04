#!/bin/bash

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sir --skippgpcheck
cd ..
rm -rf yay
