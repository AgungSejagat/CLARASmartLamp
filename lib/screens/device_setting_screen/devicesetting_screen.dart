import 'package:firebase/providers/my_devices.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  int toRed() => red;
  int toGreen() => green;
  int toBlue() => blue;
}

class DeviceSettingsScreen extends StatefulWidget {
  @override
  State<DeviceSettingsScreen> createState() => _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends State<DeviceSettingsScreen> {
  bool power = true;
  bool rainbow = true;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void pickColor(BuildContext context, String docId) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("device_setting_changecolor_head").tr(),
          content: SingleChildScrollView(
            child: SlidePicker(
              pickerColor: pickerColor,
              enableAlpha: false,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("device_setting_changecolor_confirm").tr(),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                FirebaseFirestore.instance
                    .collection('Neopixel')
                    .doc(docId)
                    .update({
                  'Red': currentColor.toRed(),
                  'Green': currentColor.toGreen(),
                  'Blue': currentColor.toBlue()
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedDevice =
        Provider.of<MyDevices>(context, listen: false).findById(id.toString());

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("TR MADE"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  power = !power;
                });

                FirebaseFirestore.instance
                    .collection('Neopixel')
                    .doc(selectedDevice.espId)
                    .update({'Power': power});
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                fixedSize: Size(80, 80),
                elevation: 10,
                primary: power ? Colors.green : Colors.red,
              ),
              child: Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.square,
                color: currentColor,
                size: 55,
              ),
              ElevatedButton(
                onPressed: () => pickColor(context, selectedDevice.espId),
                child: const Text(
                  "device_setting_changecolor",
                  style: TextStyle(fontSize: 24),
                ).tr(),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 45),
                  elevation: 10,
                  primary: Colors.indigo,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, //align center
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlutterSwitch(
                  value: rainbow,
                  onToggle: (val) {
                    setState(() {
                      rainbow = val;
                    });
                    FirebaseFirestore.instance
                        .collection('Neopixel')
                        .doc(selectedDevice.espId)
                        .update({'Rainbow': rainbow});
                  },
                ),
                const Text('  Rainbow', style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
