public class StringArrayTest {
    public static List<String> generateStringArray(Integer a) {
        List<String> strings = new List<String>();
        
        for(Integer i=0;i<a;i++){
            strings.add('Test '+i);
        }
        
        return strings;
    }
}