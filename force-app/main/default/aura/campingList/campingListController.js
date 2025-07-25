({
	handleAddItem : function(component, event, helper) {
		
        // If we pass error checking, do some real work
            var myNewItem = event.getParam("item");
        //    helper.createItem(component, myNewItem);
            var saveAction = component.get("c.saveItem");
        
        saveAction.setParams({
            "camp" : myNewItem
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
	},
    doInit : function(component, event, helper) {
    	var action = component.get("c.getItems");
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state ==='SUCCESS'){
                component.set("v.items",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
    handleDeleteItem : function(component,event,helper){
        //item is from the event
        var myItemToDelete = event.getParam("item");
		//calling apex method and getting value        
        var deleteAction = component.get("c.deleteItem");
        var index = component.get("v.index");
         deleteAction.setParams({
            "camp" : myItemToDelete
        });
        deleteAction.setCallback(this,function(response){
            var state = response.getState();
            
            if(state === "SUCCESS"){
                //from campingList component attribute
                var items = component.get("v.items");
                items.splice(index,1);
                //items.splice(response.getReturnValue(),1);
                component.set("v.items",items);
            }
        });
        $A.enqueueAction(deleteAction);
    },
    handleSelectItem : function(component,event,helper){
        //item is from the event
        var myItemToUpdate = event.getParam("itemForSelectEvent");
		//calling apex method and getting value        
        var selectAction = component.get("c.getItems");
        
        selectAction.setCallback(this,function(response){
            var state = response.getState();
            
            if(state === "SUCCESS"){
                //from campingList component attribute
                component.set("v.selectedItem",myItemToUpdate);
            }
        });
        $A.enqueueAction(selectAction);
    },
    handleEditItem : function(component,event,helper){
        //item is from the event
        var myItemToUpdate = event.getParam("itemForEditEvent");
		//calling apex method and getting value        
        var editAction = component.get("c.editItem");
        var index = component.get("v.index");
         editAction.setParams({
            "camp" : myItemToUpdate
        });
        editAction.setCallback(this,function(response){
            var state = response.getState();
            var myData = response.getReturnValue();
            
            if(state === "SUCCESS"){
                //from campingList component attribute
               	var items = component.get("v.items");
                items.splice(index,1);
                items.push(myData);
                component.set("v.items",items);
                component.set("v.selectedItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                                       'Price__c': 0,'Packed__c': false }); 
            }
        });
        $A.enqueueAction(editAction);
    },
    handleSearchItem : function(component,event,helper){
        //item is from the event
        var myItemToSearch = event.getParam("itemForSearchEvent");
		//calling apex method and getting value        
        var getAction = component.get("c.getSearchItems");
         getAction.setParams({
            "record" : myItemToSearch
        });
        getAction.setCallback(this,function(response){
            var state = response.getState();
            var myData = response.getReturnValue();
            
            if(state === "SUCCESS"){
                //from campingList component attribute
                var items = component.get("v.items");
                items.clear();
                //items.splice(response.getReturnValue(),1);
                component.set("v.items",items);
                items.push(myData);
                component.set("v.items",items);
            }
        });
        $A.enqueueAction(getAction);
    }
})