@IsTest
private class LoanApplicationHandlerTest {
    
    @TestSetup
    static void setupTestData() {
        // Create test custom fields if they don't exist (handled by custom fields)
    }
    
    @IsTest
    static void testSuccessfulLoanApplication() {
        // Prepare test data
        String testPayload = '{'
            + '"productType": "Loan",'
            + '"loanUUID": "test-loan-uuid-123",'
            + '"account": {'
                + '"uuid": "test-account-uuid-456",'
                + '"name": "Test Banking Corp",'
                + '"type": "Customer",'
                + '"industry": "Banking"'
            + '},'
            + '"contact": {'
                + '"uuid": "test-contact-uuid-789",'
                + '"firstName": "John",'
                + '"lastName": "Doe",'
                + '"email": "john.doe@testbank.com"'
            + '},'
            + '"loan": {'
                + '"amount": 50000,'
                + '"termMonths": 24,'
                + '"interestRate": 4.5,'
                + '"purpose": "Equipment Purchase"'
            + '}'
        + '}';
        
        // Set up RestContext
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/LoanApplicationHandler/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(testPayload);
        
        RestResponse response = new RestResponse();
        
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        
        // Call the REST API
        LoanApplicationHandler.handleLoanApplication();
        
        Test.stopTest();
        
        // Verify response
        System.assertEquals(200, response.statusCode, 'Expected successful response');
        
        String responseBody = response.responseBody.toString();
        System.assert(responseBody.contains('"success":true'), 'Response should indicate success');
        
        // Verify records were created
        List<Account> accounts = [SELECT Id, Name, UUID__c FROM Account WHERE UUID__c = 'test-account-uuid-456'];
        System.assertEquals(1, accounts.size(), 'Account should be created');
        System.assertEquals('Test Banking Corp', accounts[0].Name, 'Account name should match');
        
        List<Contact> contacts = [SELECT Id, FirstName, LastName, UUID__c FROM Contact WHERE UUID__c = 'test-contact-uuid-789'];
        System.assertEquals(1, contacts.size(), 'Contact should be created');
        System.assertEquals('John', contacts[0].FirstName, 'Contact first name should match');
        
        List<Opportunity> opportunities = [SELECT Id, Name, Loan_UUID__c, Amount FROM Opportunity WHERE Loan_UUID__c = 'test-loan-uuid-123'];
        System.assertEquals(1, opportunities.size(), 'Opportunity should be created');
        System.assertEquals(50000, opportunities[0].Amount, 'Opportunity amount should match');
    }
    
    @IsTest
    static void testFlashCreditCloseDate() {
        String testPayload = '{'
            + '"productType": "Flash Credit",'
            + '"loanUUID": "test-flash-uuid-123",'
            + '"account": {'
                + '"uuid": "test-account-uuid-flash",'
                + '"name": "Flash Credit Corp",'
                + '"type": "Customer",'
                + '"industry": "Financial Services"'
            + '},'
            + '"contact": {'
                + '"uuid": "test-contact-uuid-flash",'
                + '"firstName": "Jane",'
                + '"lastName": "Smith",'
                + '"email": "jane.smith@flashcredit.com"'
            + '},'
            + '"loan": {'
                + '"amount": 1000,'
                + '"termMonths": 3,'
                + '"interestRate": 8.0,'
                + '"purpose": "Emergency"'
            + '}'
        + '}';
        
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/LoanApplicationHandler/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(testPayload);
        
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        LoanApplicationHandler.handleLoanApplication();
        Test.stopTest();
        
        // Verify Flash Credit has 7-day close date
        List<Opportunity> opportunities = [SELECT Id, CloseDate FROM Opportunity WHERE Loan_UUID__c = 'test-flash-uuid-123'];
        System.assertEquals(1, opportunities.size(), 'Flash Credit opportunity should be created');
        
        Date expectedCloseDate = Date.today().addDays(7);
        System.assertEquals(expectedCloseDate, opportunities[0].CloseDate, 'Flash Credit should have 7-day close date');
    }
    
    @IsTest
    static void testCreditCardCloseDate() {
        String testPayload = '{'
            + '"productType": "Credit Card",'
            + '"loanUUID": "test-card-uuid-123",'
            + '"account": {'
                + '"uuid": "test-account-uuid-card",'
                + '"name": "Credit Card Corp",'
                + '"type": "Customer",'
                + '"industry": "Retail"'
            + '},'
            + '"contact": {'
                + '"uuid": "test-contact-uuid-card",'
                + '"firstName": "Bob",'
                + '"lastName": "Johnson",'
                + '"email": "bob.johnson@retail.com"'
            + '},'
            + '"loan": {'
                + '"amount": 5000,'
                + '"termMonths": 12,'
                + '"interestRate": 15.9,'
                + '"purpose": "Personal"'
            + '}'
        + '}';
        
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/LoanApplicationHandler/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(testPayload);
        
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        LoanApplicationHandler.handleLoanApplication();
        Test.stopTest();
        
        // Verify Credit Card has 14-day close date
        List<Opportunity> opportunities = [SELECT Id, CloseDate FROM Opportunity WHERE Loan_UUID__c = 'test-card-uuid-123'];
        System.assertEquals(1, opportunities.size(), 'Credit Card opportunity should be created');
        
        Date expectedCloseDate = Date.today().addDays(14);
        System.assertEquals(expectedCloseDate, opportunities[0].CloseDate, 'Credit Card should have 14-day close date');
    }
    
    @IsTest
    static void testUpsertExistingRecords() {
        // First, create records
        Account testAccount = new Account(
            Name = 'Original Account Name',
            UUID__c = 'test-existing-account-uuid',
            Type = 'Prospect'
        );
        insert testAccount;
        
        Contact testContact = new Contact(
            FirstName = 'Original',
            LastName = 'Name',
            UUID__c = 'test-existing-contact-uuid',
            Email = 'original@email.com',
            AccountId = testAccount.Id
        );
        insert testContact;
        
        Opportunity testOpportunity = new Opportunity(
            Name = 'Original Opportunity',
            Loan_UUID__c = 'test-existing-loan-uuid',
            CloseDate = Date.today().addDays(60),
            StageName = 'Closed Won',
            AccountId = testAccount.Id
        );
        insert testOpportunity;
        
        // Now test upsert with updated data
        String testPayload = '{'
            + '"productType": "Loan",'
            + '"loanUUID": "test-existing-loan-uuid",'
            + '"account": {'
                + '"uuid": "test-existing-account-uuid",'
                + '"name": "Updated Account Name",'
                + '"type": "Customer",'
                + '"industry": "Banking"'
            + '},'
            + '"contact": {'
                + '"uuid": "test-existing-contact-uuid",'
                + '"firstName": "Updated",'
                + '"lastName": "Name",'
                + '"email": "updated@email.com"'
            + '},'
            + '"loan": {'
                + '"amount": 75000,'
                + '"termMonths": 36,'
                + '"interestRate": 3.5,'
                + '"purpose": "Business Expansion"'
            + '}'
        + '}';
        
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/LoanApplicationHandler/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(testPayload);
        
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        LoanApplicationHandler.handleLoanApplication();
        Test.stopTest();
        
        // Verify records were updated, not created
        System.assertEquals(200, response.statusCode, 'Should return success');
        
        String responseBody = response.responseBody.toString();
        System.assert(responseBody.contains('"isCreated":false'), 'Records should be updated, not created');
        
        // Verify the updates
        Account updatedAccount = [SELECT Name FROM Account WHERE UUID__c = 'test-existing-account-uuid'];
        System.assertEquals('Updated Account Name', updatedAccount.Name, 'Account name should be updated');
        
        Contact updatedContact = [SELECT FirstName, Email FROM Contact WHERE UUID__c = 'test-existing-contact-uuid'];
        System.assertEquals('Updated', updatedContact.FirstName, 'Contact name should be updated');
        System.assertEquals('updated@email.com', updatedContact.Email, 'Contact email should be updated');
    }
    
    @IsTest
    static void testErrorHandling() {
        // Test with invalid JSON
        String invalidPayload = '{ invalid json }';
        
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/LoanApplicationHandler/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(invalidPayload);
        
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        LoanApplicationHandler.handleLoanApplication();
        Test.stopTest();
        
        // Verify error response
        System.assertEquals(400, response.statusCode, 'Should return error status');
        
        String responseBody = response.responseBody.toString();
        System.assert(responseBody.contains('"success":false'), 'Response should indicate failure');
        System.assert(responseBody.contains('"error"'), 'Response should contain error message');
    }
}
