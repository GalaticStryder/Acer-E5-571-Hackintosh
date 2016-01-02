#!/bin/bash
# This script renames all files inside ASCPITables to end with .aml.
# You don't need this if you've added .aml to all the files manually.
for f in ascpi-tables/*; do 
mv "$f" "$f.aml"
done
