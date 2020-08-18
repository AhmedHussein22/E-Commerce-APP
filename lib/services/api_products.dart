import 'package:cloud_firestore/cloud_firestore.dart';
class Api{
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Api( this.path ) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments() ;
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map data , String id) {
    return ref.document(id).updateData(data) ;
  }
   storeOrders(data, List<dynamic> productDetails) {
    var documentRef = ref.document();
    documentRef.setData(data);
    for (var product in productDetails) {
      documentRef.collection("OrderDetails").document().setData({
        "ProductName": product.name,
        "ProductPrice": product.price,
        "ProductQuantity": product.selectedquantity,
      });
    }
  }

}