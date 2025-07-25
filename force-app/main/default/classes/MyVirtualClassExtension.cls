public with sharing class MyVirtualClassExtension extends MyVirtualClass{
    
    String breed {get; private set;}
    String color {get; private set;}
	
    public MyVirtualClassExtension(String name,Integer weight,Integer age,String breed,String color){
        super(name,weight,age);
        this.breed = breed;
        this.color = color;
    }
    
    public override void eat(){ 
        system.debug('child class is eating now');
    }
    
    public override void move(){
        system.debug('child class is moving now');
    }
    
}