public class ApiCallQuable implements Queueable, Database.AllowsCallouts {
    public void execute(QueueableContext context) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://660b5654ccda4cbc75dcadd4.mockapi.io/e-travel');
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);

        List<productDetails> products = (List<productDetails>) JSON.deserialize(res.getBody(), List<productDetails>.class);

        List<Product2> productsToInsert = new List<Product2>();

        for(productDetails product : products){
            Product2 prod = new Product2();
            prod.Name = product.text;
            
            productsToInsert.add(prod);
        }
        
        try{
            insert productsToInsert;
        } catch(Exception e){
            system.debug('Failed to insert records.');
        }
    }

    public class productDetails {
        public string text {get;set;}
        public string Id {get;set;}
    }
}