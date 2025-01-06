#!/bin/bash

# Check if a directory name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory-name>"
  exit 1
fi

DIRECTORY_NAME=$1
SOURCE_DIR="./content/products/$DIRECTORY_NAME"
DEST_DIR="./archives/$DIRECTORY_NAME"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory '$SOURCE_DIR' does not exist."
  exit 1
fi

# Ensure the destination directory exists
mkdir -p "./archives"

# Move the directory
mv "$SOURCE_DIR" "$DEST_DIR"

# Check if the move was successful
if [ $? -eq 0 ]; then
  echo "Successfully moved '$SOURCE_DIR' to '$DEST_DIR'."
else
  echo "Error: Failed to move '$SOURCE_DIR'."
  exit 1
fi
