import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/models/user_stream.dart';
import 'package:e_commerce/screens/drawer_contant/my_account/setting_form.dart';
import 'package:e_commerce/services/user_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final mail;
  ProfilePage({this.mail});
  

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height * 0.03;
    final user = Provider.of<User>(context);
    setting() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: SettingForm(),
            );
          });
    }

    return StreamBuilder<UserStream>(
        stream: DataBaseServices(uid: user.uid).user,
        builder: (context, snapshot) {
          UserStream userData = snapshot.data;
          return Scaffold(
              body: Column(
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
                        "${userData.name}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size / 2,
                      ),
                      Text(
                        " ${userData.phone} ",
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
                                Text("${userData.address} "),
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
                            child: Text(" ${userData.company}"),
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
                                Text("${userData.age}"),
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
                height: size * 8,
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
          ));
        });
  }
}
