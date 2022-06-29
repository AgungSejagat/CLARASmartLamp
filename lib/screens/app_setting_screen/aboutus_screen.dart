import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TR MADE"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network("https://i.ibb.co/gF76Hcg/logo-computer-engineering.png"),
            SizedBox(height: 33),
            Text("about_us_description", textAlign: TextAlign.justify, style: TextStyle(fontSize: 15, letterSpacing: 1.5 ),).tr(),
          ],
        ),
      ),
    );
  }
}
