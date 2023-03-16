import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/db/db.dart';
import 'package:doctors/pages/clientpagesick.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SickSessionDoctor extends StatefulWidget {
  final String doctorId, doctorName;

  const SickSessionDoctor({
    Key? key,
    required this.doctorId,
    required this.doctorName,
    // required this.sickId,
    // required this.sessionId,
  }) : super(key: key);
  @override
  _SickSessionDoctorState createState() => _SickSessionDoctorState();
}

class _SickSessionDoctorState extends State<SickSessionDoctor> {
  TextEditingController status = TextEditingController();

  List sick = [];
  List session = [];
  List checks = [];
  List drugs = [];
  List tests = [];
  String? sickName = "";
  String sickID = "";
  bool isloading = true;
  String? ilacId1 = '0';
  String? ilacIName1 = '  ‏العلاج الأول';
  String? ilacId2 = '0';
  String? ilacIName2 = 'العلاج  ‏الثاني';
  String? ilacId3 = '0';
  String? ilacIName3 = 'العلاج  ‏الثالث';
  String? ilacId4 = '0';
  String? ilacIName4 = 'العلاج  ‏الرابع';
  String? ilacId5 = '0';
  String? ilacIName5 = 'العلاج  ‏الخامس';
  String? test1 = ' ‏الفحص الأول';
  String? test2 = ' ‏الفحص الثاني';
  String? test3 = ' ‏الفحص الثالث';
  String? test4 = ' ‏الفحص الرابع';
  String? testid1 = '0';
  String? testid2 = '0';
  String? testid3 = '0';
  String? testid4 = '0';
  String? testid5 = '0';
  String? test5 = " ‏الفحص الخامس";
  Future get() async {
    await Methods().getSession(widget.doctorId.toString()).then((value) {
      setState(() {
        session = value;
        isloading = false;
      });
    });
    await Methods().getSick(widget.doctorId.toString()).then((value) {
      setState(() {
        sick = value;
      });
    });
  }

  Future getDrugs() async {
    await DBSql('Drugs').getData('Drugs').then((value) {
      setState(() {
        drugs = value;
        isloading = false;
      });
    });
  }

  void getSql() async {
    await DBSql('ChecksHealth').getData('ChecksHealth').then((value) {
      setState(() {
        checks = value;
        isloading = false;
      });
      // print('checks is ' '$checks');
      if (checks.isEmpty) {
        Methods().getHelthCheckstoSQL().then((value) {
          setState(() {
            checks = value;
            isloading = false;
          });

          for (var i = 0; i < checks.length; i++) {
            DBSql('ChecksHealth').insert({
              'testName': checks[i]['testName'].toString(),
            }).then((value) {
              // print('inserted successfully : ' + value.toString());
            });
          }
          // print(checks);
        });
      }
    });
  }

  @override
  void initState() {
    getDrugs();
    getSql();
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey!,
        title: Text(
          'المراجعين',
          style: tilte2Style,
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       showDialog<String>(
        //         context: context,
        //         builder: (BuildContext ctx) => AlertDialog(
        //           title: const Center(child: Text(' ‏اختر المراجع')),
        //           content: Container(
        //             width: 350,
        //             height: 350,
        //             color: myMac1,
        //             child: CustomSearchableDropDown(
        //               primaryColor: Colors.green,
        //               menuMode: true,
        //               backgroundColor: nb4,
        //               hint: 'write',
        //               labelAlign: TextAlign.right,
        //               menuHeight: 240,
        //               // showClearButton: true,
        //               dropdownBackgroundColor: nb3,
        //               labelStyle: const TextStyle(
        //                   color: Colors.red,
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.bold),
        //               items: sick,
        //               label: 'Select Sick',
        //               prefixIcon: const Padding(
        //                 padding: EdgeInsets.all(0.0),
        //                 child: Icon(Icons.search),
        //               ),
        //               dropDownMenuItems: sick.map((item) {
        //                 return item['name'];
        //               }).toList(),
        //               onChanged: (value) {
        //                 if (value != null) {
        //                   setState(() {
        //                     sickName = value['name'].toString();
        //                     sickID = value['id'].toString();
        //                   });
        //                   Navigator.pop(context);
        //                   Navigator.push(
        //                       context,
        //                       PageTransition(
        //                           type: PageTransitionType.scale,
        //                           alignment: Alignment.bottomCenter,
        //                           child: ClientPageSick(
        //                             sessionId: value['id'].toString(),
        //                             index: 1,
        //                             session: value[0],
        //                             sickName: value['name'].toString(),
        //                             sickID: value['id'].toString(),
        //                             doctorID: widget.doctorId.toString(),
        //                             doctorName: widget.doctorName.toString(),
        //                             phone: value['telphone'].toString(),
        //                           )));
        //                   // Navigator.pop(context);
        //                 } else {
        //                   sickName = null;
        //                 }
        //                 // Navigator.pop(context);
        //               },
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 8),
        //       child: Row(
        //         children: [
        //           Icon(
        //             Icons.search,
        //             color: nb1,
        //           ),
        //           Text('Search', style: tilte1Style),
        //         ],
        //       ),
        //     ),
        //   )
        // ],

        elevation: 0,
      ),
      backgroundColor: grey!,
      body: Center(
        child: isloading
            ? const CupertinoActivityIndicator()
            : SafeArea(
                child: RefreshIndicator(
                  backgroundColor: gren!.withOpacity(.4),
                  color: d1,
                  strokeWidth: 2,
                  onRefresh: () async {
                    await Methods()
                        .getSession(widget.doctorId.toString())
                        .then((value) {
                      setState(() {
                        session = value;
                        isloading = false;
                      });
                    });
                  },
                  child: Center(
                    child: isloading
                        ? const CupertinoActivityIndicator()
                        : ListView.builder(
                            itemCount: session.length,
                            itemBuilder: (BuildContext context, int index) {
                              var res = session[index];
                              if (session.isEmpty) {
                                return const Card(
                                  child: Text('No any sick yet'),
                                );
                              }
                              return Neomphorm(
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
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container()
                                                // ClientPageSick(
                                                //   sessionId:
                                                //       res['id'].toString(),
                                                //   index: index,
                                                //   session: session,
                                                //   sickName:
                                                //       res['name'].toString(),
                                                //   sickID:
                                                //       res['sick_id'].toString(),
                                                //   doctorID: widget.doctorId
                                                //       .toString(),
                                                //   doctorName: res['clientName']
                                                //       .toString(),
                                                //   phone: res['telphone']
                                                //       .toString(),
                                                // ),
                                              ),
                                            );
                                          },
                                          child: NeomphormDark(
                                            child: Center(
                                              child: Text(
                                                res['name'].toString(),
                                                style: tilte2Style,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            color: d2,
                                            width: .4,
                                          ),
                                        ),
                                        NeomphormDark(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              res['gender'].toString() != 'male'
                                                  ? Image.asset(
                                                      'assets/female.png',
                                                      width: 30,
                                                    )
                                                  : Image.asset(
                                                      'assets/male.png',
                                                      width: 30,
                                                    ),
                                              BubelButton(
                                                color: d1,
                                                width: 60,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      res['age'].toString(),
                                                      style: tilte2Style,
                                                    ),
                                                    Image.asset(
                                                      'assets/age.png',
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          color: d3,
                                          width: .25,
                                        ),
                                        BubelButton(
                                          child: Center(
                                            child: Text(
                                              res['site'].toString(),
                                              textAlign: TextAlign.center,
                                              style: tilte1Style,
                                            ),
                                          ),
                                          color: d3,
                                          width: 80,
                                        ),
                                      ],
                                    ),
                                    NeomphormDark(
                                      color: d1,
                                      width: .9,
                                      child: SizedBox(
                                        height: 70,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            session[index]['temp'].toString() ==
                                                    ''
                                                ? const SizedBox()
                                                : SizedBox(
                                                    // height: 60,
                                                    child: BubelButton(
                                                      child: Center(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(session[index]
                                                                  ['temp']
                                                              .toString()),
                                                          Image.asset(
                                                            'assets/thermometer.png',
                                                            width: 30,
                                                          ),
                                                        ],
                                                      )),
                                                      width: 50,
                                                      color: news2,
                                                    ),
                                                  ),
                                            session[index]['suger']
                                                        .toString() ==
                                                    ''
                                                ? const SizedBox()
                                                : SizedBox(
                                                    // height: 60,
                                                    child: BubelButton(
                                                      child: Center(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(session[index]
                                                                  ['suger']
                                                              .toString()),
                                                          Image.asset(
                                                            'assets/sugar-bowl.png',
                                                            width: 25,
                                                          ),
                                                        ],
                                                      )),
                                                      width: 80,
                                                      color: Colors.white
                                                          .withOpacity(.3),
                                                    ),
                                                  ),
                                            session[index]['press']
                                                        .toString() ==
                                                    ''
                                                ? const SizedBox()
                                                : SizedBox(
                                                    // height: 60,
                                                    child: BubelButton(
                                                      child: Center(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(session[index]
                                                                  ['press']
                                                              .toString()),
                                                          Image.asset(
                                                            'assets/blood-pressure.png',
                                                            width: 22,
                                                          )
                                                        ],
                                                      )),
                                                      width: 80,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                            session[index]['weight']
                                                        .toString() ==
                                                    ''
                                                ? const SizedBox()
                                                : SizedBox(
                                                    // height: 60,
                                                    child: BubelButton(
                                                      child: Center(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(session[index]
                                                                  ['weight']
                                                              .toString()),
                                                          Image.asset(
                                                            'assets/weight.png',
                                                            width: 25,
                                                          )
                                                        ],
                                                      )),
                                                      width: 40,
                                                      color: nb2,
                                                    ),
                                                  ),
                                            session[index]['tall'].toString() ==
                                                    ''
                                                ? const SizedBox()
                                                : SizedBox(
                                                    // height: 60,
                                                    child: BubelButton(
                                                      child: Center(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(session[index]
                                                                  ['tall']
                                                              .toString()),
                                                          Image.asset(
                                                            'assets/height.png',
                                                            width: 25,
                                                          )
                                                        ],
                                                      )),
                                                      width: 50,
                                                      color: d3,
                                                    ),
                                                  ),
                                            session[index]['pulse']
                                                        .toString() ==
                                                    ''
                                                ? const SizedBox()
                                                : SizedBox(
                                                    // height: 60,
                                                    child: BubelButton(
                                                      child: Center(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(session[index]
                                                                  ['pulse']
                                                              .toString()),
                                                          Image.asset(
                                                            'assets/pulse.png',
                                                            width: 25,
                                                          )
                                                        ],
                                                      )),
                                                      width: 40,
                                                      color: d4,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                width: .94,
                              );
                            },
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}
