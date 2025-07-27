#!/bin/bash

# Test the LoanApplicationHandler Apex REST API

ACCESS_TOKEN="00D6g000004Xk5v!AQUAQE0JNxb36YRLwm24PrAo4GQcoAe9zILpfeoAiI4xjZFNN4uuqLfIznbKbBLASkzLHS_AH0lbJLNKlItsbYCRHyAmDcZB"
INSTANCE_URL="https://lachezardomain-dev-ed.my.salesforce.com"

echo "Testing LoanApplicationHandler Apex REST API..."

# Test 1: Loan Application
echo -e "\n1. Testing Loan Application..."
TIMESTAMP=$(date +%s)
curl -X POST "$INSTANCE_URL/services/apexrest/LoanApplicationHandler/" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"productType\": \"Loan\",
    \"loanUUID\": \"loan-uuid-$TIMESTAMP\",
    \"account\": {
      \"uuid\": \"account-uuid-$TIMESTAMP\",
      \"name\": \"L.D Banking Test Corp\",
      \"type\": \"Customer\",
      \"industry\": \"Banking\"
    },
    \"contact\": {
      \"uuid\": \"contact-uuid-$TIMESTAMP\",
      \"firstName\": \"John\",
      \"lastName\": \"Doe\",
      \"email\": \"john.doe@ldbanking.com\"
    },
    \"loan\": {
      \"amount\": 50000,
      \"termMonths\": 24,
      \"interestRate\": 4.5,
      \"purpose\": \"Equipment Purchase\"
    }
  }"

echo -e "\n\n2. Testing Flash Credit Application..."
TIMESTAMP2=$(date +%s)
curl -X POST "$INSTANCE_URL/services/apexrest/LoanApplicationHandler/" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"productType\": \"Flash Credit\",
    \"loanUUID\": \"flash-uuid-$TIMESTAMP2\",
    \"account\": {
      \"uuid\": \"flash-account-uuid-$TIMESTAMP2\",
      \"name\": \"Flash Credit Solutions\",
      \"type\": \"Customer\",
      \"industry\": \"Financial Services\"
    },
    \"contact\": {
      \"uuid\": \"flash-contact-uuid-$TIMESTAMP2\",
      \"firstName\": \"Jane\",
      \"lastName\": \"Smith\",
      \"email\": \"jane.smith@flashcredit.com\"
    },
    \"loan\": {
      \"amount\": 5000,
      \"termMonths\": 6,
      \"interestRate\": 8.0,
      \"purpose\": \"Emergency Fund\"
    }
  }"

echo -e "\n\n3. Testing Credit Card Application..."
TIMESTAMP3=$(date +%s)
curl -X POST "$INSTANCE_URL/services/apexrest/LoanApplicationHandler/" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"productType\": \"Credit Card\",
    \"loanUUID\": \"card-uuid-$TIMESTAMP3\",
    \"account\": {
      \"uuid\": \"card-account-uuid-$TIMESTAMP3\",
      \"name\": \"Credit Card Corp\",
      \"type\": \"Customer\",
      \"industry\": \"Retail\"
    },
    \"contact\": {
      \"uuid\": \"card-contact-uuid-$TIMESTAMP3\",
      \"firstName\": \"Bob\",
      \"lastName\": \"Johnson\",
      \"email\": \"bob.johnson@retail.com\"
    },
    \"loan\": {
      \"amount\": 10000,
      \"termMonths\": 12,
      \"interestRate\": 15.9,
      \"purpose\": \"Personal Use\"
    }
  }"

echo -e "\n\nAPI testing completed."
