class CartsModule {
  String id;
  String uid;
  double price;
  String name;
  String urlimg;
  int selectedquantity;
 

CartsModule({this.uid, this.price, this.name,this.urlimg,this.selectedquantity});
CartsModule.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? 0.0,
        name = snapshot['name'] ?? '',
        urlimg = snapshot['urlimg'] ?? '',
        selectedquantity = snapshot['selectedquantity'] ?? 0;
    
toJson() {
    return {
      "price": price,
      "name": name,
       "urlimg": urlimg,
       "selectedquantity": selectedquantity,
    };
  }
}