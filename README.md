# JVM
J Exception Virtual Machine

### Description

A mini-virtual machine environment script that shuts down an application unless it is an exception to the JException type

```sh
#!/bin/bash

# Specify the path to your Java class and the class name
class_path="path/to/YourJavaClass"
class_name="YourJavaClass"

# Run the Java class and capture the output
output=$(java -cp "$class_path" "$class_name")

# Function to check if a class extends JException or its subclasses
function isExtendingJException() {
    local class_name="$1"
    local class_code=$(javap -public "$class_name")
    if [[ $class_code == *"extends JException"* ]] || [[ $class_code == *"extends JExceptionFilter"* ]] || [[ $class_code == *"extends JExceptionFactory"* ]]; then
        return 0
    else
        return 1
    fi
}

# Function to check if the output contains "JException" or its subclasses
function isOutputContainsJException() {
    local output="$1"
    if [[ $output != *"JException"* ]] && [[ $output != *"JExceptionFilter"* ]] && [[ $output != *"JExceptionFactory"* ]]; then
        return 0
    else
        return 1
    fi
}

# Check if the output contains "JException" or its subclasses
if isOutputContainsJException "$output"; then
    # Check if the class extends JException or its subclasses
    if isExtendingJException "$class_name"; then
        echo "The class extends JException, JExceptionFilter, or JExceptionFactory. No error."
    else
        echo "Warning: The class $class_name is not a JException, JExceptionFilter, or JExceptionFactory."
        echo "This class should extend one of these classes to be valid."
        exit 1
    fi
else
    echo "The class $class_name is confirmed to be a JException, JExceptionFilter, or JExceptionFactory."
fi

# Function to check if the output contains "JErrorCode" and "JsonUtil"
function isOutputContainsJErrorCodeAndJsonUtil() {
    local output="$1"
    if [[ $output != *"JErrorCode"* ]] || [[ $output != *"JsonUtil"* ]]; then
        return 0
    else
        return 1
    fi
}

# Check if the output contains "JErrorCode" and "JsonUtil"
if isOutputContainsJErrorCodeAndJsonUtil "$output"; then
    echo "The class contains JErrorCode and JsonUtil. No error."
else
    echo "Warning: The class $class_name does not contain JErrorCode and JsonUtil."
    echo "These should be included in the class to be valid."
    exit 1
fi
```
