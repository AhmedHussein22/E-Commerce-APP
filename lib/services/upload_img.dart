import 'package:firebase_storage/firebase_storage.dart';


  Future<String> uploadImage(_image) async {
    try {
      FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://e-commerce-a2338.appspot.com/products_mg');
      StorageReference ref = storage.ref().child("${DateTime.now()}");
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      print(url);
     return url;
    } catch (ex) {
      
      print(ex);
      return null;
    }
  }
