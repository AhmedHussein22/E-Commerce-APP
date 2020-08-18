class Product {
  String id;
  double price;
  String name;
  String urlimg;
  String description;
  String category;
  double discount;
  int quantity;
  String size;
  String color;
  int selectedquantity;
  String location;
  bool isfavourites;

Product({this.location, this.selectedquantity, this.id, this.price, this.name,this.urlimg, this.description, this.category, this.discount, this.quantity,this.size, this.color,this.isfavourites});

  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ??0.0,
        name = snapshot['name'] ?? '',
        urlimg = snapshot['urlimg'] ?? '',
        category= snapshot['category'] ?? '',
        description = snapshot['description'] ?? '',
        discount = snapshot['discount'] ??0.0,
        quantity = snapshot['quantity'] ?? 0,
        size = snapshot['size'] ?? '',
        color = snapshot['color'] ?? '',
        isfavourites= snapshot['isfavourites'];
toJson() {
    return {
      "price": price,
      "name": name,
       "urlimg": urlimg,
       "category": category,
       "quantity": quantity,
       "description": description,
       "discount": discount,
        "size": size,
        "color": color,
        "isfavourites": isfavourites,
    };
  }
}