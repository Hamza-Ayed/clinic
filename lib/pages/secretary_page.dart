import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/sick.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'appointment.dart';
import 'client/clint_account_page.dart';
import 'client_page.dart';
import 'method.dart';

class SecretaryPage extends StatefulWidget {
  final String doctorId, doctorName, roleId, secretaryName, secretaryId;

  const SecretaryPage(
      {Key? key,
      required this.doctorId,
      required this.doctorName,
      required this.roleId,
      required this.secretaryName,
      required this.secretaryId})
      : super(key: key);
  @override
  _SecretaryPageState createState() => _SecretaryPageState();
}

class _SecretaryPageState extends State<SecretaryPage> {
  bool isloading = true;

  String gender = "ذكر";

  String? dateRegister = '';
  List list = [];
  String? birthDate = 'chose Birth date';
  DateTime selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDate = DateFormat("yyyy-MM-dd ").format(selectedDate);
      });
    }
  }

  @override
  void initState() {
    dateRegister = DateFormat("yyyy-MM-dd ").format(DateTime.now());
    // print(widget.secretaryId);
    //// Methods().getSick(widget.doctorId.toString()).then((value) {
    //   setState(() {
    //     isloading = false;
    //     list = value;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                widget.secretaryName.toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: nb1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Helvetica'),
              ),
              Text(
                ' ${widget.doctorName} ${widget.roleId}',
                style: TextStyle(
                    fontSize: 12,
                    color: news2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Helvetica'),
              )
            ],
          ),
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  homePageCard(
                    context,
                    '‏صفحة المراجعين',
                    SickPage(
                      doctorID: widget.doctorId,
                      doctorName: widget.doctorName,
                      secretaryId: widget.secretaryId.toString(),
                    ),
                  ),
                  homePageCard(
                      context,
                      '‏المواعيد',
                      Appointment(
                        doctorId: widget.doctorId.toString(),
                      )),
                  widget.roleId == '1'
                      ? homePageCard(
                          context,
                          '‏المصروفات',
                          ClientAccountPage(
                            doctorId: widget.doctorId.toString(),
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  widget.roleId == '1'
                      ? homePageCard(context, 'ادوية العياده',
                          ClientPage(doctorID: widget.doctorId.toString()))
                      : const SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
          ),
        ));
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
          child: Text(name, style: tilte1Style),
          width: .45,
        ));
  }
}
