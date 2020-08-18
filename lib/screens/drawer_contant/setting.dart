import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/screens/drawer_contant/my_account/setting_form.dart';
import 'package:e_commerce/services/auth_firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Settings extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
     final user = Provider.of<User>(context);
     ThemeData theme = Theme.of(context);
      final Services _auth = Services();
     setting()
    {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          child: SettingForm(),
        );

      }
      );
    }
    return Scaffold(
      appBar: AppBar(
        title:Text("Setting")
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Card(
              color: theme.accentColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage("assets/img/singup&login/account.png"),
                          ),
                        ),
                        Text("${user.email}",
                        style: theme.textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child:FlatButton(
                        onPressed: (){
                           Navigator.pushNamed(context,"ProfilePage");
                        },
                        child: Text('Show Profile',
                        style: theme.textTheme.subtitle1,
                        ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "General Settings".toUpperCase(),
              style: theme.textTheme.headline3
            ),
            Card(
              color: theme.accentColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.email,
                      color: theme.buttonColor,
                    ),
                    title: Text("Edit Profile"),
                    trailing: Icon(Icons.keyboard_arrow_right,color: theme.buttonColor,),
                    onTap: ()=> setting(),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: theme.buttonColor,
                    ),
                    title: Text("Change Language"),
                    trailing: Icon(Icons.keyboard_arrow_right,color: theme.buttonColor,),
                    onTap: (){},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
             Card(
               color: theme.accentColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: SwitchListTile(
                    activeColor: theme.buttonColor,
                    value: true,
                    title: Text("Dark Theme"),
                    onChanged: (val) {},
                  ),
            ),
             const SizedBox(height: 20.0),
            Text(
              "Notification Settings".toUpperCase(),
               style: theme.textTheme.headline3,
            ),
            Card(
              color: theme.accentColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  SwitchListTile(
                    activeColor: theme.buttonColor,
                    value: true,
                    title: Text("New Category"),
                    onChanged: (val) {},
                  ),
                   Divider(),
                  SwitchListTile(
                    activeColor: theme.buttonColor,
                    value: true,
                    title: Text("Offers"),
                    onChanged: (val) {},
                  ),
                ],
              ),
            ),
            Card(
              color: theme.accentColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: ListTile(
                leading: Icon(Icons.exit_to_app,color: theme.buttonColor,),
                title: Text("Logout"),
                onTap: () {
                   _auth.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}