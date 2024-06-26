#!/bin/bash

echo "getData begins!!"

n="$1"
output_file="madison${n}.csv"

echo "collecting the $n year's data!" >&2

# Create a directory to extract files
mkdir -p "$n"
wget -q https://www.ncei.noaa.gov/data/global-hourly/archive/csv/${n}.tar.gz -P "$n"
tar -xzvf "$n/${n}.tar.gz" -C "$n"

for file in "$n"/*.csv; do
    awk -F ',' '$7 ~ /MADISON DANE CO REGIONAL AIRPORT/ {print}' "$file" >> "$output_file"
done

# Check if the output file is not empty
if [ -s "$output_file" ]; then
    echo "$output_file is not empty"
else
    echo "$output_file is empty"
fi

echo "collected the $n year's Madison data!" >&2

# Clean up downloaded files
rm -rf "$n"
rm -f "$n.tar.gz"


