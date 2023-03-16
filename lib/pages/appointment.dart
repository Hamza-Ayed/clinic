import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/add_appointment.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key, required this.doctorId}) : super(key: key);
  final String doctorId;

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  List appointment = [];
  List sick = [];
  String? sickName = "";
  String today = '';
  DateTime selectedStartDate = DateTime.now();
  String? stratAppointment = DateTime.now().toString();
  String sickID = "";
  Future selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        stratAppointment = DateFormat("yyyy-MM-dd").format(selectedStartDate);
      });
    }
  }

  void get() async {
    await Methods()
        .getAppointmentDoctor(widget.doctorId.toString())
        .then((value) {
      setState(() {
        appointment = value;
      });
    });
    // for (var i = 0; i < appointment.length; i++) {
    //   Methods().getDataSource(
    //     appointment[i]['startDate'].toString(),
    //     appointment[i]['endDate'].toString(),
    //     appointment[i]['description'].toString(),
    //   );
    // }
    // print(appointment);
    await Methods().getSick(widget.doctorId.toString()).then((value) {
      setState(() {
        sick = value;
      });
    });
  }

  @override
  void initState() {
    today = DateFormat("yyyy-MM-dd").format(selectedStartDate);

    // setState(() {
    // stratAppointment = DateFormat("yyyy-MM-dd").format(selectedStartDate);
    // });
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        // title: Text(
        //   'Add Sick ...',
        //   style: tilte1Style,
        // ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: nb1,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ADDAppointment(
                            doctorId: widget.doctorId.toString(),
                            sickId: sickID.toString(),
                          ),
                        )).then((value) {
                      setState(() {
                        get();
                      });
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.plus,
                    color: ikea,
                  ))),
          InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext ctx) => AlertDialog(
                  title: const Center(child: Text(' ‏اختر المراجع')),
                  content: Container(
                    width: 350,
                    height: 350,
                    color: myMac1,
                    child: CustomSearchableDropDown(
                      primaryColor: Colors.green,
                      menuMode: true,
                      backgroundColor: nb4,
                      hint: 'write',
                      labelAlign: TextAlign.right,
                      menuHeight: 240,
                      // showClearButton: true,
                      dropdownBackgroundColor: nb3,
                      labelStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      items: sick,
                      label: 'Select Sick',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(Icons.person),
                      ),
                      dropDownMenuItems: sick.map((item) {
                        return item['name'];
                      }).toList(),
                      onChanged: (value) async {
                        if (value != null) {
                          setState(() {
                            sickName = value['name'].toString();
                            sickID = value['id'].toString();
                          });
                          Navigator.pop(context);
                          print(sickID);
                          await Methods()
                              .getAppointmentSick(sickID)
                              .then((value) {
                            setState(() {
                              // print(value);
                              appointment = value;
                            });
                          });
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     type: PageTransitionType.scale,
                          //     alignment: Alignment.bottomCenter,
                          //     child: ADDAppointment(
                          //       doctorId: widget.doctorId.toString(),
                          //       sickId: sickID.toString(),
                          //     ),
                          //   ),
                          // );
                          // Navigator.pop(context);
                        } else {
                          sickName = null;
                        }
                        // Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: gren,
                  ),
                  Text(
                    'Appointment for user',
                    style: tilte1Style,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        // child: SfCalendar(
        //   // dataSource:,
        //   view: CalendarView.month,
        //   initialDisplayDate: DateTime.now(),
        //   cellBorderColor: Colors.indigoAccent,
        //   firstDayOfWeek: 7,
        //   // monthViewSettings: const MonthViewSettings(showAgenda: true),
        //   timeSlotViewSettings: const TimeSlotViewSettings(
        //       startHour: 9,
        //       endHour: 16,
        //       nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
        //   dataSource: MeetingDataSource(Methods().getDataSource()),
        //   monthViewSettings: const MonthViewSettings(
        //       showAgenda: true,
        //       appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        // ),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 60,
            //   child: InkWell(
            //     child: Text('get'),
            //     // onTap: () async {
            //     //   await selectStartDate(context).then(get());
            //     // },
            //   ),
            // ),
            Expanded(
              flex: 3,
              child: Container(
                height: 400,
                color: myMac2.withOpacity(.18),
                child: ListView.builder(
                  itemCount: appointment.length,
                  itemBuilder: (BuildContext context, int index) {
                    var res = appointment[index];
                    // print(appointment);
                    return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 5,
                          shape: Border(
                            right: BorderSide(
                              color: news2,
                              width: 5,
                            ),
                            left: BorderSide(
                              color: news2,
                              width: 12,
                            ),
                          ),
                          child: ListTile(
                            dense: true,
                            tileColor:
                                res['startDate'] == today ? Colors.green : nb4,
                            title: Text(res['startDate'].toString()),
                            trailing: IconButton(
                                onPressed: () async {
                                  // print(res['Appointment']);
                                  await Methods().deleteAppointment(
                                      res['Appointment'].toString());
                                  setState(() {
                                    get();
                                  });
                                },
                                icon: const Icon(Icons.delete,
                                    color: Colors.red)),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(res['name'].toString()),
                                const SizedBox(
                                  width: 30,
                                ),
                                InkWell(
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.sms,
                                        color: news1,
                                      ),
                                      // Text(
                                      //   res['telphone'].toString(),
                                      // ),
                                    ],
                                  ),
                                  onTap: () async {
                                    Methods().sendSMS(
                                      res['doctorphone'].toString(),
                                      sick[index]['gender'].toString() == 'male'
                                          ? '‏حضرة السيدة ' +
                                              res['name'].toString() +
                                              ' '
                                                  ' ‏موعدك لدينا في  ' +
                                              res['startDate'].toString() +
                                              '  ' +
                                              '\n مع تحيات  ${res['doctorName']}'
                                          : '‏حضرة السيد ' +
                                              res['name'].toString() +
                                              ' '
                                                  ' ‏موعدك لدينا في  ' +
                                              res['startDate'].toString() +
                                              '  ' +
                                              '\n  ‏مع تحيات  ${res['doctorName']}',
                                    );
                                  },
                                ),
                                InkWell(
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        color: news2,
                                      ),
                                      // Text(
                                      //   res['telphone'].toString(),
                                      // ),
                                    ],
                                  ),
                                  onTap: () async {
                                    Methods().sendWhatssApp(
                                      res['doctorphone'].toString(),
                                      sick[index]['gender'].toString() == 'male'
                                          ? '‏حضرة السيدة ' +
                                              res['name'].toString() +
                                              ' '
                                                  ' ‏موعدك لدينا في  ' +
                                              res['startDate'].toString() +
                                              '  ' +
                                              '\n مع تحيات  ${res['doctorName']}'
                                          : '‏حضرة السيد ' +
                                              res['name'].toString() +
                                              ' '
                                                  ' ‏موعدك لدينا في  ' +
                                              res['startDate'].toString() +
                                              '  ' +
                                              '\n  ‏مع تحيات  ${res['doctorName']}',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
