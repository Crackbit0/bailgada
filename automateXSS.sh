# #!/bin/bash
# read TARGET
# subfinder -d $TARGET -silent | tee domains.txt
# cat domains.txt | waybackurls | tee waybackurls.txt
# cat waybackurls.txt | dalfox pipe > xss.txt

#!/bin/bash

# Ask for the target
read -p "Enter target: " TARGET

# Run subfinder
subfinder -d $TARGET -silent | tee subdomains.txt

# Run httpx
httpx -l subdomains.txt -o httpx.txt

# Run gau
echo "$TARGET" | gau --threads 5 >> Enpoints1.txt

# Run katana
cat httpx.txt | katana -jc >> Enpoints.txt

# Combine endpoints
cat Enpoints1.txt Enpoints.txt >Enpoints2.txt

# Run uro
cat Enpoints2.txt | uro >> Endpoints_F.txt

# Run gf
cat Endpoints_F.txt | gf xss >> XSS1.txt

# Run Gxss
cat XSS1.txt | Gxss -p khXSS -o XSS_Ref.txt

# Run dalfox
dalfox file XSS_Ref.txt -o Vulnerable_XSS.txt