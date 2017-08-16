#!/bin/sh

for file in *.svg
do
    inkscape -z -f "${file}" -d 300 -e "${file%svg}png"
done
