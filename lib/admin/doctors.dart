import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/home_page.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';

class AdmiDoctorPage extends StatefulWidget {
  final List list;
  final String isAdmin;
  const AdmiDoctorPage({Key? key, required this.list, required this.isAdmin})
      : super(key: key);
  @override
  _AdmiDoctorPageState createState() => _AdmiDoctorPageState();
}

class _AdmiDoctorPageState extends State<AdmiDoctorPage> {
  var doctorsCount = 0;

  @override
  void initState() {
    setState(() {
      doctorsCount = widget.list.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors Page $doctorsCount',
          style: tilte2Style,
        ),
        elevation: 0,
        backgroundColor: grey,
      ),
      backgroundColor: grey,
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          var res = widget.list[index];
          // DateTime datetime = DateTime.parse(res['date_register'].toString());
          // var outputFormat = DateFormat('dd/MM/yyyy');
          // var date = outputFormat.format(datetime);
          return InkWell(
            onLongPress: () {
              AwesomeDialog(
                  context: context,
                  title: 'Delete Doctors',
                  body: const Text('Are you sure to delete'),
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    await Methods().deleteSecretary(res['doctor_id']);
                  }).show();
            },
            child: NeomphormDark(
                width: .3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            child: NeomphormDark(
                              child: Text(
                                res['doctor_name'],
                                style: tilte1Style,
                              ),
                              color: grey!,
                              width: .5,
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                      isAdmin: widget.isAdmin.toString(),
                                      doctorID: res['doctor_id'],
                                      deviceId: res['device_id'],
                                      doctorName: res['clientName']),
                                ))),
                        InkWell(
                          child: NeomphormDark(
                            child: Text(res['phone']),
                            width: .3,
                            color: Colors.blue.shade300,
                          ),
                          onTap: () async =>
                              Methods().callPhone(res['phone'].toString()),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: NeomphormDark(
                            child: Text(res['reg']),
                            color: res['reg'].toString() == '1' ? gren! : news2,
                            width: .1,
                          ),
                          onTap: () {
                            AwesomeDialog(
                                context: context,
                                title: 'Update Status',
                                body: const Text('Are You sure to Update it'),
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  var stat =
                                      res['reg'].toString() == '1' ? '2' : '1';
                                  // print(stat);
                                  // print(res['doctor_id']);
                                  await Methods().updateStatus(
                                      res['doctor_id'].toString(),
                                      stat.toString());
                                }).show();
                          },
                        ),
                        NeomphormDark(
                          child: Text(
                            res['countSick'].toString() + ' Sick Count',
                            style: tilte1Style,
                          ),
                          width: .3,
                          color: news3.withOpacity(.6),
                        ),
                        NeomphormDark(
                          child: Text(res['date_register']),
                          width: .1,
                          color: int.parse(res['date_register']) < 15
                              ? news1
                              : news2,
                        ),
                      ],
                    ),
                  ],
                ),
                color: nb4),
          );
        },
      ),
    );
  }
}
