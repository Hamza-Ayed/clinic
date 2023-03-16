import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/home_page.dart';
import 'package:doctors/pages/method.dart';
import 'package:doctors/pages/secretary_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AdmiSecretaryPage extends StatefulWidget {
  final List list;

  const AdmiSecretaryPage({Key? key, required this.list}) : super(key: key);
  @override
  _AdmiSecretaryPageState createState() => _AdmiSecretaryPageState();
}

class _AdmiSecretaryPageState extends State<AdmiSecretaryPage> {
  List list = [];
  @override
  void initState() {
    super.initState();
    list = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Secretary Page ',
          style: tilte2Style,
        ),
        elevation: 0,
        backgroundColor: grey,
      ),
      backgroundColor: grey,
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          var res = list[index];
          return NeomphormDark(
              width: .9,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              child: SecretaryPage(
                                secretaryId: '',
                                doctorName: res['clientName'],
                                doctorId: res['doctor_id'].toString(),
                                roleId: res['doctor_name'].toString(),
                                secretaryName: res['secretary_name'],
                              ),
                            ),
                          );
                        },
                        child: Neomphorm(
                          child: Text(
                            res['secretary_name'],
                            style: tilte1Style,
                          ),
                          width: .4,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                  isAdmin: 'no',
                                  doctorID: res['doctor_id'],
                                  deviceId: res['device_id'],
                                  doctorName: res['clientName']),
                            )),
                        child: NeomphormDark(
                            width: .5,
                            child: Text(
                              res['doctor_name'].toString(),
                              style: tilte1Style,
                            ),
                            color: sa5),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      NeomphormDark(
                          width: .3,
                          child: Text(
                            res['days'].toString() + ' Days ',
                            style: tilte1Style,
                          ),
                          color: myMac2),
                      NeomphormDark(
                          width: .3,
                          child: Text(
                            res['month'].toString() + ' Months ',
                            style: tilte1Style,
                          ),
                          color: myMac3)
                    ],
                  )
                ],
              ),
              color: grey!);
        },
      ),
    );
  }
}
