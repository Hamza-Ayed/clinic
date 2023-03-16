import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctors/Login/login_new.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/db/db.dart';
import 'package:doctors/pages/client/sick_session_doctor.dart';
import 'package:doctors/pages/method.dart';
import 'package:doctors/pages/sick.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

import 'appointment.dart';
import 'client_page.dart';
import 'client/clint_account_page.dart';
import 'drugs_page.dart';
import 'health_checks.dart';
import 'secreterypage_indoc.dart';

class HomePage extends StatefulWidget {
  final String doctorID, deviceId, doctorName, isAdmin;

  const HomePage({
    Key? key,
    required this.doctorID,
    required this.deviceId,
    required this.doctorName,
    required this.isAdmin,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAdmin.toString() == 'yes'
          ? AppBar(
              backgroundColor: Colors.grey[300],
              elevation: 0,
              title: Text(
                widget.doctorName.toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: nb1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Helvetica'),
              ),
            )
          : AppBar(
              backgroundColor: Colors.grey[300],
              elevation: 0,
              title: Text(
                widget.doctorName.toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: nb1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Helvetica'),
              ),
              leading: IconButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogBackgroundColor: d2,
                    dialogType: DialogType.WARNING,
                    useRootNavigator: true,
                    title: 'LogOff',
                    body: Text(
                      'Are you dure to LogOff',
                      style: tilte2Style,
                    ),
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreenNew(
                                deviceNumber: widget.deviceId.toString()),
                          ));
                      await DBSql('Users').deleteAll('Users');
                    },
                  ).show();
                },
                icon: const Icon(Icons.close),
                color: news2,
              ),
            ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          homePageCard(
              context,
              'Drugs',
              DrugsPage(
                doctorId: widget.doctorID.toString(),
              )),
          homePageCard(context, 'ادوية العياده',
              ClientPage(doctorID: widget.doctorID.toString())),
          homePageCard(
            context,
            'صفحة المراجعين',
            SickSessionDoctor(
              doctorId: widget.doctorID.toString(),
              // secretaryId: '',
              // doctorID: widget.doctorID.toString(),
              doctorName: widget.doctorName.toString(),
            ),
          ),
          homePageCard(
            context,
            ' Without secretary صفحة المراجعين',
            SickPage(
              secretaryId: 'doctor',
              doctorID: widget.doctorID.toString(),
              doctorName: widget.doctorName.toString(),
            ),
          ),
          homePageCard(
              context,
              'Add Secretary ',
              AddSecretary(
                doctorID: widget.doctorID.toString(),
                deviceId: widget.deviceId.toString(),
              )),
          homePageCard(context, '‏الفحوصات الطبية', const HealthChecks()),
          homePageCard(
              context,
              '‏المواعيد',
              Appointment(
                doctorId: widget.doctorID.toString(),
              )),
          // homePageCard(
          //     context,
          //     'Admin Secretey',
          //     AdminSecretaries(
          //       doctorId: widget.doctorID.toString(),
          //     )),
          homePageCard(
            context,
            '‏المصروفات',
            ClientAccountPage(
              doctorId: widget.doctorID.toString(),
            ),
          ),
        ],
      )),
      // bottomNavigationBar: SnakeNavigationBar.color(
      //   behaviour: snakeBarStyle,
      //   snakeShape: snakeShape,
      //   shape: bottomBarShape,
      //   padding: padding,

      //   ///configuration for SnakeNavigationBar.color
      //   snakeViewColor: selectedColor,
      //   selectedItemColor:
      //       snakeShape == SnakeShape.indicator ? selectedColor : null,
      //   unselectedItemColor: Colors.blueGrey,

      //   // /configuration for SnakeNavigationBar.gradient
      //   // snakeViewGradient: selectedGradient,
      //   // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
      //   // unselectedItemGradient: unselectedGradient,

      //   showUnselectedLabels: showUnselectedLabels,
      //   showSelectedLabels: showSelectedLabels,

      //   currentIndex: _selectedItemPosition,
      //   onTap: (index) => setState(() => _selectedItemPosition = index),
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.notifications), label: 'tickets'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.calendar_today), label: 'calendar'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.podcasts), label: 'microphone'),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search')
      //   ],
      // ),
    );
  }

  InkWell homePageCard(BuildContext context, String name, Widget page) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.bottomCenter,
                  child: page));
        },
        child: Neomphorm(
          child: Center(
              child: Text(
            name,
            style: tilte1Style,
            textAlign: TextAlign.center,
          )),
          width: .45,
        ));
  }
}
