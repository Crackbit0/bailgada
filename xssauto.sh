#!/bin/bash

# Prompt user for the target domain
read -p "Enter the target domain: " domain

# Run waymore with the given domain
waymore -i $domain -mode U -oU ./waymoreUrls.txt -url-filename -p 4

# Run gauplus or hakrawler with the given domain and filter the output
echo $domain | (gau || hakrawler) | grep -Ev "\.(jpeg|jpg|png|ico|woff|svg|css|ico|woff|ttf)$" > ./gaukrawler.txt

# Combine and process the URLs
cat ./waymoreUrls.txt ./gaukrawler.txt | sort -u | uro | gf endpoints > allUrls.txt

echo "All URLs have been processed and saved to allUrls.txt"