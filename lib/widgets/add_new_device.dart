import 'package:firebase/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import '../providers/my_devices.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddNewDevice extends StatefulWidget {
  const AddNewDevice({Key? key}) : super(key: key);

  @override
  State<AddNewDevice> createState() => _AddNewDeviceState();
}

class _AddNewDeviceState extends State<AddNewDevice> {
  final _deviceNameController = TextEditingController();
  final _deviceIDController = TextEditingController();
  final _deviceRoomController = TextEditingController();

  String _scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      _deviceIDController.text = barcodeScanRes;
    });
  }

  Future<bool> _checkRoom(String room) async {
    //logika untuk ngecek room di DB
    final rooms = await DBHelper.getData("room");
    for (var findRoom in rooms) {
      if (findRoom["location"] == room) {
        return true;
      }
    }
    return false;
  }

  void isExist(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("greeting_scan_exist_head").tr(),
          content:
              Text('The device you scanned was saved with the name \'$name\''),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void _saveDevice() async {
      if (_deviceNameController.text.isEmpty ||
          _deviceIDController.text.isEmpty ||
          _deviceRoomController.text.isEmpty) {
        return;
      }

      final selectedDevice = Provider.of<MyDevices>(context, listen: false)
          .findById(_deviceIDController.text);

      await _checkRoom(_deviceRoomController.text).then((value) {
        if (value == false) {
          Provider.of<MyDevices>(context, listen: false)
            .addRoom(_deviceRoomController.text);
        }
      });

      if (selectedDevice.espId == '0') {
        Provider.of<MyDevices>(context, listen: false).addDevice(
          _deviceIDController.text,
          _deviceNameController.text,
          _deviceRoomController.text,
        );

        Navigator.of(context).pop();

        return;
      }

      isExist(selectedDevice.name);
    }

    return Container(
      padding: const EdgeInsets.all(15),
      //color: Colors.indigo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: const Text(
              "greeting_device",
              style: TextStyle(fontSize: 20),
            ).tr(),
          ),
          const SizedBox(
            height: 22,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "greeting_device_name".tr(),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
            controller: _deviceNameController,
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "greeting_scan_id".tr(),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  controller: _deviceIDController,
                ),
              ),
              IconButton(
                onPressed: () => scanBarcodeNormal(),
                icon: const Icon(Icons.camera),
              ),
            ],
          ),
          const SizedBox(height: 22),
          TextField(
            // TODO: change label text
            decoration: InputDecoration(
              labelText:
                  "greeting_add_room".tr(),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            controller: _deviceRoomController,
          ),
          const Spacer(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("greeting_cancel").tr(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _saveDevice,
                child: const Text("greeting_add").tr(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
