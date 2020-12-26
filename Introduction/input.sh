#!/bin/bash

# Reading the text from stdin and assigning it to the variable named "myName"

echo "Enter your name"
read myName

# Substitute the variable and print the text
echo "Hello ${myName}"
