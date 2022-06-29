import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TR MADE"),
        backgroundColor: Colors.indigo,
      ),
      body: Consumer(
        builder: (context, value, child) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'language_screen');
                    },
                    icon: Icon(
                      Icons.language,
                    ),
                    label: Text(
                      "language_button".tr(),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      elevation: 10,
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'theme_screen');
                    },
                    icon: Icon(
                      Icons.palette,
                    ),
                    label: Text(
                      "theme_button".tr(),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      elevation: 10,
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'aboutus_screen');
                    },
                    icon: Icon(
                      Icons.people_alt_rounded,
                    ),
                    label: Text(
                      "about_us_button".tr(),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      elevation: 10,
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
