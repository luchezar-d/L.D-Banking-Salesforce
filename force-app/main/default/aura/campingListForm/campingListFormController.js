({
	clickCreateItem : function(component, event, helper) {
        var validCamping = component.find('campingform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validCamping){
        helper.createItem(component);
        }
	},clickUpdateItem : function(component,evet,helper){
        var validCamping = component.find('campingform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validCamping){
        helper.editItem(component);
        }
    }
    ,clickSearchItem : function(component,evet,helper){
        var validCamping = component.find('campingform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validCamping){
        helper.searchItem(component);
        }
    }
    /*,
    doInit : function(component, event, helper) {
    	var action = component.get("c.getSearchItems");
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state ==='SUCCESS'){
                component.set("v.searchList",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);*/
	/*},
    handleSearchtItem : function(component, event, helper) {
		
        // If we pass error checking, do some real work
            var mySearchValue = event.getParam("!v.searchValue.Name");
        //    helper.createItem(component, myNewItem);
            var searchAction = component.get("c.getSearchItems");
        
        searchAction.setParams({
            "camp" : mySearchValue
        });
        
        searchAction.setCallback(this,function(response){
            var state = response.getState();
            var myData = response.getReturnValue();
            
            if(state === "SUCCESS"){
                var searchList = component.get("v.searchList");
                searchList.push(myData);
                component.set("v.searchList",searchList);
                /*component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                                       'Price__c': 0,'Packed__c': false });*/
           /* }
        });
        $A.enqueueAction(searchAction);
	}*/
})