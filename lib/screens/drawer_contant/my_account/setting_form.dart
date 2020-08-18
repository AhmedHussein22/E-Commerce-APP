import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/models/user_info.dart';
import 'package:e_commerce/services/user_db.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _key = GlobalKey<FormState>();

  var crruntName;
  var crruntAge;
  var crruntAddress;
  var crruntCompany;
  var crruntPhone;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
          child: StreamBuilder<UserInfo>(
          stream: DataBaseServices(uid: user.uid).userInfo,
          builder: (context, snapshot) {
      UserInfo userData = snapshot.data;
      if (snapshot.hasData) {
        return Form(
          key: _key,
          child: Column(
            children: [
              Text(
                "Update Profile",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: height * 0.01,
              ),

              //*******************UPdate name***********//
              TextFormField(
                initialValue: userData.name,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_pin,
                      color: Colors.orange,
                    ),
                    labelText: "UPdate name"),
                validator: (value) =>
                    value.isEmpty ? "Pleas Enter Your New Name" : null,
                onChanged: (value) {
                  setState(() => crruntName = value);
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),

              //*******************UPdate Address***********//
              TextFormField(
                initialValue: userData.address,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.orange,
                    ),
                    labelText: "UPdate Address"),
                validator: (value) =>
                    value.isEmpty ? "Pleas Enter Your New Address" : null,
                onChanged: (value) {
                  setState(() => crruntAddress = value);
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              //*******************UPdate Phone***********//
              TextFormField(
                initialValue: userData.phone,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.orange,
                    ),
                    labelText: "UPdate Phone"),
                validator: (value) =>
                    value.isEmpty ? "Pleas Enter Your New Phone" : null,
                onChanged: (value) {
                  setState(() => crruntPhone = value);
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              //*******************UPdate company***********//
              TextFormField(
                initialValue: userData.company,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.orange,
                    ),
                    labelText: "UPdate Company"),
                validator: (value) =>
                    value.isEmpty ? "Pleas Enter Your New Company" : null,
                onChanged: (value) {
                  setState(() => crruntCompany = value);
                },
                //*******************UPdate Age***********//
              ),
              SizedBox(
                height: height * 0.01,
              ),
              TextFormField(
                initialValue: userData.age,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.assignment,
                      color: Colors.orange,
                    ),
                    labelText: "UPdate Age"),
                validator: (value) =>
                    value.isEmpty ? "Pleas Enter Your New Age" : null,
                onChanged: (value) {
                  setState(() => crruntAge = value);
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: RaisedButton(
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      await DataBaseServices(uid: user.uid).updateUserData(
                          crruntName ?? userData.name,
                          crruntAge ?? userData.age,
                          crruntCompany ?? userData.company,
                          crruntPhone ?? userData.phone,
                          crruntAddress ?? userData.address);
                      Navigator.pop(context);
                    }
                  },
                  elevation: 10,
                  child: Text(
                    "Update Profile",
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
        );
      } else {
        return Loading();
      }
          },
        ),
    );
  }
}
