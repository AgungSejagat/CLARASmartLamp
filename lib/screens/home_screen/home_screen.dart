import 'package:firebase/providers/my_devices.dart';
import 'package:firebase/widgets/add_new_device.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

//import '/app_setting/appsetting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void popUp(String location) {
      showDialog<String>(
        context: context, // TODO: ganti kata - katanya
        builder: (BuildContext context) => AlertDialog(
          title: const Text("delete_device_head").tr(),
          content: const Text("delete_room_main").tr(),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, "delete_device_cancel".tr()),
              child: const Text("delete_device_cancel").tr(),
            ),
            TextButton(
              onPressed: () async{
                  await Provider.of<MyDevices>(context, listen:false).deleteRoom("room", location);
                  await Provider.of<MyDevices>(context, listen:false).deleteRoom("user_devices", location);
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
        title: const Text("TR MADE"),
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
        future:
            Provider.of<MyDevices>(context, listen: false).fetchAndSetRooms(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
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
                builder: (ctx, myDevices, ch) => myDevices.rooms.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: myDevices.rooms.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: const Icon(
                            Icons.room_outlined,
                            size: 30,
                          ),
                          title: Text(
                            myDevices.rooms[i].location,
                            style: const TextStyle(fontSize: 27),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              size: 30,
                            ),
                            onPressed: () async {
                              popUp(myDevices.rooms[i].location);
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              'devicelist_screen',
                              arguments: {
                                "location": myDevices.rooms[i].location
                              },
                            );
                          },
                        ),
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddNewDevice();
            },
          );
        },
        elevation: 12,
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
