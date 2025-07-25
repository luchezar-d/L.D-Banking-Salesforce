public class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext ctx){
        List<Lead> blankLeads = [SELECT LeadSource FROM Lead Where LeadSource='' LIMIT 200];
        List<Lead> leadsToUp = new List<Lead>();
        
        for(Lead l : blankLeads){
            l.LeadSource = 'Dreamforce';
            leadsToUp.add(l);
        }
        update leadsToUp;
    }
}