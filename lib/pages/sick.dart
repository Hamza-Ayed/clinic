import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/constant/url.dart';
import 'package:doctors/pages/client/sick_session_doctor.dart';
import 'package:doctors/pages/sick_in_clinic/sick_at_secretary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'addaickpage.dart';
import 'clientpagesick.dart';
import 'method.dart';

class SickPage extends StatefulWidget {
  final String doctorID, doctorName, secretaryId;

  const SickPage(
      {Key? key,
      required this.doctorID,
      required this.doctorName,
      required this.secretaryId})
      : super(key: key);

  @override
  _SickPageState createState() => _SickPageState();
}

class _SickPageState extends State<SickPage> {
  String? drugName = "";
  String drugID = "";
  String? sickName = "";
  String sickID = "";

  bool isloading = true;
  List sick = [];

  Future getSick(String doctorID) async {
    var res = await http.post(Uri.parse(url + 'getSick.php'), body: {
      'doctor_id': doctorID.toString(),
    });
    if (res.statusCode == 200) {
      var decod = jsonDecode(res.body);
      // print(decod);
      setState(() {
        isloading = false;
        sick = decod;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSick(widget.doctorID.toString());
  }

  @override
  Widget build(BuildContext context) {
    // if (sick.isEmpty) {
    //   return Scaffold(
    //     appBar: AppBar(),
    //     body: const Center(
    //       child: Text('Its a New Client '),
    //     ),
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () async {
    //         AwesomeDialog(
    //           context: context,
    //           dialogType: DialogType.QUESTION,
    //           animType: AnimType.TOPSLIDE,
    //           title: "الدواء",
    //           desc: 'أدخل الدواء',
    //           width: MediaQuery.of(context).size.width,
    //           dismissOnTouchOutside: false,
    //           btnCancelOnPress: () {},
    //           btnOkOnPress: () async {
    //             // print(widget.doctorID.toString());
    //             await Methods().addSick(name.text, birthDate.toString(),
    //                 telphone.text, widget.doctorID.toString());
    //             setState(() {
    //               getSick(widget.doctorID.toString());
    //             });
    //           },
    //           body: Column(
    //             children: [
    //               TextField(
    //                 decoration:
    //                     const InputDecoration(hintText: 'Write here new Sick'),
    //                 controller: name,
    //               ),
    //               TextButton(
    //                   onPressed: () {
    //                     selectDate(context);
    //                   },
    //                   child: Text(birthDate.toString())),
    //               TextField(
    //                 decoration:
    //                     const InputDecoration(hintText: 'Write here  phone'),
    //                 controller: telphone,
    //                 keyboardType: TextInputType.phone,
    //               ),
    //             ],
    //           ),
    //         ).show();
    //       },
    //       child: const Icon(Icons.add),
    //     ),
    //   );
    // }
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
        actions: [
          widget.secretaryId.toString() != 'doctor'
              ? const SizedBox()
              : InkWell(
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
                              child: Icon(Icons.search),
                            ),
                            dropDownMenuItems: sick.map((item) {
                              return item['name'].toString();
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  sickName = value['name'].toString();
                                  sickID = value['id'].toString();
                                });
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                      child: SickAtSecretary(
                                        doctorId: widget.doctorID.toString(),
                                        sickName: value['name'].toString(),
                                        sickID: value['id'].toString(),
                                        doctorName:
                                            widget.doctorName.toString(),
                                        phone: value['telphone'].toString(),
                                        secretrayId:
                                            widget.secretaryId.toString(),
                                      )),
                                );
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
                          Icons.search,
                          color: nb1,
                        ),
                        Text('Search', style: tilte1Style),
                      ],
                    ),
                  ),
                )
        ],
      ),
      backgroundColor: grey,
      body: SafeArea(
          child: Center(
        child: isloading
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: sick.length,
                itemBuilder: (BuildContext context, int index) {
                  var res = sick[index];
                  // Color? kolor = nb5;
                  return Slidable(
                    key: const ValueKey(0),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {}),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        // const SlidableAction(
                        //   onPressed: null,
                        //   backgroundColor: Color(0xFF21B7CA),
                        //   foregroundColor: Colors.white,
                        //   icon: Icons.share,
                        //   label: 'Share',
                        // ),
                        SlidableAction(
                          onPressed: (context) async {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: const Text('title'),
                                content: const Text('content'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text('cancel'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                  ),
                                  CupertinoDialogAction(
                                      child: const Text('Ok'),
                                      onPressed: () async {
                                        await Methods()
                                            .deleteSick(res['id'].toString());
                                        setState(() {
                                          getSick(widget.doctorID.toString());
                                        });
                                        Navigator.of(context).pop(true);
                                      }),
                                ],
                              ),
                            );
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),

                    // The end action pane is the one at the right or the bottom side.
                    // endActionPane: const ActionPane(
                    // motion: ScrollMotion(),
                    // children: [
                    //   SlidableAction(
                    //     // An action can be bigger than the others.
                    //     flex: 2,
                    //     onPressed: null,
                    //     backgroundColor: Color(0xFF7BC043),
                    //     foregroundColor: Colors.white,
                    //     icon: Icons.archive,
                    //     label: 'Archive',
                    //   ),
                    //   SlidableAction(
                    //     onPressed: null,
                    //     backgroundColor: Color(0xFF0392CF),
                    //     foregroundColor: Colors.white,
                    //     icon: Icons.save,
                    //     label: 'Save',
                    //   ),
                    // ],
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Neomphorm(
                          width: .9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.scale,
                                          alignment: Alignment.bottomCenter,
                                          child: SickAtSecretary(
                                            doctorId:
                                                widget.doctorID.toString(),
                                            sickName: res['name'].toString(),
                                            sickID: res['id'].toString(),
                                            doctorName:
                                                widget.doctorName.toString(),
                                            phone: res['telphone'].toString(),
                                            secretrayId:
                                                widget.secretaryId.toString(),
                                          )));
                                },
                                child: NeomphormDark(
                                  child:
                                      // color: gren!.withOpacity(.4),
                                      Center(
                                    child: Text(
                                      res['name'].toString(),
                                      style: tilte1Style,
                                    ),
                                  ),
                                  width: .5,
                                  color: Colors.green.shade300,
                                ),
                              ),
                              InkWell(
                                onTap: null,
                                child: Container(
                                  color: black!.withOpacity(.2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(res['age'].toString()),
                                      Image.asset(
                                        'assets/age.png',
                                        width: 30,
                                      )
                                    ],
                                  ),
                                  width: MediaQuery.of(context).size.width * .2,
                                ),
                              ),
                              SizedBox(
                                child: IconButton(
                                  onPressed: () async {
                                    // print(res['telphone']);
                                    Methods()
                                        .callPhone(res['telphone'].toString());
                                  },
                                  icon: Icon(
                                    Icons.phone,
                                    color: blue,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * .1,
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          HapticFeedback.mediumImpact();

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSickPage(
                  doctorId: widget.doctorID.toString(),
                ),
              )).then((value) {
            setState(() {
              getSick(widget.doctorID);
            });
          });
        },
        backgroundColor: gren,
        child: const Icon(Icons.add),
      ),
    );
  }
}
