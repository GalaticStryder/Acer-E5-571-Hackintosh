#!/bin/bash
# This script cleans all acpi related files (aka. DSDTs and SSDTs) in their respective folders.
echo "Deleting already compiled DSDT..."
rm -rf acpi/compiled
echo "Deleting DSL editable DSDT..."
rm -rf acpi/dsl
echo "Deleting original DSDT..."
rm -rf acpi/original
echo "All clean."
