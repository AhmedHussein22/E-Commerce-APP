import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/cart_model.dart';

class CartDB{
final uid;
CartDB({this.uid});
//collection reference
  final CollectionReference cartcollection =Firestore.instance.collection("Cart");

  Future addCart (String uid ,String name ,  double price, String urlimg,int selectedquantity,)async{
    return await cartcollection.document("$uid+$name").setData({
       "uid":uid,
       "name": name,
       "price": price,
       "urlimg": urlimg,
       "selectedquantity": selectedquantity,
      
    });
  }

 CartsModule _cartDatafromsnapshot (DocumentSnapshot snapshot)
  {
    return CartsModule(
      uid: uid,
      name: snapshot.data["name"],
      price: snapshot.data["price"],
      urlimg: snapshot.data["urlimg"],
      selectedquantity: snapshot.data["selectedquantity"],
    );
  }
  Stream<CartsModule>get cartdata{
    return cartcollection.document().snapshots().map(_cartDatafromsnapshot);
  }

  }
