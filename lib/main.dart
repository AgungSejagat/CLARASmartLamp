import 'package:easy_localization/easy_localization.dart';
import 'package:firebase/screens/home_screen/device_screen.dart';
import 'package:firebase/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


import '/screens/app_setting_screen/appsetting_screen.dart';
import '/screens/app_setting_screen/language_screen.dart';
import '/screens/app_setting_screen/theme_screen.dart';
import '/screens/app_setting_screen/aboutus_screen.dart';
import '/screens/device_setting_screen/devicesetting_screen.dart';
import '../providers/my_devices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('es'), Locale('id')],
      path: 'assets',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return ChangeNotifierProvider.value(
            value: MyDevices(),
            child: MaterialApp(
              home: HomeScreen(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.indigo),
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
              initialRoute: 'home_screen',
              routes: {
                'home_screen': (context) => HomeScreen(),
                'appsetting_screen': (context) => SettingScreen(),
                'devicesetting_screen': (context) => DeviceSettingsScreen(),
                'language_screen': (context) => LanguageScreen(),
                'theme_screen': (context) => ThemeScreen(),
                'aboutus_screen': (context) => AboutUsScreen(),
                'devicelist_screen': (context) => DeviceScreen()
                ,
              },
            ),
          );
        });
  }
}
