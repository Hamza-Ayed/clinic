import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:intl/intl.dart';

class AdminSecretaries extends StatefulWidget {
  final String doctorId;

  const AdminSecretaries({Key? key, required this.doctorId}) : super(key: key);

  @override
  _AdminSecretariesState createState() => _AdminSecretariesState();
}

class _AdminSecretariesState extends State<AdminSecretaries> {
  String? sickName = "";
  String sickID = "";
  String? date = DateTime.now().toString();

  bool isloading = true;
  List secretary = [];
  List saatjob = [];
  String? selectedTime;
  String? selectedTime2;
  DateTime? time1;

  Future show1() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
            data: ThemeData(),
            child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            ));
      },
    );
    if (result != null) {
      setState(() {
        selectedTime = result.format(context);
        // time1 = selectedTime as DateTime?;
        // selectedTime = result.format(context);
        // selectedTime = DateFormat.Hm().format(time1!);
        print(selectedTime);
      });
    }
  }

  Future show2() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
            data: ThemeData(),
            child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            ));
      },
    );
    if (result != null) {
      setState(() {
        selectedTime2 = result.format(context);
        print(selectedTime2);
      });
    }
  }

  get() async {
    date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    await Methods().getSecretary(widget.doctorId.toString()).then((value) {
      setState(() {
        secretary = value;
      });
    });
    await Methods().getSecretarySaatJob().then((value) {
      setState(() {
        saatjob = value;
        // print(saatjob);
      });
    });
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Secretary'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .4,
              color: sa5.withOpacity(.2),
              child: ListView.builder(
                itemCount: secretary.length,
                itemBuilder: (BuildContext context, int index) {
                  var res = secretary[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GlassContainer.clearGlass(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: news3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(res['doctor_name'].toString()),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await show1();
                                        await show2();

                                        await Methods()
                                            .addSaatJob(
                                                selectedTime.toString(),
                                                selectedTime2.toString(),
                                                res['doctor_id'],
                                                widget.doctorId,
                                                date.toString())
                                            .then((value) {
                                          setState(() {
                                            get();
                                          });
                                        });
                                      },
                                      child: const Text(
                                        'Job Saat 1  : ',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    Text(selectedTime.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await show2();
                                      },
                                      child: const Text(
                                        'Job Saat 2  : ',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    Text(selectedTime2.toString()),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                Methods().callPhone(res['phone'].toString());
                              },
                              child: Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.phone,
                                    size: 10,
                                    color: ikea1,
                                  ),
                                  Text(res['phone'].toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              color: nb2,
              height: MediaQuery.of(context).size.height * .3,
            )
          ],
        ),
      ),
    );
  }
}
