import 'package:firebase/providers/my_devices.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TR MADE'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setLanguage(context, 'en');
              },
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/US_flag_51_stars.svg/2560px-US_flag_51_stars.svg.png'),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "language_en".tr(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setLanguage(context, 'es');
              },
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWo89QMZN3cTQTNcv1i0xYpQzVMWE-7XoOHg&usqp=CAU'),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "language_es".tr(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setLanguage(context, 'id');
              },
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Indonesia.svg/2560px-Flag_of_Indonesia.svg.png'),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "language_id".tr(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setLanguage(BuildContext context, String languageCode) {
    Provider.of<MyDevices>(context, listen: false)
        .changeLanguage(context, languageCode);
  }
}
