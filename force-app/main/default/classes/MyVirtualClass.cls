public virtual with sharing class MyVirtualClass {
    
    String name {get; private set;}
    Integer weight {get; private set;}
    Integer age {get; private set;}
    
    public MyVirtualClass(String name,Integer weight, Integer age){
        this.name = name;
        this.weight = weight;
        this.age = age;
    }
    
    public void makeSound(){
        system.debug('Im making a sound');
    }
    
    public virtual void eat(){
        system.debug('Im eating');
    }
    
    public virtual void move(){
        system.debug('Im moving');
    }
    
    public virtual void drink(){
        system.debug('im drinking');
    }
}