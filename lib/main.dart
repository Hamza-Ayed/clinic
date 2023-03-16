import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:doctors/Login/homepage.dart';
import 'package:doctors/db/sqlff.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'Login/method/provider_user.dart';
import 'Login/new_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBSqlFF('Users').db;
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  // await DBSqlFF('Drugs').getData('Drugs').then((value) {
  //   if (value.isEmpty) {
  //     Methods().getDrugsToSQL();
  //   } else {
  //     return print('Drugs not null');
  //   }
  // });
  // await DBSql('ChecksHealth').getData('ChecksHealth').then((value1) {
  //   if (value1.isEmpty) {
  //     Methods().getHelthCheckstoSQL();
  //   } else {
  //     return print('ChecksHealth not null');
  //   }
  // });
  await Hive.initFlutter();
  await Hive.openBox('userBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? deviceinfoq = '';
  List listDevices = [
    '80C6C691-6412-459D-99B8-BA7324215A03',
    'EA750981-3F5A-4202-A231-E99D6BE4EC6D',
    'CA456A4D-7123-43CC-ACA3-21C41B2A3581',
    'f2a60e3ce0fba613',
    'c0059fe472d5bfa0'
  ];
  final storage = const FlutterSecureStorage();
  bool isAdmin = false;
  var db = openDatabase(inMemoryDatabasePath);
  deviceinfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceinfoq = androidInfo.androidId.toString();
      await storage.write(key: 'deviceinfoq', value: deviceinfoq);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceinfoq = iosInfo.identifierForVendor.toString();
      await storage.write(key: 'deviceinfoq', value: deviceinfoq);
    } else if (Platform.isWindows) {
      WindowsDeviceInfo wininfo = await deviceInfo.windowsInfo;
      deviceinfoq = wininfo.computerName.toString();
      await storage.write(key: 'deviceinfoq', value: deviceinfoq);
    } else if (Platform.isMacOS) {
      MacOsDeviceInfo macrInfo = await deviceInfo.macOsInfo;
      deviceinfoq = macrInfo.model.toString();
      await storage.write(key: 'deviceinfoq', value: deviceinfoq);
    } else if (Platform.isFuchsia) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceinfoq = webBrowserInfo.appCodeName.toString();
      await storage.write(key: 'deviceinfoq', value: deviceinfoq);
    }
    if (listDevices.contains(deviceinfoq)) {
      setState(() {
        isAdmin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    deviceinfo();
    db;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
            title: 'Face Doctors',
            theme: ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: FutureBuilder<String?>(
              future: storage.read(key: 'username'),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Homepage();
                } else {
                  return const LoginPage();
                }
              },
            )));
  }
}
