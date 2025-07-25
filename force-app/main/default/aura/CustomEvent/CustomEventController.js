({
	doInit : function(component, event, helper) {
		var action = component.get("c.getEvents");
        
        action.setParams({
            
        });
        action.setCallback(this,function(result){
        	var resultData = result.getReturnValue();
        	if(resultData){
            	component.set("v.event", resultData);
        	}
        });
        $A.enqueueAction(action);
	}
})