@isTest
public class TestRestrictContactByName {
    @isTest static void TestInsertUpdateContact() {
        Contact con = new Contact(firstname = 'John', lastname = 'INVALIDNAME');
        
        Test.startTest();
        Database.SaveResult result = Database.insert(con);
        Test.stopTest();
        
        //System.assertEquals('The Last Name "'+con.LastName+'" is not allowed for DML',result.getErrors()[0].getMessage());
        System.assert(!result.isSuccess());
    }
}