import 'package:e_commerce/screens/payment/existing_cards.dart';
import 'package:e_commerce/services/payment.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class BuyNowPayment extends StatefulWidget {
  final price;
  BuyNowPayment({this.price});
  @override
  _BuyNowPaymentState createState() => _BuyNowPaymentState();
}

class _BuyNowPaymentState extends State<BuyNowPayment> {
  onItemPress(BuildContext context, int index) async {
    
    switch(index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>ExistingCardsPage(price: widget.price.toString(),)));
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
      elevation: 5,
      borderRadius: 10,
      message: 'Please wait...'

    );
    await dialog.show();
    var response = await StripeService.payWithNewCard(
      amount: widget.price,
      currency: 'LE'
    );
    await dialog.hide();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 5,
        content: Text(response.message),
        duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          
          itemBuilder: (context, index) {
            Icon icon;
            Text text;

            switch(index) {
              case 0:
                icon = Icon(Icons.add_circle, color: theme.buttonColor);
                text = Text('Pay via new card',style: theme.textTheme.headline2,);
                break;
              case 1:
                icon = Icon(Icons.credit_card, color: theme.buttonColor);
                text = Text('Pay via existing card',style: theme.textTheme.headline2,);
                break;
            }

            return InkWell(
              radius: 20,
              onTap: () {
                onItemPress(context, index);
              },
              child: ListTile(
               
                title: text,
                leading: icon,
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: 2
        ),
      ),
    );
  }
}