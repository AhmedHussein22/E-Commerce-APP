
class UserInfo{
  final String uid;
  final String name;
  final String age;
  final String address;
  final String phone;
  final String company;
  UserInfo({this.age,this.name,this.address,this.uid,this.company,this.phone});
  UserInfo.fromMap(Map snapshot,String id) :
        uid = id ?? '',
        name = snapshot['name'] ?? '',
        age = snapshot['age'] ?? '',
        address = snapshot['address'] ??"",
        phone = snapshot['phone'] ??"",
        company = snapshot['company'] ??"";
toJson() {
    return {
      "uid":uid,
      "age":age,
      "name": name,
       "address":address,
       "phone":phone,
       "company":company
    };
  }
}