import 'package:doctors/constant/colors.dart';
import 'package:doctors/models/PDF/pdf_api/api_pdf.dart';
import 'package:doctors/models/PDF/pdf_api/df_paragraph_api.dart';
import 'package:doctors/pages/client/sick_session_doctor.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class SickAtSecretary extends StatefulWidget {
  final String doctorId, sickName, sickID, doctorName, phone, secretrayId;

  const SickAtSecretary(
      {Key? key,
      required this.doctorId,
      required this.sickName,
      required this.sickID,
      required this.doctorName,
      required this.phone,
      required this.secretrayId})
      : super(key: key);
  @override
  _SickAtSecretaryState createState() => _SickAtSecretaryState();
}

class _SickAtSecretaryState extends State<SickAtSecretary> {
  List clinte = [];
  List session = [];
  String? sickName = "";
  String today = '';
  DateTime selectedStartDate = DateTime.now();
  String? stratSession = DateTime.now().toString();
  String sickID = "";
  bool isloading = true;
  String? ilacId1 = '0';
  String? ilacIName1 = 'ilac1';
  String? ilacId2 = '0';
  String? ilacIName2 = 'ilac2';
  String? ilacId3 = '0';
  String? ilacIName3 = 'ilac3';
  String? ilacId4 = '0';
  String? ilacIName4 = 'ilac4';
  var date;
  String? ilacId5 = '0';
  String? ilacIName5 = 'ilac5';
  TextEditingController tempreture = TextEditingController();
  TextEditingController suger = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController pressur = TextEditingController();
  TextEditingController pulse = TextEditingController();
  TextEditingController tall = TextEditingController();

  void get() async {
    await Methods().getClients(widget.sickID.toString()).then((value) {
      setState(() {
        clinte = value;
        isloading = false;
      });
    });
    print(clinte);
  }

  @override
  void initState() {
    get();
    DateTime datetime = DateTime.parse(DateTime.now().toString());
    var outputFormat = DateFormat('dd-MM-yyyy');
    date = outputFormat.format(datetime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sickName,
          style: tilte2Style,
        ),
        elevation: 0,
        backgroundColor: grey,
      ),
      backgroundColor: grey,
      body: Center(
        child: isloading
            ? const CupertinoActivityIndicator()
            : ListView(
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: clinte.length,
                      itemBuilder: (BuildContext context, int index) {
                        var res = clinte[index];
                        DateTime datetime =
                            DateTime.parse(res['date'].toString());
                        var outputFormat =
                            DateFormat('dd/MM/yyyy       hh:mm a');
                        var date = outputFormat.format(datetime);

                        return InkWell(
                            onTap: () async {},
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: NeomphormDark(
                                color: news3,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        NeomphormDark(
                                          color: nb2.withOpacity(.7),
                                          width: .44,
                                          child: Text(
                                            date,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'NizarBBCKurdish'),
                                          ),
                                        ),
                                        NeomphormDark(
                                            width: .3,
                                            color: grey!,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                NeomphormDark(
                                                    width: .15,
                                                    color: grey!,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Image.asset(
                                                          'assets/age.png',
                                                          width: 20,
                                                        ),
                                                        Text(
                                                            res['age']
                                                                .toString(),
                                                            style: tilte1Style),
                                                      ],
                                                    )),
                                                InkWell(
                                                  onTap: () async {
                                                    // print('dd');
                                                    await Methods()
                                                        .sendWhatssApp(
                                                      widget.phone,
                                                      """
                    ‏طبيعة الحالة  ${res['status'].toString()} /\n   ‏درجة الحرارة ${tempreture.text}   \n
                  
                  1 ${res['ilac_id'].toString() == ' ‏العلاج الأول' ? '' : ilacIName1.toString()} \n
                  2 ${res['ilac_id2'].toString() == ' ‏العلاج الثاني' ? '' : ilacIName2.toString()} \n
                  3 ${res['ilac_id3'].toString() == ' ‏العلاج الثالث' ? '' : ilacIName3.toString()} \n
                  4 ${res['ilac_id4'].toString() == 'العلاج الرابع' ? '' : ilacIName4.toString()} \n
                  5 ${res['ilac_id5'].toString() == ' ‏العلاج الخامس' ? '' : ilacIName5.toString()} \n
                  ${date.toString()}
                  """,
                                                    );
                                                  },
                                                  child: FaIcon(
                                                    FontAwesomeIcons.whatsapp,
                                                    color: gren!,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        IconButton(
                                          onPressed: () async {
                                            final pdfFile =
                                                await PdfParagraphApi.generate(
                                              res['name'].toString(),
                                              date,
                                              widget.doctorName.toString(),
                                              res['ilac_id'].toString() ==
                                                      ' ‏العلاج الأول'
                                                  ? ''
                                                  : res['ilac_id'].toString(),
                                              res['ilac_id2'].toString() ==
                                                      ' ‏العلاج الثاني'
                                                  ? ''
                                                  : res['ilac_id2'].toString(),
                                              res['ilac_id3'].toString() ==
                                                      ' ‏العلاج الثالث'
                                                  ? ''
                                                  : res['ilac_id3'].toString(),
                                              res['ilac_id4'].toString() ==
                                                      ' ‏العلاج الرابع'
                                                  ? ''
                                                  : res['ilac_id4'].toString(),
                                              res['ilac_id5'].toString() ==
                                                      ' ‏العلاج الخامس'
                                                  ? ''
                                                  : res['ilac_id5'].toString(),
                                              res['status'].toString(),
                                              res['tempreture'].toString(),
                                              res['age'].toString(),
                                              res['test1'] == ' ‏الفحص الأول'
                                                  ? ''
                                                  : res['test1'].toString(),
                                              res['test2'] == ' ‏الفحص الثاني'
                                                  ? ''
                                                  : res['test2'].toString(),
                                              res['test3'] == ' ‏الفحص الثالث'
                                                  ? ''
                                                  : res['test3'].toString(),
                                              res['test4'] == ' ‏الفحص الرابع'
                                                  ? ''
                                                  : res['test4'].toString(),
                                              res['test5'] == ' ‏الفحص الخامس'
                                                  ? ''
                                                  : res['test5'].toString(),
                                              res['mydrug1'] == '‏عيادة 1'
                                                  ? ''
                                                  : res['mydrug1'].toString(),
                                              res['mydrug2'] == '‏عيادة 2'
                                                  ? ''
                                                  : res['mydrug2'].toString(),
                                              res['mydrug3'] == '‏عيادة 3'
                                                  ? ''
                                                  : res['mydrug3'].toString(),
                                              res['mydrug4'] == '‏عيادة 4'
                                                  ? ''
                                                  : res['mydrug4'].toString(),
                                              res['mydrug5'] == '‏عيادة 5'
                                                  ? ''
                                                  : res['mydrug5'].toString(),
                                            );

                                            PdfApi.openFile(pdfFile);
                                          },
                                          icon: Icon(
                                            Icons.print,
                                            color: news2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          BubelButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .86,
                                            color: Colors.white.withOpacity(.4),
                                            child: Center(
                                              child: Text(
                                                res['status'].toString(),
                                                style: tilte1Style,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    NeomphormDark(
                                      color: news3,
                                      width: .9,
                                      child: SizedBox(
                                        height: 70,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            res['tempreture'].toString() == '0'
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
                                                          Text(res['tempreture']
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
                                            res['suger'].toString() == ''
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
                                                          Text(res['suger']
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
                                            res['prussre'].toString() == ''
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
                                                          Text(res['prussre']
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
                                            res['weight'].toString() == ''
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
                                                          Text(res['weight']
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
                                            res['tall'].toString() == ''
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
                                                          Text(res['tall']
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
                                            res['pulse'].toString() == ''
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
                                                          Text(res['pulse']
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

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Column(
                                        //   children: [

                                        //   ],
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: BubelButton(
                                            color: d3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .86,
                                            child: Column(
                                              children: [
                                                Text(
                                                  res['ilac_id'].toString(),
                                                  style: tilteStyle,
                                                ),
                                                Text(
                                                  res['ilac_id2'].toString(),
                                                  style: tilteStyle,
                                                ),
                                                Text(
                                                  res['ilac_id3'].toString(),
                                                  style: tilteStyle,
                                                ),
                                                Text(
                                                  res['ilac_id4'].toString(),
                                                  style: tilteStyle,
                                                ),
                                                Text(
                                                  res['ilac_id5'].toString(),
                                                  style: tilteStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Image.memory(
                                        //   base64Decode(imageINByte!),
                                        //   width: 50,
                                        //   height: 50,
                                        // )
                                      ],
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     // print(res['image']);
                                    //   },
                                    //   child: Builder(
                                    //       builder: (BuildContext context) {
                                    //     try {
                                    //       return Image.memory(imagebyte,
                                    //           fit: BoxFit.cover);
                                    //     } catch (e) {
                                    //       print(
                                    //           "Got exception ${e.toString()}");
                                    //       return Image.asset(
                                    //           "assets/defimg.jpg",
                                    //           fit: BoxFit.contain);
                                    //     }
                                    //   }),
                                    // )
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                  NeomphormDark(
                      width: .95,
                      child: SizedBox(
                        // height: 100,
                        child: Column(
                          children: [
                            Text(
                              '  ‏الفحص الأولى ',
                              style: tilte2Style,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  color: Colors.white.withOpacity(.3),
                                  width: 100,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: tempreture,
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                          'assets/thermometer.png',
                                          width: 10,
                                          height: 10,
                                        ),
                                        // hintText: 'درجه الحراره',
                                      ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white.withOpacity(.3),
                                  width: 100,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: suger,
                                      decoration: InputDecoration(
                                        // hintText: ' ‏قياس السكري',
                                        prefixIcon: Image.asset(
                                          'assets/sugar-bowl.png',
                                          width: 10,
                                          height: 10,
                                        ),
                                      ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white.withOpacity(.3),
                                  width: 100,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: pressur,
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                          'assets/blood-pressure.png',
                                          width: 10,
                                          height: 10,
                                        ),
                                      ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.white.withOpacity(.3),
                                      width: 100,
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: weight,
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                              'assets/weight.png',
                                              width: 10,
                                              height: 10,
                                            ),
                                          ),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white.withOpacity(.3),
                                      width: 100,
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: tall,
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                              'assets/height.png',
                                              width: 10,
                                              height: 10,
                                            ),
                                          ),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white.withOpacity(.3),
                                      width: 100,
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: pulse,
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                              'assets/pulse.png',
                                              width: 10,
                                              height: 10,
                                            ),
                                          ),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: d2),
                  const SizedBox(
                    height: 10,
                  ),
                  session.isEmpty
                      ? const SizedBox(
                          height: 0,
                        )
                      : InkWell(
                          onTap: () => widget.secretrayId.toString() == 'doctor'
                              ? Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                      child: SickSessionDoctor(
                                          doctorId: widget.doctorId,
                                          doctorName: widget.doctorName)),
                                )
                              : print('I m Secretary'),
                          child: NeomphormDark(
                            color: d1,
                            width: .97,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                session[0]['temp'] == ''
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 60,
                                        child: BubelButton(
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(session[0]['temp']),
                                              Image.asset(
                                                'assets/thermometer.png',
                                                width: 30,
                                              ),
                                            ],
                                          )),
                                          width: 40,
                                          color: news2,
                                        ),
                                      ),
                                session[0]['suger'] == ''
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 60,
                                        child: BubelButton(
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(session[0]['suger']),
                                              Image.asset(
                                                'assets/sugar-bowl.png',
                                                width: 25,
                                              ),
                                            ],
                                          )),
                                          width: 90,
                                          color: Colors.white.withOpacity(.3),
                                        ),
                                      ),
                                session[0]['press'] == ''
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 60,
                                        child: BubelButton(
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(session[0]['press']),
                                              Image.asset(
                                                'assets/blood-pressure.png',
                                                width: 22,
                                              )
                                            ],
                                          )),
                                          width: 90,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                session[0]['weight'] == ''
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 60,
                                        child: BubelButton(
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(session[0]['weight']),
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
                                session[0]['tall'] == ''
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 60,
                                        child: BubelButton(
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(session[0]['tall']),
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
                                session[0]['pulse'] == ''
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 60,
                                        child: BubelButton(
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(session[0]['pulse']),
                                              Image.asset(
                                                'assets/pulse.png',
                                                width: 25,
                                              )
                                            ],
                                          )),
                                          width: 50,
                                          color: d4,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      await Methods().insertSessionSecretary(
                          widget.secretrayId.toString(),
                          DateTime.now().toString(),
                          widget.doctorId.toString(),
                          tempreture.text.toString(),
                          suger.text,
                          weight.text,
                          pressur.text,
                          tall.text,
                          pulse.text,
                          widget.sickID.toString());

                      await Methods().getSession(widget.doctorId).then((value) {
                        setState(() {
                          // print(value);
                          session = value;
                          // value[0] = session;
                          // print(session);
                        });
                      });
                    },
                    child: BubelButton(
                        width: 180,
                        color: grey!,
                        child: Center(
                            child: Text(
                          '‏أدخل  ‏الفحص',
                          style: tilte2Style,
                        ))),
                  )
                ],
              ),
        // ),
      ),
    );
  }
}
