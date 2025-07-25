({
	deleteItem : function(component, event, helper) {
        
        var newItem = component.get("v.item");
        var getIndex = component.get("v.index");
        var regEvent = component.getEvent("deleteItem");
        regEvent.setParams({"item" : newItem, "index":getIndex});
        regEvent.fire();
       
	},
    selectItem : function(component, event, helper) {
        
        var newItem = component.get("v.item");
        var regEvent = component.getEvent("selectItem");
        regEvent.setParams({"itemForSelectEvent" : newItem});
        regEvent.fire();
       
	}
})