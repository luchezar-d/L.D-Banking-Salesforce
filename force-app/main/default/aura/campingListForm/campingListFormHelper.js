({
	createItem : function(component) {
		
		var camping = component.get("v.newItem");
        var updateCamping = component.getEvent("addItem");
        updateCamping.setParams({"item" : camping});
        updateCamping.fire();
        component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                                       'Price__c': 0,'Packed__c': false }); 
	},
    editItem : function(component) {
		
		var newItem = component.get("v.newItem");
        var getIndex = component.get("v.index");
        var regEvent = component.getEvent("editItem");
        regEvent.setParams({"itemForEditEvent" : newItem, "index":getIndex});
        regEvent.fire(); 
	},
    searchItem : function(component) {
		
		var searchItem = component.get("v.newItem");
        var regEvent = component.getEvent("searchForItem");
        regEvent.setParams({"itemForSearchEvent" : searchItem});
        regEvent.fire(); 
	}
    
});