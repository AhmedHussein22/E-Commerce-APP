import 'package:e_commerce/screens/payment/buy_now.dart';
import 'package:e_commerce/services/api_products.dart';
import 'package:e_commerce/shared/inputdecoration.dart';
import 'package:flutter/material.dart';
class SettingForm extends StatefulWidget {
  final List <dynamic>productDetails;
  final double totalprice;
  SettingForm({this.productDetails, this.totalprice});
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _key = GlobalKey<FormState>();

  String location;
  String phone;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Form(
      key: _key,
      child: Column(
        children: [
          Text(
            "Confirm order",
            style: theme.textTheme.headline6,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.streetAddress,
            decoration: inputdecoration.copyWith(
              icon: Icon(
                Icons.not_listed_location,
                color: Colors.orange,
              ),
              labelText: "add location",
            ),
            validator: (value) =>
                value.isEmpty ? "Pleas Enter Your location" : null,
            onChanged: (value) {
              setState(() => location = value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: inputdecoration.copyWith(
              icon: Icon(
                Icons.contact_phone,
                color: Colors.orange,
              ),
              labelText: "Phone Number",
            ),
            validator: (value) =>
                value.isEmpty ? "Pleas Enter Your Phone Number" : null,
            onChanged: (value) {
              setState(() => phone = value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ButtonTheme(
            buttonColor: Color(0xFFff8200),
            minWidth: MediaQuery.of(context).size.width * 0.65,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Builder(
                builder: (context) => RaisedButton(
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    try
                    {
                      Api _store = Api("order");
                      _store.storeOrders({"phone": phone, "address": location},
                          widget.productDetails);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => BuyNowPayment(
                                    price: widget.totalprice.toString(),
                                  ),
                              ),
                           );
                    }
                     catch (ex) {
                      print(ex.toString());
                    }
                  }
                },
                child: Text("Buy Now",
                style: theme.textTheme.subtitle1.copyWith(fontSize: 25),
                ),
                elevation: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}