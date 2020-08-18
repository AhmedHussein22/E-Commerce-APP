import 'package:e_commerce/services/auth_firebase.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function viewstate;
  LoginScreen({this.viewstate});
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String error = "";
  String pass = "";
  String mail = "";
  bool isHided = true;
  bool isLoasing = false;
  final _formKey = GlobalKey<FormState>();
  final Services _auth = Services();
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoasing
        ? Loading()
        : Scaffold(
            body: Container(
              child: ListView(children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: size.width,
                      height: size.height * 0.40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Image.asset("assets/img/singup&login/login.png",
                          height: size.height * 0.35, width: size.width),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Card(
                             color: Theme.of(context).primaryColor,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline2,
                              validator: (value) => value.isEmpty
                                  ? "Pleas Enter Your Mail"
                                  : null,
                              onChanged: (value) {
                                setState(() => mail = value);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person,
                                      color: Color(0xFFff8200)),
                                  hintText: "E-Mail",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16)),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),

                          //**********password**********/

                          Card(
                             color: Theme.of(context).primaryColor,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            child: TextFormField(
                              obscureText: isHided,
                              style: Theme.of(context).textTheme.headline2,
                              validator: (value) => value.length < 6
                                  ? "Pleas Enter crorrcted password"
                                  : null,
                              onChanged: (value) {
                                setState(() => pass = value);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock,
                                      color: Color(0xFFff8200)),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye,
                                          color: Color(0xFFff8200)),
                                      onPressed: () {
                                        setState(() {
                                          isHided = !isHided;
                                        });
                                      }),
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    ButtonTheme(
                      buttonColor: Theme.of(context).buttonColor,
                      minWidth: size.width * 0.8,
                      height: size.height * 0.06,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => isLoasing = true);
                            dynamic result =
                                await _auth.loginINWithMailAndPass(mail, pass);
                            if (result == null) {
                               setState(
                                  () {
                                    error="please enter vaild mail or password";
                                    isLoasing = false;
                                   
                                  },
                                );
                             
                            }
                          }
                        },
                        elevation: 7,
                        child: Text(
                          "SINGIN",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                     SizedBox(height: size.height * 0.01),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don’t have an Account ? ",
                        ),
                        GestureDetector(
                          onTap: ()=>widget.viewstate(),
                          child: Text(
                            "SINGUP",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                     Text(error,style:Theme.of(context).textTheme.headline3.copyWith(color: Colors.red)),

                    
                   
                  ],
                ),
              ]),
            ),
          );
  }
}
