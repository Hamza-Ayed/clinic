import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/db/db.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'salary_widget.dart';

class ClientAccountPage extends StatefulWidget {
  final String doctorId;

  const ClientAccountPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  _ClientAccountPageState createState() => _ClientAccountPageState();
}

class _ClientAccountPageState extends State<ClientAccountPage> {
  TextEditingController salary = TextEditingController();
  TextEditingController electric = TextEditingController();
  TextEditingController rent = TextEditingController();
  TextEditingController visit = TextEditingController();
  TextEditingController water = TextEditingController();
  TextEditingController gas = TextEditingController();
  TextEditingController tibiIhtiac = TextEditingController();
  TextEditingController paper = TextEditingController();
  TextEditingController electricKilo = TextEditingController();

  String? choose = '‏رواتب';
  bool isloading = true;
  List list = [];
  List salaryListSql = [];
  List salarylist = [];
  List waterlist = [];
  List gaslist = [];
  List visitlist = [];
  List tibiIhtiaclist = [];
  List paperlist = [];
  List electriclist = [];
  List rentallist = [];
  List totalSalary = [];
  DateTime now = DateTime.now();
  String? date = DateTime.now().toString();
  double? total = 0;
  List salaryItem = [
    '‏رواتب',
    '‏الكهرباء',
    '‏اجار العيادة',
    '‏ضيافة',
    '‏المياه',
    '‏غاز',
    '‏لوازم طبية',
    '‏اوراق',
    '',
    '',
  ];
  Future get() async {
    await Methods()
        .getSalaryTotal(
      widget.doctorId.toString(),
      date.toString(),
    )
        .then((value) {
      setState(() {
        totalSalary = value;
      });
    });
    // print(totalSalary);
    // setState(() {
    //   if (totalSalary[0]['total_bill'] == null) {
    //     totalSalary[0]['total_bill'] == '0';
    //   }
    //   if (totalSalary[0]['gasCount'] == null) {
    //     totalSalary[0]['gasCount'] == '0';
    //   }
    //   if (totalSalary[0]['paperCount'] == null) {
    //     totalSalary[0]['paperCount'] == '0';
    //   }
    //   if (totalSalary[0]['rent_count'] == null) {
    //     totalSalary[0]['rent_count'] == '0';
    //   }
    //   if (totalSalary[0]['salary'] == null) {
    //     totalSalary[0]['salary'] == '0';
    //   }
    //   if (totalSalary[0]['tibi'] == null) {
    //     totalSalary[0]['tibi'] == '0';
    //   }
    //   if (totalSalary[0]['visitCount'] == null) {
    //     totalSalary[0]['visitCount'] == '0';
    //   }
    //   if (totalSalary[0]['waterCount'] == null) {
    //     totalSalary[0]['waterCount'] == '0';
    //   }
    // });

    total = double.parse(totalSalary[0]['total_bill']) +
        double.parse(totalSalary[0]['gasCount']) +
        double.parse(totalSalary[0]['paperCount']) +
        double.parse(totalSalary[0]['rent_count']) +
        double.parse(totalSalary[0]['salary']) +
        double.parse(totalSalary[0]['tibi']) +
        double.parse(totalSalary[0]['visitCount']) +
        double.parse(totalSalary[0]['waterCount']);
  }

  @override
  void initState() {
    DBSql('salary').getData('salary').then((value) {
      setState(() {
        salaryListSql = value;
      });
    });
    date = DateFormat("yyyy-MM").format(now);
    get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '‏مصروفات العيادة',
          style: tilte1Style,
        ),
        elevation: 0,
        backgroundColor: grey,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [ 
              //vvvvv
              // SizedBox(
              //   height: 50,
              //   // color: nb1,
              //   child: DropdownButton(
              //     value: choose,
              //     items: [
              //       '‏رواتب',
              //       '‏الكهرباء',
              //       '‏اجار العيادة',
              //       '‏ضيافة',
              //       '‏المياه',
              //       '‏غاز',
              //       '‏لوازم طبية',
              //       '‏اوراق',
              //       '',
              //       '',
              //       ''
              //     ].map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //     hint: const Text('choose'),
              //     onChanged: (value) => setState(() {
              //       choose = value.toString();
              //     }),
              //   ),
              // ),
              // ClientWidget(
              //   choose: choose.toString(),
              //   doctorId: widget.doctorId.toString(),
              // ),
              Container(
                  color: grey,
                  height: 600,
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        NeomphormDark(
                          width: 1,
                          color: nb4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogBackgroundColor: nb3,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Add Salary',
                                      // desc: 'Dialog description here.............',
                                      body: NeomphormDark(
                                        color: grey!,
                                        width: .5,
                                        child: TextField(
                                          controller: salary,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.money),
                                              hintText: 'insert here'),
                                        ),
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await Methods().addSallary(
                                          '1',
                                          salary.text.toString(),
                                          '0',
                                          '0',
                                          widget.doctorId.toString(),
                                          date.toString(),
                                        );
                                        setState(() {
                                          get();
                                        });
                                      },
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: gren,
                                  )),
                              NeomphormDark(
                                  width: .2,
                                  child: totalSalary[0]['salary'] == null
                                      ? const Text('0')
                                      : Text(
                                          totalSalary[0]['salary'].toString()),
                                  color: nb3),
                              Neomphorm(
                                width: .5,
                                child: Text(
                                  salaryItem[0].toString(),
                                  style: tilte1Style,
                                ),
                              )
                            ],
                          ),
                        ),
                        NeomphormDark(
                          width: 1,
                          color: nb4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogBackgroundColor: nb3,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Add Electric',
                                      // desc: 'Dialog description here.............',
                                      body: NeomphormDark(
                                        color: grey!,
                                        width: .5,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: electric,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.power),
                                                  hintText: 'insert here Bill'),
                                            ),
                                            TextField(
                                              controller: electricKilo,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.power_input),
                                                  hintText: 'insert in Kilo'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await Methods().addElectricBill(
                                            electric.text.toString(),
                                            electricKilo.text.toString(),
                                            date.toString(),
                                            widget.doctorId.toString());
                                        setState(() {
                                          get();
                                        });
                                      },
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: gren,
                                  )),
                              NeomphormDark(
                                  width: .2,
                                  child: totalSalary[0]['total_bill'] == null
                                      ? const Text('0')
                                      : Text(totalSalary[0]['total_bill']
                                          .toString()),
                                  color: nb3),
                              Neomphorm(
                                width: .5,
                                child: Text(
                                  salaryItem[1].toString(),
                                  style: tilte1Style,
                                ),
                              )
                            ],
                          ),
                        ),
                        NeomphormDark(
                          width: 1,
                          color: nb4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogBackgroundColor: nb3,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Add Rental ...',
                                      // desc: 'Dialog description here.............',
                                      body: NeomphormDark(
                                        color: grey!,
                                        width: .5,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: rent,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons.attach_money_sharp),
                                                  hintText: 'insert here'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await Methods().addRental(
                                            rent.text.toString(),
                                            date.toString(),
                                            widget.doctorId.toString());
                                        setState(() {
                                          get();
                                        });
                                      },
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: gren,
                                  )),
                              NeomphormDark(
                                  width: .2,
                                  child: totalSalary[0]['rent_count'] == null
                                      ? const Text('0')
                                      : Text(totalSalary[0]['rent_count']
                                          .toString()),
                                  color: nb3),
                              Neomphorm(
                                width: .5,
                                child: Text(
                                  salaryItem[2].toString(),
                                  style: tilte1Style,
                                ),
                              )
                            ],
                          ),
                        ),
                        NeomphormDark(
                          width: 1,
                          color: nb4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogBackgroundColor: nb3,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Add Rental ...',
                                      // desc: 'Dialog description here.............',
                                      body: NeomphormDark(
                                        color: grey!,
                                        width: .5,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: visit,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.visibility),
                                                  hintText: 'insert here'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await Methods().addVisiting(
                                            visit.text.toString(),
                                            date.toString(),
                                            widget.doctorId.toString());
                                        setState(() {
                                          get();
                                        });
                                      },
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: gren,
                                  )),
                              NeomphormDark(
                                  width: .2,
                                  child: totalSalary[0]['visitCount'] == null
                                      ? const Text('0')
                                      : Text(totalSalary[0]['visitCount']
                                          .toString()),
                                  color: nb3),
                              Neomphorm(
                                width: .5,
                                child: Text(
                                  salaryItem[3].toString(),
                                  style: tilte1Style,
                                ),
                              )
                            ],
                          ),
                        ),
                        NeomphormDark(
                          width: 1,
                          color: nb4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogBackgroundColor: nb3,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Add Rental ...',
                                      // desc: 'Dialog description here.............',
                                      body: NeomphormDark(
                                        color: grey!,
                                        width: .5,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: water,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.water),
                                                  hintText: 'insert here'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await Methods().addWater(
                                            water.text.toString(),
                                            date.toString(),
                                            widget.doctorId.toString());
                                        setState(() {
                                          get();
                                        });
                                      },
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: gren,
                                  )),
                              NeomphormDark(
                                  width: .2,
                                  child: totalSalary[0]['waterCount'] == null
                                      ? const Text('0')
                                      : Text(totalSalary[0]['waterCount']
                                          .toString()),
                                  color: nb3),
                              Neomphorm(
                                width: .5,
                                child: Text(
                                  salaryItem[4].toString(),
                                  style: tilte1Style,
                                ),
                              )
                            ],
                          ),
                        ),
                        NeomphormDark(
                          width: 1,
                          color: nb4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogBackgroundColor: nb3,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Add Gas ...',
                                      // desc: 'Dialog description here.............',
                                      body: NeomphormDark(
                                        color: grey!,
                                        width: .5,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: gas,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.water),
                                                  hintText: 'insert here'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await Methods().addGas(
                                            gas.text.toString(),
                                            date.toString(),
                                            widget.doctorId.toString());
                                        setState(() {
                                          get();
                                        });
                                      },
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: gren,
                                  )),
                              NeomphormDark(
                                  width: .2,
                                  child: totalSalary[0]['gasCount'] == null
                                      ? const Text('0')
                                      : Text(totalSalary[0]['gasCount']
                                          .toString()),
                                  color: nb3),
                              Neomphorm(
                                width: .5,
                                child: Text(
                                  salaryItem[5].toString(),
                                  style: tilte1Style,
                                ),
                              )
                            ],
                          ),
                        ),
                        NeomphormDark(
                          width: 1,
                          color: nb4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogBackgroundColor: nb3,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Add Ihtiac ...',
                                      // desc: 'Dialog description here.............',
                                      body: NeomphormDark(
                                        color: grey!,
                                        width: .5,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: tibiIhtiac,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.cabin),
                                                  hintText: 'insert here'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await Methods().addIhtiac(
                                            tibiIhtiac.text.toString(),
                                            date.toString(),
                                            widget.doctorId.toString());
                                        setState(() {
                                          get();
                                        });
                                      },
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: gren,
                                  )),
                              NeomphormDark(
                                  width: .2,
                                  child: totalSalary[0]['tibi'] == null
                                      ? const Text('0')
                                      : Text(totalSalary[0]['tibi'].toString()),
                                  color: nb3),
                              Neomphorm(
                                width: .5,
                                child: Text(
                                  salaryItem[6].toString(),
                                  style: tilte1Style,
                                ),
                              )
                            ],
                          ),
                        ),
                        NeomphormDark(
                          width: 1,
                          color: nb4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogBackgroundColor: nb3,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Add Ihtiac ...',
                                      // desc: 'Dialog description here.............',
                                      body: NeomphormDark(
                                        color: grey!,
                                        width: .5,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: paper,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.label),
                                                  hintText: 'insert here'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await Methods().addPaper(
                                            paper.text.toString(),
                                            date.toString(),
                                            widget.doctorId.toString());
                                        setState(() {
                                          get();
                                        });
                                      },
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: gren,
                                  )),
                              NeomphormDark(
                                  width: .2,
                                  child: totalSalary[0]['paperCount'] == null
                                      ? const Text('0')
                                      : Text(totalSalary[0]['paperCount']
                                          .toString()),
                                  color: nb3),
                              Neomphorm(
                                width: .5,
                                child: Text(
                                  salaryItem[7].toString(),
                                  style: tilte1Style,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: news2,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total is  ',
                style: tilte2Style,
              ),
              Text(
                total.toString(),
                style: tilte2Style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientWidget extends StatelessWidget {
  final String choose, doctorId;

  const ClientWidget({Key? key, required this.choose, required this.doctorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (choose == '‏رواتب') {
      return SalaryWidget(
        doctorId: doctorId.toString(),
      );
    }
    return Container(
      height: 400,
      color: nb4,
      child: const Center(child: Card()),
    );
  }
}
