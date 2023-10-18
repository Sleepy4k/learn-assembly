#!/bin/bash

# Ask developer which file name
echo "Please enter assembly file name : "

# Source file name (change this to your assembly source file)
read source_file

# Check if source file is empty
if [ -z "$source_file" ]; then
  source_file="hello"
fi

# Script to compile and run a assembly script
echo "Compiling assembly with nasm"

# Compile the C++ program
nasm -felf64 "$source_file".asm -o "$source_file".o && ld "$source_file".o -o "$source_file"

# Check if compilation was successful
if [ $? -eq 0 ]; then
  # Run the compiled binary
  echo "Compilation successful. Running $output_binary..."
  ./"$source_file"
else
  echo "Compilation failed."
fi

# Pause to keep the terminal open (optional)
read -p "Press Enter to exit..."
