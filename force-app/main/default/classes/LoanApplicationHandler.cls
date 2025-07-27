@RestResource(urlMapping='/LoanApplicationHandler/*')
global with sharing class LoanApplicationHandler {
    
    @HttpPost
    global static void handleLoanApplication() {
        RestResponse response = RestContext.response;
        response.addHeader('Content-Type', 'application/json');
        
        try {
            // Get the request body
            String requestBody = RestContext.request.requestBody.toString();
            
            // Deserialize the JSON payload
            LoanApplicationRequest loanRequest = (LoanApplicationRequest) JSON.deserialize(requestBody, LoanApplicationRequest.class);
            
            // Process the loan application
            LoanApplicationResponse result = processLoanApplication(loanRequest);
            
            // Return success response
            response.statusCode = 200;
            response.responseBody = Blob.valueOf(JSON.serialize(result));
            
        } catch (Exception e) {
            // Handle errors
            ErrorResponse errorResp = new ErrorResponse();
            errorResp.success = false;
            errorResp.error = e.getMessage();
            errorResp.errorType = e.getTypeName();
            
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(JSON.serialize(errorResp));
        }
    }
    
    private static LoanApplicationResponse processLoanApplication(LoanApplicationRequest request) {
        LoanApplicationResponse result = new LoanApplicationResponse();
        result.success = true;
        result.records = new List<RecordResult>();
        
        // 1. Upsert Account
        Account acc = new Account();
        acc.UUID__c = request.account.uuid;
        acc.Name = request.account.name;
        acc.Type = request.account.type;
        acc.Industry = request.account.industry;
        
        Schema.SObjectField accountExternalId = Account.UUID__c;
        Database.UpsertResult accountResult = Database.upsert(acc, accountExternalId, false);
        
        result.records.add(new RecordResult('Account', accountResult.getId(), accountResult.isCreated()));
        
        // 2. Upsert Contact
        Contact con = new Contact();
        con.UUID__c = request.contact.uuid;
        con.FirstName = request.contact.firstName;
        con.LastName = request.contact.lastName;
        con.Email = request.contact.email;
        con.AccountId = accountResult.getId();
        
        Schema.SObjectField contactExternalId = Contact.UUID__c;
        Database.UpsertResult contactResult = Database.upsert(con, contactExternalId, false);
        
        result.records.add(new RecordResult('Contact', contactResult.getId(), contactResult.isCreated()));
        
        // 3. Calculate CloseDate based on product type
        Date closeDate = calculateCloseDate(request.productType);
        
        // 4. Upsert Opportunity
        Opportunity opp = new Opportunity();
        opp.Loan_UUID__c = request.loanUUID;
        opp.Name = request.productType + ' for ' + request.contact.firstName + ' ' + request.contact.lastName;
        opp.Type = request.productType;
        opp.AccountId = accountResult.getId();
        opp.Amount = request.loan.amount;
        opp.Term__c = request.loan.termMonths;
        opp.Interest_Rate__c = request.loan.interestRate;
        opp.Purpose__c = request.loan.purpose;
        opp.CloseDate = closeDate;
        opp.StageName = 'Prospecting'; // Default stage
        
        // Link to Contact (assuming there's a Contact lookup field)
        opp.ContactId = contactResult.getId();
        
        Schema.SObjectField opportunityExternalId = Opportunity.Loan_UUID__c;
        Database.UpsertResult opportunityResult = Database.upsert(opp, opportunityExternalId, false);
        
        result.records.add(new RecordResult('Opportunity', opportunityResult.getId(), opportunityResult.isCreated()));
        
        return result;
    }
    
    private static Date calculateCloseDate(String productType) {
        Date today = Date.today();
        
        switch on productType {
            when 'Loan' {
                return today.addDays(30);
            }
            when 'Flash Credit' {
                return today.addDays(7);
            }
            when 'Credit Card' {
                return today.addDays(14);
            }
            when else {
                return today.addDays(30); // Default to 30 days
            }
        }
    }
    
    // Wrapper Classes
    global class LoanApplicationRequest {
        public String productType;
        public String loanUUID;
        public AccountData account;
        public ContactData contact;
        public LoanData loan;
    }
    
    global class AccountData {
        public String uuid;
        public String name;
        public String type;
        public String industry;
    }
    
    global class ContactData {
        public String uuid;
        public String firstName;
        public String lastName;
        public String email;
    }
    
    global class LoanData {
        public Decimal amount;
        public Integer termMonths;
        public Decimal interestRate;
        public String purpose;
    }
    
    global class LoanApplicationResponse {
        public Boolean success;
        public List<RecordResult> records;
    }
    
    global class RecordResult {
        public String objectType;
        public String recordId;
        public Boolean isCreated;
        
        public RecordResult(String objectType, String recordId, Boolean isCreated) {
            this.objectType = objectType;
            this.recordId = recordId;
            this.isCreated = isCreated;
        }
    }
    
    global class ErrorResponse {
        public Boolean success;
        public String error;
        public String errorType;
    }
}
