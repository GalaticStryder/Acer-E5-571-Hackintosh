#!/bin/bash
# This script renames all files inside original folder to end with .aml.
# You don't need this if you've added .aml to all the files manually.
for f in original/*; do 
mv "$f" "$f.aml"
done
