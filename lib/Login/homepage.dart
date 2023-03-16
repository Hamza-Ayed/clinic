import 'dart:ui';

import 'package:doctors/Login/new_login.dart';
import 'package:doctors/Login/widget/widget.dart';
import 'package:doctors/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../pages/appointment.dart';
import '../pages/client/clint_account_page.dart';
import '../pages/client/sick_session_doctor.dart';
import '../pages/client_page.dart';
import '../pages/drugs_page.dart';
import '../pages/health_checks.dart';
import '../pages/secreterypage_indoc.dart';
import '../pages/sick.dart';
import 'add_patient.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);
  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/background1.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(1),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hello, ',
                            style: tilte2Style,
                          ),
                          FutureBuilder<String?>(
                            future: _storage.read(key: 'first_name'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String?> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: tilte2Style,
                                );
                              } else {
                                return const CircularProgressIndicator
                                    .adaptive();
                              }
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                    'Are you sure you want to log out?'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('CANCEL'),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () async {
                                      await _storage.delete(key: 'username');
                                      Navigator.of(context).pop();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ));
                                    },
                                    child: const Text('LOGOUT',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.logout, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/logo.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Wrap(
                      children: [
                        homePageCard(
                          context,
                          'Drugs',
                          const DrugsPage(doctorId: ''),
                        ),
                        homePageCard(
                          context,
                          'Add Patient',
                          const AddPatient(),
                        ),
                        homePageCard(
                          context,
                          'ادوية العياده',
                          const ClientPage(
                              doctorID: 'widget.doctorID.toString()'),
                        ),
                        homePageCard(
                          context,
                          'صفحة المراجعين',
                          const SickSessionDoctor(
                            doctorId: 'widget.doctorID.toString()',
                            doctorName: ' widget.doctorName.toString()',
                          ),
                        ),
                        homePageCard(
                          context,
                          ' Without secretary صفحة المراجعين',
                          const SickPage(
                            secretaryId: 'doctor',
                            doctorID: 'widget.doctorID.toString()',
                            doctorName: 'widget.doctorName.toString()',
                          ),
                        ),
                        homePageCard(
                          context,
                          'Add Secretary ',
                          const AddSecretary(
                            doctorID: ' widget.doctorID.toString()',
                            deviceId: 'widget.deviceId.toString()',
                          ),
                        ),
                        homePageCard(
                          context,
                          '‏الفحوصات الطبية',
                          const HealthChecks(),
                        ),
                        homePageCard(
                          context,
                          '‏المواعيد',
                          const Appointment(
                              doctorId: 'widget.doctorID.toString()'),
                        ),
                        homePageCard(
                          context,
                          '‏المصروفات',
                          const ClientAccountPage(
                              doctorId: 'widget.doctorID.toString()'),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
