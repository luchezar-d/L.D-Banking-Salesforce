#!/bin/bash

# Test Salesforce API connection
echo "Testing Salesforce API connection..."

ACCESS_TOKEN="00D6g000004Xk5v!AQUAQPeGBc1bqKYH5IVhm9.YSqbh6Zh3.HEEYIHcGh9punXtwmZFGMVyzLCJUJvRI_oi.m1btN6IfaS2RftjLLxk7HKcvMuI"
INSTANCE_URL="https://lachezardomain-dev-ed.my.salesforce.com"

echo "1. Testing API versions endpoint..."
curl -s -H "Authorization: Bearer $ACCESS_TOKEN" "$INSTANCE_URL/services/data/"

echo -e "\n\n2. Creating a new Account..."
curl -s -X POST "$INSTANCE_URL/services/data/v61.0/sobjects/Account/" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "Name": "L.D Banking Corp - API Test",
    "Type": "Customer",
    "Industry": "Banking"
  }'

echo -e "\n\n3. Verifying the created account..."
curl -s -H "Authorization: Bearer $ACCESS_TOKEN" "$INSTANCE_URL/services/data/v61.0/sobjects/Account/001Kf000019Z6BKIA0"

echo -e "\n\n4. Querying all accounts with 'L.D Banking' in name..."
curl -s -H "Authorization: Bearer $ACCESS_TOKEN" "$INSTANCE_URL/services/data/v61.0/query/?q=SELECT+Id,Name,Type,Industry,CreatedDate+FROM+Account+WHERE+Name+LIKE+'%25L.D+Banking%25'"

echo -e "\n\nAPI test completed."
