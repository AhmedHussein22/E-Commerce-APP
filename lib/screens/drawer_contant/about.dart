import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  static const routeName = '/About1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildInfo1(context),
            _buildInfo2(context),
            _buildInfo3(context)
          ],
        ),
      ),
    );
  }

  Widget _buildInfo1(context) {
    ThemeData theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              color: theme.accentColor,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        foregroundColor: theme.buttonColor,
                        child: Image.asset(
                          'assets/img/logo/logo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'E Shoppers',
                            style: theme.textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.info, color: theme.buttonColor),
                    title: Text("Version"),
                    subtitle: Text("1.0", style: theme.textTheme.subtitle1),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.offline_pin, color: theme.buttonColor),
                    title: Text("License"),
                    subtitle: Text("Free", style: theme.textTheme.subtitle1.copyWith(color:theme.buttonColor )),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.share, color: theme.buttonColor),
                    title: Text("Share APP"),
                    onTap: () {
                      Share.share("https://github.com/AhmedHussein22");
                    },
                  ),
                ],
              )),
        ));
  }

  Widget _buildInfo2(context) {
    ThemeData theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              color: theme.accentColor,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Author',
                      style: theme.textTheme.headline3
                          .copyWith(color: Colors.white)),
                  ListTile(
                    leading: Icon(Icons.person, color: theme.buttonColor),
                    title: Text("Ahmed Hussein"),
                    subtitle: Text("Egypt", style: theme.textTheme.subtitle1.copyWith(color:theme.buttonColor )),
                  ),
                  Divider(),
                  ListTile(
                    leading:
                        Icon(Icons.file_download, color: theme.buttonColor),
                    title: Text("Download From github"),
                    onTap: () async {
                      final url = 'https://github.com/AhmedHussein22';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ],
              ),),
        ),);
  }

  Widget _buildInfo3(context) {
    ThemeData theme = Theme.of(context);
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              color: theme.accentColor,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Company',
                      style: theme.textTheme.headline3
                          .copyWith(color: Colors.white)),
                  ListTile(
                    leading: Icon(Icons.location_city, color: theme.buttonColor),
                    title: Text("Micro"),
                    subtitle: Text("Mobile App Specialist",style: theme.textTheme.subtitle1.copyWith(color:theme.buttonColor )),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on, color: theme.buttonColor),
                    title: Text("Egypt,Fayoum"),
                  ),
                ],
              )),
        ));
  }
}
