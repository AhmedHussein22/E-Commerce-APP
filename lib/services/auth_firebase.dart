import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/services/user_db.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Services {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  User _userFromFirebase (FirebaseUser user)
  {
    return user != null ? User(uid: user.uid,email:user.email) : null;
  }

  Stream <User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }
   //Login with mail and password
  Future loginINWithMailAndPass(String mail, String pass)async
  {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: mail.trim(), password: pass.trim());
      FirebaseUser user= result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }

  }

  //Singup with mail and password
  Future singUPWithMailAndPass(String mail, String pass)async
  {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: mail.trim(), password: pass.trim());
      FirebaseUser user= result.user;
      await DataBaseServices(uid: user.uid,).updateUserData(
      "user",
      "0",
      "company",
      "01x xxxx xxxx",
      "address",
      );
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }

  }

  

  //sign out
  Future signOut()async
   {
    try 
    {
     return _auth.signOut();
      
    }
     catch (e) 
    {
      print(e.toString());
      return null;
    }
  }
}