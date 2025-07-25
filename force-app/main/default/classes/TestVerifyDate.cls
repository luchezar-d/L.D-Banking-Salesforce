@isTest
public class TestVerifyDate {
    @isTest static void CheckDatesTest() {
        Date today = System.today();
        VerifyDate.CheckDates(today,today+10);
        VerifyDate.CheckDates(today,today+100);
    }
}