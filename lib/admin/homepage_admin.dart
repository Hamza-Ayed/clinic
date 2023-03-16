import 'package:doctors/admin/sick_admin_page.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admi_secretary_page.dart';
import 'doctors.dart';

class AdminPage extends StatefulWidget {
  final String deviceID, isAdmin;

  const AdminPage({Key? key, required this.deviceID, required this.isAdmin})
      : super(key: key);
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isloading = false;
  bool isloadingSick = false;
  bool isloadingSecr = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Page',
          style: tilte2Style,
        ),
        elevation: 0,
        backgroundColor: grey,
      ),
      backgroundColor: grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      isloadingSecr = true;
                    });
                    await Methods().showSecretary().then((value) {
                      // print(value);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdmiSecretaryPage(
                              list: value,
                            ),
                          ));
                    });
                    setState(() {
                      isloadingSecr = false;
                    });
                  },
                  child: NeomphormDark(
                    width: .6,
                    child: isloadingSecr
                        ? const CupertinoActivityIndicator()
                        : Text(
                            'Show Secretary',
                            style: tilte2Style,
                          ),
                    color: sa1.withOpacity(.5),
                  ),
                ),
                InkWell(
                  child: NeomphormDark(
                    width: .6,
                    child: isloading
                        ? const CupertinoActivityIndicator()
                        : Text(
                            'Show Doctors',
                            style: tilte2Style,
                          ),
                    color: gren!,
                  ),
                  onTap: () async {
                    setState(() {
                      isloading = true;
                    });
                    await Methods().showAllDoctors().then((value) {
                      // print(value);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdmiDoctorPage(
                              isAdmin: widget.isAdmin.toString(),
                              list: value,
                            ),
                          ));
                    });
                    setState(() {
                      isloading = false;
                    });
                  },
                ),
                //
                InkWell(
                  child: NeomphormDark(
                    width: .6,
                    child: isloadingSick
                        ? const CupertinoActivityIndicator()
                        : Text(
                            'SHOW SICK',
                            style: tilte2Style,
                          ),
                    color: nb4,
                  ),
                  onTap: () async {
                    setState(() {
                      isloadingSick = true;
                    });
                    await Methods().showAllSick().then((value) {
                      print(value);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SickPageAdmin(
                              list: value,
                            ),
                          ));
                    });
                    setState(() {
                      isloadingSick = false;
                    });
                  },
                ),
                NeomphormDark(
                  width: .6,
                  child: Text(
                    'SHOW Doctor Stat',
                    style: tilte2Style,
                  ),
                  color: myMac2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
