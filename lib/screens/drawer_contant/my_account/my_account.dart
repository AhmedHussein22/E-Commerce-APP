import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/models/user_info.dart';
import 'package:e_commerce/screens/drawer_contant/my_account/setting_form.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final mail;
  ProfilePage({this.mail});
  

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   List<UserInfo> userData;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height * 0.03;
     final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final user = Provider.of<User>(context);
    
    setting() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: SettingForm(
                userData: userData,
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
     
          body: LayoutBuilder(builder: (context, constrains) {
                          return Container(
                            height: screenHeight -
                  statusBarHeight -
                  appBarHeight -
                  (screenHeight * .08),
                            child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                        .collection('UserProfile')
                        .where("uid", isEqualTo: user.uid)
                        .snapshots(),
             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
               if (snapshot.hasData){
                  userData = snapshot.data.documents.map((doc) =>
                                  UserInfo.fromMap(doc.data, doc.documentID))
                              .toList();
              return ListView.builder(
                scrollDirection: Axis.vertical,
                                itemCount: userData.length,
                             itemBuilder: (buildContext, index) {
                                  return (
                     Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/img/singup&login/account.png"),
                                  radius: 60.0,
                                ),
                              ),
                              SizedBox(
                                height: size,
                              ),
                              Text(
                                "${userData[index].name}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: size / 2,
                              ),
                              Text(
                                " ${userData[index].phone} ",
                              ),
                              SizedBox(
                                height: size / 2,
                              ),
                              Text(
                                "${user.email}",
                              ),
                              SizedBox(
                                height: size / 2,
                              ),
                              Divider(),
                              SizedBox(
                                height: size,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Address:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                                    child: Column(
                                      children: <Widget>[
                                        Text("${userData[index].address} "),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size / 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Country:",
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                                    child: Text(" ${userData[index].company}"),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Age:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                                    child: Column(
                                      children: <Widget>[
                                        Text("${userData[index].age}"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size / 2,
                              ),
                            ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height:  8,
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: RaisedButton(
                        onPressed: () => setting(),
                        elevation: 10,
                        child: Text(
                            "Edit Profile",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontSize: 20),
                        ),
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ],
                )
                );
                             });
            }
            else {
                    return Loading();

               }
             }
              ),
                                      );
          
          }
          ),
    );
  }
}
