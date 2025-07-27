# LoanApplicationHandler Apex REST API

## Overview
The `LoanApplicationHandler` is a Salesforce Apex REST API that handles loan application submissions from external systems. It accepts JSON payloads containing loan application data and creates/updates the corresponding Salesforce records.

## Endpoint
```
POST /services/apexrest/LoanApplicationHandler/
```

## Authentication
Use OAuth 2.0 Bearer token authentication:
```
Authorization: Bearer YOUR_ACCESS_TOKEN
```

## Request Format

### Headers
```
Content-Type: application/json
Authorization: Bearer YOUR_ACCESS_TOKEN
```

### JSON Payload Structure
```json
{
  "productType": "Loan" | "Flash Credit" | "Credit Card",
  "loanUUID": "unique-loan-identifier",
  "account": {
    "uuid": "external-account-uuid",
    "name": "Company Name",
    "type": "Customer",
    "industry": "Banking"
  },
  "contact": {
    "uuid": "external-contact-uuid",
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com"
  },
  "loan": {
    "amount": 50000,
    "termMonths": 24,
    "interestRate": 4.5,
    "purpose": "Equipment Purchase"
  }
}
```

### Field Descriptions

#### Root Level
- `productType` (String): Type of financial product - "Loan", "Flash Credit", or "Credit Card"
- `loanUUID` (String): Unique identifier for the loan/opportunity

#### Account Object
- `uuid` (String): External unique identifier for the account
- `name` (String): Account name
- `type` (String): Account type (e.g., "Customer", "Prospect")
- `industry` (String): Industry classification

#### Contact Object
- `uuid` (String): External unique identifier for the contact
- `firstName` (String): Contact's first name
- `lastName` (String): Contact's last name
- `email` (String): Contact's email address

#### Loan Object
- `amount` (Number): Loan amount in base currency
- `termMonths` (Integer): Loan term in months
- `interestRate` (Number): Interest rate percentage
- `purpose` (String): Purpose of the loan

## Response Format

### Success Response (HTTP 200)
```json
{
  "success": true,
  "records": [
    {
      "objectType": "Account",
      "recordId": "001XXXXXXXXXXXXXXX",
      "isCreated": true
    },
    {
      "objectType": "Contact",
      "recordId": "003XXXXXXXXXXXXXXX",
      "isCreated": true
    },
    {
      "objectType": "Opportunity",
      "recordId": "006XXXXXXXXXXXXXXX",
      "isCreated": true
    }
  ]
}
```

### Error Response (HTTP 400)
```json
{
  "success": false,
  "error": "Error message describing what went wrong",
  "errorType": "ExceptionType"
}
```

## Business Logic

### Record Creation/Update
The API uses upsert operations with external IDs:

1. **Account**: Upserted using `UUID__c` field
2. **Contact**: Upserted using `UUID__c` field, linked to the Account
3. **Opportunity**: Upserted using `Loan_UUID__c` field, linked to Account and Contact

### Close Date Calculation
Based on `productType`:
- **Loan**: 30 days from today
- **Flash Credit**: 7 days from today  
- **Credit Card**: 14 days from today

### Opportunity Naming
Dynamic naming format: `{productType} for {firstName} {lastName}`
Examples:
- "Loan for John Doe"
- "Flash Credit for Jane Smith"
- "Credit Card for Bob Johnson"

## Custom Fields Required

### Account Object
- `UUID__c` (Text, External ID, Unique)

### Contact Object  
- `UUID__c` (Text, External ID, Unique)

### Opportunity Object
- `Loan_UUID__c` (Text, External ID, Unique)
- `Term__c` (Number)
- `Interest_Rate__c` (Number, 2 decimal places)
- `Purpose__c` (Text)

## Example Usage

### cURL Command
```bash
curl -X POST "https://your-instance.salesforce.com/services/apexrest/LoanApplicationHandler/" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "productType": "Loan",
    "loanUUID": "loan-123-456",
    "account": {
      "uuid": "acc-789-012",
      "name": "Tech Solutions Inc",
      "type": "Customer",
      "industry": "Technology"
    },
    "contact": {
      "uuid": "con-345-678",
      "firstName": "Alice",
      "lastName": "Wilson",
      "email": "alice.wilson@techsolutions.com"
    },
    "loan": {
      "amount": 75000,
      "termMonths": 36,
      "interestRate": 3.5,
      "purpose": "Business Expansion"
    }
  }'
```

## Error Handling
The API includes comprehensive error handling:
- Invalid JSON format
- Missing required fields
- Database operation failures
- Field validation errors

All errors return HTTP 400 with detailed error information.

## Testing
A comprehensive test class `LoanApplicationHandlerTest` is included with:
- Success scenarios for all product types
- Upsert functionality testing
- Close date calculation verification
- Error handling validation

## Security
- Uses `with sharing` keyword for record-level security
- External ID fields prevent duplicate records
- Proper authentication required via OAuth 2.0
