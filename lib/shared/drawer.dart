import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/services/auth_firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
Widget drawer(context) {
  Color blue = Color(0xFF0b0d34);
  Color grey = Color(0xFF404040);
  final Services _auth = Services();
  final user = Provider.of<User>(context);
  List name = user.email.split("@");
  return Container(
    width: MediaQuery.of(context).size.width * 0.6,
    child: Drawer(
      elevation: 10,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFff8200),
            ),
            accountName: Text(name[0].toString().toUpperCase()),
            accountEmail: Text(user.email),
            currentAccountPicture: InkWell(
               child: CircleAvatar(
                child: Text(user.email.substring(0,2).toUpperCase()),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: blue,
            ),
            title: Text(
              "Home Page",
              style: TextStyle(color: grey, fontSize: 22),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/HomePage");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: blue,
            ),
            title: Text(
              "My account",
              style: TextStyle(color: grey, fontSize: 22),
            ),
            onTap: () {
              Navigator.pushNamed(context,"ProfilePage");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: blue,
            ),
            title: Text(
              "My orders",
              style: TextStyle(color: grey, fontSize: 22),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/CartdOrder");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.category,
              color: blue,
            ),
            title: Text(
              "Categoris",
              style: TextStyle(color: grey, fontSize: 22),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/Categoris");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: blue,
            ),
            title: Text(
              "Favourites",
              style: TextStyle(color: grey, fontSize: 22),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/FavouritesOrders");
            },
          ),
          Divider(
            height: 3,
            thickness: 1,
            endIndent: 2,
            indent: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.settings_applications,
              color: blue,
            ),
            title: Text(
              "Settings",
              style: TextStyle(color: grey, fontSize: 22),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/Settings");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: blue,
            ),
            title: Text(
              "About",
              style: TextStyle(color: grey, fontSize: 22),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/about");
            },
          ),
          ButtonTheme(
            minWidth:MediaQuery.of(context).size.width*0.3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: RaisedButton(
              onPressed: () {
                _auth.signOut();
              },
              elevation: 10,
              child: Text(
                "Sing out",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 20),
              ),
              color: Theme.of(context).buttonColor,
            ),
          )
        ],
      ),
    ),
  );
}
