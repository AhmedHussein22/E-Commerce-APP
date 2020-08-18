class FavoritesModule {
  String id;
  String uid;
  double price;
  String name;
  String urlimg;
  double discount;

FavoritesModule({this.uid, this.price, this.name,this.urlimg,this.discount,});
FavoritesModule.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        urlimg = snapshot['urlimg'] ?? '',
        discount = snapshot['discount'] ?? '';
toJson() {
    return {
      "price": price,
      "name": name,
       "urlimg": urlimg,
       "discount": discount,
    };
  }
}