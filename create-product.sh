#!/bin/bash

# Check if both title and type were provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Please provide both a title and a type."
  exit 1
fi

# Assign the first parameter to 'title' and the second to 'type'
title=$1
type=$2

# Convert title and type to lowercase for the directory path, replace spaces with dashes
lowercase_title=$(echo "$title" | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')
lowercase_type=$(echo "$type" | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

# Create a new directory based on the lowercase 'type' and 'title'
product_path="$lowercase_title-$lowercase_type"
mkdir -p "content/products/$product_path"

# Copy the template index.md file to the new directory
cp "templates/product/index.md" "content/products/$product_path/index.md"

# Get the current date in the desired format (portable version)
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS date command
  current_date=$(date -j -u "+%Y-%m-%dT%H:%M:%S%z")
else
  # Linux date command
  current_date=$(date --iso-8601=seconds)
fi

# Replace placeholders with the actual values (retain the original case for title and type)
# Use an alternate delimiter (|) to avoid conflicts with slashes in paths
sed -i '' -e "s|{{ .Date }}|$current_date|" "content/products/$product_path/index.md"
sed -i '' -e "s|{{ .Title }}|$title|" "content/products/$product_path/index.md"
sed -i '' -e "s|{{ .Type }}|$type|" "content/products/$product_path/index.md"
sed -i '' -e "s|{{ .Lowercase_title }}|$lowercase_title|" "content/products/$product_path/index.md"
sed -i '' -e "s|{{ .Lowercase_type }}|$lowercase_type|" "content/products/$product_path/index.md"
sed -i '' -e "s|{{ .Product_path }}|$product_path|" "content/products/$product_path/index.md"

# Transfer and rename three image files to the product directory
for i in 1 2 3; do
  source_image="templates/products/template-$i.jpg" # Adjust source path if needed
  destination_image="content/products/$product_path/$lowercase_title-$i.jpg"

  if [ -f "$source_image" ]; then
    cp "$source_image" "$destination_image"
    echo "Copied $source_image to $destination_image"
  else
    echo "Source image $source_image not found."
  fi
done

echo "Created new content at content/products/$product_path ."
