import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/user_info.dart';
import 'package:e_commerce/models/user_stream.dart';

class DataBaseServices{
  final uid ;
  DataBaseServices({this.uid});

  //collection reference
  final CollectionReference usercollection =Firestore.instance.collection("UserProfile");

  Future updateUserData (String name  , String age, String company, String phone, String address)async{

    return await usercollection.document(uid).setData({
       
       "name": name,
       "age": age,
       "company": company,
       "phone": phone,
       "address": address,
    });

  }

  //user list from snapshot
   UserStream _userfeomsnapshot (DocumentSnapshot snapshot)
  {
    return UserStream(
        address: snapshot.data["address"]??"",
        name: snapshot.data["name"]??"",
        age: snapshot.data["age"]??"",
        company: snapshot.data["company"]??"",
        phone: snapshot.data["phone"]??"",
        );
    }
    
  // user data from snapshot
  UserInfo _userDatafromsnapshot (DocumentSnapshot snapshot)
  {
    return UserInfo(
      uid: uid,
      name: snapshot.data["name"]??"",
      age: snapshot.data["age"]??"",
      address: snapshot.data["address"]??"",
      company: snapshot.data["company"]??"",
      phone: snapshot.data["phone"]??"",

    );
  }

  Stream<UserStream> get user{
    return usercollection.document(uid).snapshots().map(_userfeomsnapshot);

  }
  //get user doc stream
  Stream<UserInfo>get userInfo{
    return usercollection.document(uid).snapshots().map(_userDatafromsnapshot);
  }

}