({
	doInit : function(cmp, event, helper) {
		let action = cmp.get("c.getAccount");
        
        action.setParams({
            
        });
        
        action.setCallback(this,function(result){
            let resultData = result.getReturnValue();
            if(resultData){
                cmp.set("v.account",resultData);
            }
        });
        
        $A.enqueueAction(action);
	}
})