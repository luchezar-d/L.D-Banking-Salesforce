public class TestObjectController {
    public static void createTestObjects(Date startDate, Date endDate, Integer listSize){
        List<TestObject__c> testObjects = new List<TestObject__c>();
        
        for(Integer i = 0; i < listSize; i++){
            TestObject__c test = new TestObject__c();
            test.Start_Date__c = startDate + i;
            test.End_Date__c = endDate + i;
            
            testObjects.add(test);
        }
        insert testObjects;
	}
    public static void updateTestObjects(Date startDate, Date endDate, String Name){
        List<TestObject__c> tests = [SELECT id, Name, Start_Date__c, End_Date__c FROM TestObject__c];
        
        for(TestObject__c to : tests){
            to.Start_Date__c = startDate;
            to.End_Date__c = endDate;
            to.Name = Name;
        }
        update tests;
    }
    public static void deleteTestObjects(String Name){
        List<TestObject__c> tests = [SELECT id, Name FROM TestObject__c WHERE Name = 'Trying a random name'];
        
        //for(TestObject__c to : tests){
        delete tests;
        Map<String,TestObject__c> myMap = new Map<String,TestObject__c>([SELECT id, Name FROM TestObject__c WHERE Name = 'Trying a random name']);
    }
}