public class NewCaseListController {
    public List<Case> getNewCases() {
        return [SELECT id,CaseNumber FROM CASE WHERE status='New'];
    }
}