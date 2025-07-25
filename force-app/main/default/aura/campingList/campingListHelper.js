({
	createItem : function(component,item) {
		var saveAction = component.get("c.saveItem");
        
        saveAction.setParams({
            "camp" : item
        });
        
        saveAction.setCallback(this,function(response){
            var state = response.getState();
            var myData = response.getReturnValue();
            
            if(state === "SUCCESS"){
                var items = component.get("v.items");
                items.push(myData);
                component.set("v.items",items);
                /*component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                                       'Price__c': 0,'Packed__c': false });*/
            }
        });
        $A.enqueueAction(saveAction);
	}
})