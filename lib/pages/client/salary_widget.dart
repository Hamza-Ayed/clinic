import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/db/db.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';

class SalaryWidget extends StatefulWidget {
  final String doctorId;

  const SalaryWidget({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<SalaryWidget> createState() => _SalaryWidgetState();
}

class _SalaryWidgetState extends State<SalaryWidget> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController totalBill = TextEditingController();
  TextEditingController kiloMonth = TextEditingController();
  // TextEditingController salaryController = TextEditingController();
  List salaryList = [];
  String? choose;
  Future get() async {
    await Methods().getSecretary(widget.doctorId.toString()).then((value) {
      setState(() {
        salaryList = value;
      });
    });
    print(salaryList);
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: salaryList.length < 3 ? 70.0 * (salaryList.length) : 210,
            color: nb3,
            child: Center(
              child: ListView.builder(
                itemCount: salaryList.length,
                itemBuilder: (BuildContext context, int index) {
                  var res = salaryList[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      color: news3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: Column(
                              children: [
                                Text(res['doctor_name']),
                                Text(res['date_register']),
                                // Text(res['date_register']),
                              ],
                            ),
                          ),
                          // Text(res['totalSalary']),
                          IconButton(
                              onPressed: () async {
                                AwesomeDialog(
                                    context: context,
                                    body: SizedBox(
                                      child: TextField(
                                        decoration: const InputDecoration(
                                            hintText: 'insert'),
                                        controller: salaryController,
                                      ),
                                      width: 80,
                                    ),
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () async {
                                      await DBSql('salary').insert({
                                        'Secretary_id':
                                            res['Secretary_id'].toString(),
                                        'doctor_id': res['doctor_id'],
                                        'salary': salaryController.text,
                                        'salary_pluse': '0',
                                        'salary_minus': '0',
                                      });

                                      await Methods().addSallary(
                                          res['device_id'].toString(),
                                          salaryController.text.toString(),
                                          '0',
                                          '0',
                                          res['doctor_id'].toString(),
                                          'date');
                                      DBSql('salary')
                                          .getData('salary')
                                          .then((value) {
                                        setState(() {
                                          // salaryListSql = value;
                                        });
                                      });
                                      // Navigator.pop(context);
                                    }).show();
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 100,
            color: nb4,
            child: Row(
              children: [
                const Text('Electric'),
                IconButton(
                    onPressed: () async {
                      AwesomeDialog(
                          context: context,
                          body: Column(
                            children: [
                              SizedBox(
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText: 'insert Electric total Bill'),
                                  controller: totalBill,
                                ),
                                width: 180,
                              ),
                              SizedBox(
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText:
                                          'insert Electric Kilo from bill'),
                                  controller: kiloMonth,
                                ),
                                width: 220,
                              ),
                              SizedBox(
                                child: DropdownButton(
                                  value: choose,
                                  items: [
                                    '1',
                                    '2',
                                    '3',
                                    '4',
                                    '5',
                                    '6',
                                    '7',
                                    '8',
                                    '9',
                                    '10',
                                    '11',
                                    '12'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: const Text('choose'),
                                  onChanged: (value) => setState(() {
                                    choose = value.toString();
                                  }),
                                ),
                              ),
                            ],
                          ),
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            await (Methods().addElectricBill(
                                totalBill.text,
                                kiloMonth.text,
                                choose.toString(),
                                widget.doctorId.toString()));

                            Navigator.pop(context);
                          }).show();
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
