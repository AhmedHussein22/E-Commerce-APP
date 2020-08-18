import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/favorites_model.dart';

class Favourites{
final uid;
Favourites({this.uid});
//collection reference
  final CollectionReference favouritescollection =Firestore.instance.collection("Favourites");

  Future addfavourites (String uid ,String name ,  double price, String urlimg,double discount )async{
    return await favouritescollection.document("$uid+$name").setData({
       "uid":uid,
       "name": name,
       "discount": discount,
       "price": price,
       "urlimg": urlimg
    });
  }

 FavoritesModule _favoriteDatafromsnapshot (DocumentSnapshot snapshot)
  {
    return FavoritesModule(
      uid: uid,
      name: snapshot.data["name"],
      discount:snapshot.data["discount"],
      price: snapshot.data["price"],
      urlimg: snapshot.data["urlimg"],

    );
  }
  Stream<FavoritesModule>get userdata{
    return favouritescollection.document().snapshots().map(_favoriteDatafromsnapshot);
  }

  }
