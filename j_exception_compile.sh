#!/bin/bash

# Specify the path to your Java class and the class name
class_path="path/to/YourJavaClass"
class_name="YourJavaClass"

# Run the Java class and capture the output
output=$(java -cp "$class_path" "$class_name")

# Function to check if a class extends JException
function isExtendingJException() {
    local class_name="$1"
    local class_code=$(javap -public "$class_name")
    if [[ $class_code == *"extends JException"* ]]; then
        return 0
    else
        return 1
    fi
}

# Check if the output contains "JException"
if [[ $output != *"JException"* ]]; then
    # Check if the class extends JException
    if isExtendingJException "$class_name"; then
        echo "The class extends JException, no error."
    else
        echo "Warning: It is not a JException."
        exit 1
    fi
else
    echo "JException is confirmed."
fi
