//Untuk mengatur state secara individu, seperti tambah dan hapus device tanpa refresh satu poge

import 'package:firebase/models/room.dart';

import '../helpers/db_helper.dart';
import '../models/device.dart';
import '../models/room.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyDevices with ChangeNotifier {
  List<Device> _items = [];
  List<Room> _rooms = [];

  List<Device> get items {
    return _items;
  }

  List<Room> get rooms {
    return _rooms;
  }

  Device findById(String id) {
    final nullDevice = Device(espId: '0', name: '0', location: '0');

    return _items.firstWhere(
      (Device) => Device.espId == id,
      orElse: (() => nullDevice),
    );
  }

  Future<void> addDevice(
    String pickedEspId,
    String pickedName,
    String pickedRoom,
  ) async {
    final newDevice = Device(
      espId: pickedEspId,
      name: pickedName,
      location: pickedRoom,
    );

    _items.add(newDevice);
    notifyListeners();

    DBHelper.insert('user_devices', {
      "espId": newDevice.espId,
      "name": newDevice.name,
      "location": newDevice.location
    });
  }

  Future<void> fetchAndSetDevices([String room = ""]) async { //Untuk mengambil data device
    final dataList = await DBHelper.getData('user_devices');
    if (room == "") {
      _items = dataList
          .map(
            (e) => Device(
              espId: e["espId"],
              name: e["name"],
              location: e["location"],
            ),
          )
          .toList();
    } else {
      final List<Device> devices = [];

      dataList.forEach((element) {
        if (element["location"] == room) {
          devices.add(Device.fromJson(element));
        }
      });
      _items = devices;
    }

    notifyListeners();
  }
  
  Future<void> deleteDevice(String table, String selectedId, [String room = ""]) async {
    await DBHelper.delete(table, selectedId);
    fetchAndSetDevices(room);
  }
  
  Future<void> deleteRoom(String table, String room) async {
    await DBHelper.deleteByRoom(table, room);
    fetchAndSetRooms();
  }

  Future<void> addRoom(
    //Untuk nambahin room
    String pickedRoom,
  ) async {
    final room = Room(
      id: DateTime.now().toString(),
      location: pickedRoom,
    );

    _rooms.add(room); //Menambahkah data kepada variabel room
    notifyListeners();

    DBHelper.insert('room', {
      "id": room.id,
      "location": room.location,
    });
  }

  Future<void> fetchAndSetRooms() async {
    final dataList = await DBHelper.getData('room');

    _rooms = dataList
        .map((item) => Room(id: item["id"], location: item["location"]))
        .toList();

    notifyListeners();
  }

  Future<void> changeLanguage(BuildContext context, String languageCode) async {
    context.setLocale(Locale(languageCode));
    notifyListeners();
  }
}
