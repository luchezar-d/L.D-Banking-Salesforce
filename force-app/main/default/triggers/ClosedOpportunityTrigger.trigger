trigger ClosedOpportunityTrigger on Opportunity (after insert, before insert) {
    List<Task> task = new List<Task>();
    
    for(Opportunity o : Trigger.new){
        if(o.stagename=='Closed Won'){
            Task t = new Task(
                Subject = 'Follow Up Test Task',
                whatid = o.id,
                Status = 'Active'
            );
            task.add(t);
        }
    }
    insert task;
}