import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ADDAppointment extends StatefulWidget {
  final String doctorId, sickId;

  const ADDAppointment({Key? key, required this.doctorId, required this.sickId})
      : super(key: key);

  @override
  State<ADDAppointment> createState() => _ADDAppointmentState();
}

class _ADDAppointmentState extends State<ADDAppointment> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String? birthDate = 'chose Birth date';
  String? stratAppointment = DateTime.now().toString();
  String? endAppointment = DateTime.now().toString();
  TextEditingController description = TextEditingController();
  selectStartDate(BuildContext context) async {
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

  List sick = [];

  String? sickName = "‏اختر المراجع";
  String sickID = "";
  get() async {
    await Methods().getSick(widget.doctorId.toString()).then((value) {
      setState(() {
        sick = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    stratAppointment = DateFormat("yyyy-MM-dd").format(DateTime.now());

    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        title: Text(
          'المراجعين',
          style: tilte1Style,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: nb1,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neomphorm(
                    width: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NeomphormDark(
                            color: grey!,
                            width: .4,
                            child: const Text('Select Start date')),
                        TextButton(
                            onPressed: () {
                              selectStartDate(context);
                            },
                            child: NeomphormDark(
                                width: .31,
                                color: Colors.yellow.shade300,
                                child: Text(
                                  stratAppointment.toString(),
                                  style: tilte1Style,
                                ))),
                      ],
                    ),
                  ),
                ),
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
                                // get();

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
                    child: Neomphorm(
                      width: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sickName.toString(),
                            style: tilte1Style,
                          ),
                          Icon(
                            Icons.person,
                            color: news2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neomphorm(
                    width: 1,
                    child: TextField(
                        controller: description,
                        decoration: const InputDecoration(
                          hintText: 'desc',
                          prefixIcon: Icon(Icons.description),
                        )),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Methods().addAppointment(
                      description.text.toString(),
                      stratAppointment.toString(),
                      selectedStartDate.add(const Duration(hours: 1)),
                      'Colors.accents.toString()',
                      widget.doctorId.toString(),
                      sickID.toString(),
                    );
                    Navigator.pop(
                      context,
                    );
                  },
                  child: NeomphormDark(
                    child: Text(
                      'save',
                      style: tilte1Style,
                    ),
                    width: 100,
                    color: Colors.green.shade200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
