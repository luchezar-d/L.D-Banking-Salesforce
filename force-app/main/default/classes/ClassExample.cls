public class ClassExample {
    
    public List<String> simpleCollection;
    public Set<Integer> simpleSet;
    public Map<String,Integer> simpleMap;
    
    public static List<ClassExample> classExampleList;
    
    public void DoSomething(){
        
        String myFirstListItem = 'myFirstListItem';
        String myFirstListItem2 = 'myFirstListItem';
        
        simpleMap = new Map<String,Integer>();
        
        simpleCollection = new List<String>();
        simpleSet = new Set<Integer>();
        simpleCollection.add(myFirstListItem);
        simpleCollection.add(myFirstListItem2);
        
        simpleSet.add(0);
        
        
        for(Integer i=0;i<4;i++){
            String key = myFirstListItem + ' ' + i;
            simpleCollection.add(myFirstListItem + '_' + i);
            simpleSet.add(i);
            simpleMap.put(key, i);
        }
        
        Custom_Event__c ce = new Custom_Event__c();
        
        simpleSet.add(0);
        System.debug('This is my simple set size:' + simpleSet.size());
        System.debug('This is my simple set :' + simpleSet);
        
        System.debug('This is my simple collection size:' + simpleCollection.size());
        System.debug('This is my simple collection :' + simpleCollection);
        
        //foreach list loop
        Integer i = 0;
        for(String item : simpleCollection){
            System.debug('item' + i +' '+ item + '\n');
            i++;
        }
        //iterating map
        for(Integer item : simpleSet){
            System.debug('item' + i +' '+ item + '\n');
            i++;
        }
        
        Set<String> myKeySet = simpleMap.keySet();
        List<Integer> myValues = simpleMap.values();
        
        for(String item : simpleMap.keySet()){
            Integer value = simpleMap.get(item);
            System.debug('item' + value + '\n');
        }
        //iterating map
        for(Integer item : simpleMap.values()){
            System.debug('item'+ item + '\n');
        }
        
    }
    
}