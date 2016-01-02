#!/bin/bash
# This script cleans all aicpi related files (aka. DSDTs and SSDTs) in their respective folders.
echo "Deleting already compiled DSDT..."
rm -rf dsdt/compiled
echo "Deleting DSL editable DSDT..."
rm -rf dsdt/dsl
echo "Deleting original DSDT..."
rm -rf dsdt/original
echo "All clean."
