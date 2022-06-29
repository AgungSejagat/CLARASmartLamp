import 'package:firebase/providers/my_devices.dart';
import 'package:firebase/widgets/add_new_device.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  Widget build(BuildContext context) {
    void popUp(String espId, String location) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("delete_device_head").tr(),
          content: const Text("delete_device_main").tr(),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, "delete_device_cancel".tr()),
              child: const Text("delete_device_cancel").tr(),
            ),
            TextButton(
              onPressed: () {
                Provider.of<MyDevices>(context, listen: false)
                    .deleteDevice('user_devices', espId, location);
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((ModalRoute.of(context)!.settings.arguments! as Map)["location"]),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'appsetting_screen');
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<MyDevices>(
          context,
          listen: false,
        ).fetchAndSetDevices(
            (ModalRoute.of(context)!.settings.arguments! as Map)["location"]),
        builder: (ctx, snapshot) {
          print(snapshot.data);
          return snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<MyDevices>(
                //contoh panggil fungsi provider menggunakan consumer
                child: Center(
                  child:
                      const Text("front_message", textAlign: TextAlign.center)
                          .tr(),
                ),
                builder: (ctx, myDevices, ch) => myDevices.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: myDevices.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: const Icon(
                            Icons.lightbulb_outline,
                            size: 30,
                          ),
                          title: Text(
                            myDevices.items[i].name,
                            style: TextStyle(fontSize: 27),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              size: 30,
                            ),
                            onPressed: () => popUp(myDevices.items[i].espId, (ModalRoute.of(context)!.settings.arguments! as Map)["location"]),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                'devicesetting_screen',
                                arguments: myDevices.items[i].espId,);
                          },
                        ),
                      ),
              );
        },
      ),
    );
  }
}
