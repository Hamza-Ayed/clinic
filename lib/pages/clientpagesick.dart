// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:doctors/db/db.dart';
// import 'package:doctors/models/PDF/pdf_api/api_pdf.dart';
// import 'package:doctors/models/PDF/pdf_api/df_paragraph_api.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
// import 'package:doctors/constant/colors.dart';
// import 'package:doctors/constant/url.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// // import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// import 'method.dart';

// class ClientPageSick extends StatefulWidget {
//   final String sickName, sickID, doctorID, doctorName, phone, sessionId;
//   final int index;
//   final List session;
//   const ClientPageSick(
//       {Key? key,
//       required this.sickName,
//       required this.sickID,
//       required this.doctorID,
//       required this.doctorName,
//       required this.phone,
//       required this.session,
//       required this.index,
//       required this.sessionId})
//       : super(key: key);
//   @override
//   _ClientPageSickState createState() => _ClientPageSickState();
// }

// class _ClientPageSickState extends State<ClientPageSick> {
//   // FirebaseStorage storage = FirebaseStorage.instance;

//   TextEditingController status = TextEditingController();
//   TextEditingController imageName = TextEditingController();
//   TextEditingController tempreture = TextEditingController();
//   String? ilacId1 = '0';
//   String? ilacIName1 = ' ‏العلاج الأول';
//   String? ilacId2 = '0';
//   String? ilacIName2 = ' ‏العلاج الثاني';
//   String? ilacId3 = '0';
//   String? ilacIName3 = ' ‏العلاج الثالث';
//   String? ilacId4 = '0';
//   String? ilacIName4 = ' ‏العلاج الرابع';
//   String? ilacId5 = '0';
//   String? ilacIName5 = ' ‏العلاج الخامس';
//   String? test1 = ' ‏الفحص الأول';
//   String? test2 = ' ‏الفحص الثاني';
//   String? test3 = ' ‏الفحص الثالث';
//   String? test4 = ' ‏الفحص الرابع';
//   String? testid1 = '0';
//   String? testid2 = '0';
//   String? testid3 = '0';
//   String? testid4 = '0';
//   String? testid5 = '0';
//   String? test5 = " ‏الفحص الخامس";
//   String? myIlac1Name = '‏عيادة 1';
//   String? myIlac2Name = '‏عيادة 2';
//   String? myIlac3Name = '‏عيادة 3';
//   String? myIlac4Name = '‏عيادة 4';
//   String? myIlac5Name = '‏عيادة 5';
//   String? myIlacID1 = '0';
//   String? myIlacID2 = '0';
//   String? myIlacID3 = '0';
//   String? myIlacID4 = '0';
//   String? myIlacID5 = '0';
//   bool isloading = true;
//   bool isseen = false;
//   bool isCheck = false;
//   bool ismyDrug = false;
//   List drugs = [];
//   List mydrugs = [];
//   List tests = [];
//   List clients = [];
//   List session = [];
//   File? _image;
//   String? imageINByte = 'mom';
//   List checks = [];
//   Uint8List? img;
//   // final picker = ImagePicker();

//   // Future choosImagr(ImageSource source) async {
//   //   if (Platform.isWindows || Platform.isMacOS) {
//   //     FilePickerResult? result = await FilePicker.platform.pickFiles();

//   //     if (result != null) {
//   //       PlatformFile file = result.files.single;
//   //       setState(() {
//   //         _image = File(file.path.toString());
//   //         // imageINByte = base64Encode(_image!.readAsBytesSync());
//   //         imageINByte = encodImage(_image!.readAsBytesSync());
//   //         // print(imageINByte);
//   //       });
//   //       // print(file.name);
//   //       // print(file.size);
//   //       // print(file.extension);
//   //       // print(file.path);
//   //       return imageINByte;
//   //     } else {
//   //       // User canceled the picker
//   //     }
//   //   } else {
//   //     var pickedImage = await picker.pickImage(source: source);
//   //     setState(() {
//   //       _image = File(pickedImage!.path);
//   //       // imageINByte = base64Encode(_image!.readAsBytesSync());
//   //       imageINByte = encodImage(_image!.readAsBytesSync());
//   //       // print(imageINByte);
//   //       // String fileName = basename(_image!.path);
//   //     });
//   //   }
//   // }

//   encodImage(Uint8List image) {
//     return base64Encode(image);
//   }

//   decodImage(String image) {
//     return base64Decode(image);
//   }

//   Future getDrugs() async {
//     await DBSql('Drugs').getData('Drugs').then((value) {
//       setState(() {
//         drugs = value;
//         isloading = false;
//       });
//     });
//     await Methods().getDrugsClient(widget.doctorID.toString()).then((value) {
//       setState(() {
//         mydrugs = value;
//       });
//       print(mydrugs);
//     });
//   }

//   void getSql() async {
//     await DBSql('ChecksHealth').getData('ChecksHealth').then((value) {
//       setState(() {
//         checks = value;
//         isloading = false;
//       });
//       // print('checks is ' '$checks');
//       if (checks.isEmpty) {
//         Methods().getHelthCheckstoSQL().then((value) {
//           setState(() {
//             checks = value;
//             isloading = false;
//           });

//           for (var i = 0; i < checks.length; i++) {
//             DBSql('ChecksHealth').insert({
//               'testName': checks[i]['testName'].toString(),
//             }).then((value) {
//               // print('inserted successfully : ' + value.toString());
//             });
//           }
//           // print(checks);
//         });
//       }
//     });
//   }

//   Future getClients() async {
//     var res = await http.post(Uri.parse(url + 'getClient.php'), body: {
//       // 'action': 'getClient',
//       'id': widget.sickID.toString(),
//     });
//     if (res.statusCode == 200) {
//       setState(() {
//         isloading = false;
//         clients = jsonDecode(res.body);
//       });
//       print(clients);
//     }
//   }

//   @override
//   void initState() {
//     getDrugs();
//     getClients();
//     getSql();
//     // print(widget.session);
//     session = widget.session;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: grey,
//         elevation: 0,
//         title: Text(
//           widget.sickName,
//           style: TextStyle(
//               fontSize: 20, fontFamily: 'NizarBBCKurdish', color: nb1),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: nb1,
//           ),
//           onPressed: () => Navigator.pop(
//             context,
//           ),
//         ),
//       ),
//       backgroundColor: grey,
//       body: SafeArea(
//         child: RefreshIndicator(
//           backgroundColor: gren,
//           color: d4,
//           strokeWidth: 4,
//           onRefresh: () async {
//             // print('d');
//             await Methods()
//                 .getSession(widget.doctorID.toString())
//                 .then((value) {
//               setState(() {
//                 session = value;
//                 isloading = false;
//               });
//             });
//           },
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(
//                     height: 320,
//                     child: Center(
//                       child: isloading
//                           ? LinearProgressIndicator(
//                               backgroundColor: ikea,
//                               color: ikea1,
//                             )
//                           : ListView.builder(
//                               // scrollDirection: Axis.horizontal,
//                               shrinkWrap: true,
//                               itemCount: clients.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 var res = clients[index];
//                                 DateTime datetime =
//                                     DateTime.parse(res['date'].toString());
//                                 var outputFormat =
//                                     DateFormat('dd/MM/yyyy       hh:mm a');
//                                 var date = outputFormat.format(datetime);
//                                 // Uint8List imagebyte =
//                                 //     base64Decode(res['image'].toString());
//                                 // Uint8List imagebyte =
//                                 //     base64Decode(res['image'].toString());
//                                 return Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: NeomphormDark(
//                                     color: news3,
//                                     width: MediaQuery.of(context).size.width,
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             NeomphormDark(
//                                               color: nb2.withOpacity(.7),
//                                               width: .44,
//                                               child: Text(
//                                                 date,
//                                                 style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontFamily:
//                                                         'NizarBBCKurdish'),
//                                               ),
//                                             ),
//                                             NeomphormDark(
//                                                 width: .3,
//                                                 color: grey!,
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     NeomphormDark(
//                                                         width: .15,
//                                                         color: grey!,
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             Image.asset(
//                                                               'assets/age.png',
//                                                               width: 20,
//                                                             ),
//                                                             Text(
//                                                                 res['age']
//                                                                     .toString(),
//                                                                 style:
//                                                                     tilte1Style),
//                                                           ],
//                                                         )),
//                                                     InkWell(
//                                                       onTap: () async {
//                                                         // print('dd');

//                                                         await Methods()
//                                                             .sendWhatssApp(
//                                                           widget.phone,
//                                                           """
//                                                           ‏طبيعة الحالة  ${status.text} /\n
//                                                           ‏درجة الحرارة ${tempreture.text}   \n

//                                                         1 ${ilacIName1 == 'ilac1' ? '' : ilacIName1.toString()} \n
//                                                         2 ${ilacIName2 == 'ilac2' ? '' : ilacIName2.toString()} \n
//                                                         3 ${ilacIName3 == 'ilac3' ? '' : ilacIName3.toString()} \n
//                                                         4 ${ilacIName4 == 'ilac4' ? '' : ilacIName4.toString()} \n
//                                                         5 ${ilacIName5 == 'ilac5' ? '' : ilacIName5.toString()} \n
//                                                         ${date.toString()}
//                                                         """,
//                                                         );
//                                                       },
//                                                       child: FaIcon(
//                                                         FontAwesomeIcons
//                                                             .whatsapp,
//                                                         color: gren!,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )),
//                                             IconButton(
//                                               onPressed: () async {
//                                                 final pdfFile =
//                                                     await PdfParagraphApi
//                                                         .generate(
//                                                   res['name'].toString(),
//                                                   date,
//                                                   widget.doctorName.toString(),
//                                                   res['ilac_id'].toString() ==
//                                                           ' ‏العلاج الأول'
//                                                       ? ''
//                                                       : res['ilac_id']
//                                                           .toString(),
//                                                   res['ilac_id2'].toString() ==
//                                                           ' ‏العلاج الثاني'
//                                                       ? ''
//                                                       : res['ilac_id2']
//                                                           .toString(),
//                                                   res['ilac_id3'].toString() ==
//                                                           ' ‏العلاج الثالث'
//                                                       ? ''
//                                                       : res['ilac_id3']
//                                                           .toString(),
//                                                   res['ilac_id4'].toString() ==
//                                                           ' ‏العلاج الرابع'
//                                                       ? ''
//                                                       : res['ilac_id4']
//                                                           .toString(),
//                                                   res['ilac_id5'].toString() ==
//                                                           ' ‏العلاج الخامس'
//                                                       ? ''
//                                                       : res['ilac_id5']
//                                                           .toString(),
//                                                   res['status'].toString(),
//                                                   res['tempreture'].toString(),
//                                                   res['age'].toString(),
//                                                   res['test1'] ==
//                                                           ' ‏الفحص الأول'
//                                                       ? ''
//                                                       : res['test1'].toString(),
//                                                   res['test2'] ==
//                                                           ' ‏الفحص الثاني'
//                                                       ? ''
//                                                       : res['test2'].toString(),
//                                                   res['test3'] ==
//                                                           ' ‏الفحص الثالث'
//                                                       ? ''
//                                                       : res['test3'].toString(),
//                                                   res['test4'] ==
//                                                           ' ‏الفحص الرابع'
//                                                       ? ''
//                                                       : res['test4'].toString(),
//                                                   res['test5'] ==
//                                                           ' ‏الفحص الخامس'
//                                                       ? ''
//                                                       : res['test5'].toString(),
//                                                   res['mydrug1'] == '‏عيادة 1'
//                                                       ? ''
//                                                       : res['mydrug1']
//                                                           .toString(),
//                                                   res['mydrug2'] == '‏عيادة 2'
//                                                       ? ''
//                                                       : res['mydrug2']
//                                                           .toString(),
//                                                   res['mydrug3'] == '‏عيادة 3'
//                                                       ? ''
//                                                       : res['mydrug3']
//                                                           .toString(),
//                                                   res['mydrug4'] == '‏عيادة 4'
//                                                       ? ''
//                                                       : res['mydrug4']
//                                                           .toString(),
//                                                   res['mydrug5'] == '‏عيادة 5'
//                                                       ? ''
//                                                       : res['mydrug5']
//                                                           .toString(),
//                                                 );
//                                                 await Methods().shareFile(
//                                                   widget.phone,
//                                                   status.text,
//                                                   pdfFile.path.toString(),
//                                                 );
//                                                 PdfApi.openFile(pdfFile);
//                                                 // Share();
//                                                 // await Methods()
//                                                 //     .sendWhatssAppFile(
//                                                 //         widget.phone, pdfFile);
//                                               },
//                                               icon: Icon(
//                                                 Icons.print,
//                                                 color: news2,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             children: [
//                                               BubelButton(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .86,
//                                                 color: Colors.white
//                                                     .withOpacity(.4),
//                                                 child: Center(
//                                                   child: Text(
//                                                     res['status'].toString(),
//                                                     style: tilte1Style,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         NeomphormDark(
//                                           color: news3,
//                                           width: .9,
//                                           child: SizedBox(
//                                             height: 70,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 res['tempreture'].toString() ==
//                                                         '0'
//                                                     ? const SizedBox()
//                                                     : SizedBox(
//                                                         // height: 60,
//                                                         child: BubelButton(
//                                                           child: Center(
//                                                               child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceEvenly,
//                                                             children: [
//                                                               Text(res[
//                                                                       'tempreture']
//                                                                   .toString()),
//                                                               Image.asset(
//                                                                 'assets/thermometer.png',
//                                                                 width: 30,
//                                                               ),
//                                                             ],
//                                                           )),
//                                                           width: 50,
//                                                           color: news2,
//                                                         ),
//                                                       ),
//                                                 res['suger'].toString() == ''
//                                                     ? const SizedBox()
//                                                     : SizedBox(
//                                                         // height: 60,
//                                                         child: BubelButton(
//                                                           child: Center(
//                                                               child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceEvenly,
//                                                             children: [
//                                                               Text(res['suger']
//                                                                   .toString()),
//                                                               Image.asset(
//                                                                 'assets/sugar-bowl.png',
//                                                                 width: 25,
//                                                               ),
//                                                             ],
//                                                           )),
//                                                           width: 80,
//                                                           color: Colors.white
//                                                               .withOpacity(.3),
//                                                         ),
//                                                       ),
//                                                 res['prussre'].toString() == ''
//                                                     ? const SizedBox()
//                                                     : SizedBox(
//                                                         // height: 60,
//                                                         child: BubelButton(
//                                                           child: Center(
//                                                               child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceEvenly,
//                                                             children: [
//                                                               Text(res[
//                                                                       'prussre']
//                                                                   .toString()),
//                                                               Image.asset(
//                                                                 'assets/blood-pressure.png',
//                                                                 width: 22,
//                                                               )
//                                                             ],
//                                                           )),
//                                                           width: 80,
//                                                           color:
//                                                               Colors.redAccent,
//                                                         ),
//                                                       ),
//                                                 res['weight'].toString() == ''
//                                                     ? const SizedBox()
//                                                     : SizedBox(
//                                                         // height: 60,
//                                                         child: BubelButton(
//                                                           child: Center(
//                                                               child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceEvenly,
//                                                             children: [
//                                                               Text(res['weight']
//                                                                   .toString()),
//                                                               Image.asset(
//                                                                 'assets/weight.png',
//                                                                 width: 25,
//                                                               )
//                                                             ],
//                                                           )),
//                                                           width: 40,
//                                                           color: nb2,
//                                                         ),
//                                                       ),
//                                                 res['tall'].toString() == ''
//                                                     ? const SizedBox()
//                                                     : SizedBox(
//                                                         // height: 60,
//                                                         child: BubelButton(
//                                                           child: Center(
//                                                               child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceEvenly,
//                                                             children: [
//                                                               Text(res['tall']
//                                                                   .toString()),
//                                                               Image.asset(
//                                                                 'assets/height.png',
//                                                                 width: 25,
//                                                               )
//                                                             ],
//                                                           )),
//                                                           width: 50,
//                                                           color: d3,
//                                                         ),
//                                                       ),
//                                                 res['pulse'].toString() == ''
//                                                     ? const SizedBox()
//                                                     : SizedBox(
//                                                         // height: 60,
//                                                         child: BubelButton(
//                                                           child: Center(
//                                                               child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceEvenly,
//                                                             children: [
//                                                               Text(res['pulse']
//                                                                   .toString()),
//                                                               Image.asset(
//                                                                 'assets/pulse.png',
//                                                                 width: 25,
//                                                               )
//                                                             ],
//                                                           )),
//                                                           width: 40,
//                                                           color: d4,
//                                                         ),
//                                                       ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),

//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: BubelButton(
//                                             color: d1,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 .86,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Column(
//                                                   children: [
//                                                     IconButton(
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           ismyDrug = true;
//                                                         });
//                                                       },
//                                                       icon: const Icon(
//                                                           Icons.arrow_back_ios),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           ismyDrug = false;
//                                                         });
//                                                       },
//                                                       icon: const Icon(
//                                                         Icons.arrow_forward_ios,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Center(
//                                                   child: ismyDrug
//                                                       ? Column(
//                                                           children: [
//                                                             Text(
//                                                               res['mydrug1']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                             Text(
//                                                               res['mydrug2']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                             Text(
//                                                               res['mydrug3']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                             Text(
//                                                               res['mydrug4']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                             Text(
//                                                               res['mydrug5']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             )
//                                                           ],
//                                                         )
//                                                       : Column(
//                                                           children: [
//                                                             Text(
//                                                               res['ilac_id']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                             Text(
//                                                               res['ilac_id2']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                             Text(
//                                                               res['ilac_id3']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                             Text(
//                                                               res['ilac_id4']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                             Text(
//                                                               res['ilac_id5']
//                                                                   .toString(),
//                                                               style: tilteStyle,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         // IlacCard()
//                                         // InkWell(
//                                         //   onTap: () {
//                                         //     // print(res['image']);
//                                         //   },
//                                         //   child: Builder(
//                                         //       builder: (BuildContext context) {
//                                         //     try {
//                                         //       return Image.memory(imagebyte,
//                                         //           fit: BoxFit.cover);
//                                         //     } catch (e) {
//                                         //       print(
//                                         //           "Got exception ${e.toString()}");
//                                         //       return Image.asset(
//                                         //           "assets/defimg.jpg",
//                                         //           fit: BoxFit.contain);
//                                         //     }
//                                         //   }),
//                                         // )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//                   ),

//                   isseen == false
//                       ? NeomphormDark(
//                           color: d1,
//                           width: .9,
//                           child: SizedBox(
//                             height: 70,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 session[widget.index]['temp'].toString() == ''
//                                     ? const SizedBox()
//                                     : SizedBox(
//                                         // height: 60,
//                                         child: BubelButton(
//                                           child: Center(
//                                               child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(session[widget.index]['temp']
//                                                   .toString()),
//                                               Image.asset(
//                                                 'assets/thermometer.png',
//                                                 width: 30,
//                                               ),
//                                             ],
//                                           )),
//                                           width: 50,
//                                           color: news2,
//                                         ),
//                                       ),
//                                 session[widget.index]['suger'].toString() == ''
//                                     ? const SizedBox()
//                                     : SizedBox(
//                                         // height: 60,
//                                         child: BubelButton(
//                                           child: Center(
//                                               child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(session[widget.index]
//                                                       ['suger']
//                                                   .toString()),
//                                               Image.asset(
//                                                 'assets/sugar-bowl.png',
//                                                 width: 25,
//                                               ),
//                                             ],
//                                           )),
//                                           width: 80,
//                                           color: Colors.white.withOpacity(.3),
//                                         ),
//                                       ),
//                                 session[widget.index]['press'].toString() == ''
//                                     ? const SizedBox()
//                                     : SizedBox(
//                                         // height: 60,
//                                         child: BubelButton(
//                                           child: Center(
//                                               child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(session[widget.index]
//                                                       ['press']
//                                                   .toString()),
//                                               Image.asset(
//                                                 'assets/blood-pressure.png',
//                                                 width: 22,
//                                               )
//                                             ],
//                                           )),
//                                           width: 80,
//                                           color: Colors.redAccent,
//                                         ),
//                                       ),
//                                 session[widget.index]['weight'].toString() == ''
//                                     ? const SizedBox()
//                                     : SizedBox(
//                                         // height: 60,
//                                         child: BubelButton(
//                                           child: Center(
//                                               child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(session[widget.index]
//                                                       ['weight']
//                                                   .toString()),
//                                               Image.asset(
//                                                 'assets/weight.png',
//                                                 width: 25,
//                                               )
//                                             ],
//                                           )),
//                                           width: 40,
//                                           color: nb2,
//                                         ),
//                                       ),
//                                 session[widget.index]['tall'].toString() == ''
//                                     ? const SizedBox()
//                                     : SizedBox(
//                                         // height: 60,
//                                         child: BubelButton(
//                                           child: Center(
//                                               child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(session[widget.index]['tall']
//                                                   .toString()),
//                                               Image.asset(
//                                                 'assets/height.png',
//                                                 width: 25,
//                                               )
//                                             ],
//                                           )),
//                                           width: 50,
//                                           color: d3,
//                                         ),
//                                       ),
//                                 session[widget.index]['pulse'].toString() == ''
//                                     ? const SizedBox()
//                                     : SizedBox(
//                                         // height: 60,
//                                         child: BubelButton(
//                                           child: Center(
//                                               child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               Text(session[widget.index]
//                                                       ['pulse']
//                                                   .toString()),
//                                               Image.asset(
//                                                 'assets/pulse.png',
//                                                 width: 25,
//                                               )
//                                             ],
//                                           )),
//                                           width: 40,
//                                           color: d4,
//                                         ),
//                                       ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : const SizedBox(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 6),
//                     child: NeomphormDark(
//                       width: .8,
//                       color: Colors.brown.shade100,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 6),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 InkWell(
//                                   onTap: () => setState(() {
//                                     isCheck = false;
//                                   }),
//                                   child: Neomphorm(
//                                     width: .3,
//                                     child: Text(
//                                       '‏أدخل الأدوية',
//                                       style: tilte1Style,
//                                     ),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () => setState(() {
//                                     isCheck = true;
//                                   }),
//                                   child: Neomphorm(
//                                       width: .4,
//                                       child: Text(
//                                         '‏الفحوصات المطلوبة',
//                                         style: tilte1Style,
//                                       )),
//                                 )
//                               ],
//                             ),
//                             isCheck
//                                 ? Container(
//                                     color: d3,
//                                     child: Column(
//                                       children: [
//                                         SizedBox(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               .9,
//                                           child: TextButton(
//                                             onPressed: () async {
//                                               AwesomeDialog(
//                                                 context: context,
//                                                 body: Container(
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       .8,
//                                                   height: 350,
//                                                   color: myMac1,
//                                                   child:
//                                                       CustomSearchableDropDown(
//                                                     primaryColor: Colors.green,
//                                                     menuMode: true,
//                                                     backgroundColor: nb4,
//                                                     hint: 'write',
//                                                     labelAlign: TextAlign.right,
//                                                     menuHeight: 240,
//                                                     // showClearButton: true,
//                                                     dropdownBackgroundColor: d1,
//                                                     labelStyle: const TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     items: checks,
//                                                     label: 'أختر  ‏الفحص الاول',
//                                                     prefixIcon: const Padding(
//                                                       padding:
//                                                           EdgeInsets.all(0.0),
//                                                       child: Icon(Icons.search),
//                                                     ),
//                                                     dropDownMenuItems:
//                                                         checks.map((item) {
//                                                       return item['testName'];
//                                                     }).toList(),
//                                                     onChanged: (value) {
//                                                       if (value != null) {
//                                                         setState(() {
//                                                           test1 =
//                                                               value['testName']
//                                                                   .toString();
//                                                           testid1 = value['id']
//                                                               .toString();
//                                                           // print(test1);
//                                                         });
//                                                       } else {
//                                                         test1 = null;
//                                                       }
//                                                       Navigator.pop(context);
//                                                     },
//                                                   ),
//                                                 ),
//                                               ).show();
//                                             },
//                                             child: NeomphormDark(
//                                               child: Text(
//                                                 test1.toString(),
//                                                 style: tilte1Style,
//                                               ),
//                                               color: grey!,
//                                               width: .8,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               .9,
//                                           child: TextButton(
//                                             onPressed: () async {
//                                               AwesomeDialog(
//                                                 context: context,
//                                                 body: Container(
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       .8,
//                                                   height: 350,
//                                                   color: myMac1,
//                                                   child:
//                                                       CustomSearchableDropDown(
//                                                     primaryColor: Colors.green,
//                                                     menuMode: true,
//                                                     backgroundColor: nb4,
//                                                     hint: 'write',
//                                                     labelAlign: TextAlign.right,
//                                                     menuHeight: 240,
//                                                     // showClearButton: true,
//                                                     dropdownBackgroundColor: d1,
//                                                     labelStyle: const TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     items: checks,
//                                                     label:
//                                                         'أختر  ‏الفحص  ‏الثاني',
//                                                     prefixIcon: const Padding(
//                                                       padding:
//                                                           EdgeInsets.all(0.0),
//                                                       child: Icon(Icons.search),
//                                                     ),
//                                                     dropDownMenuItems:
//                                                         checks.map((item) {
//                                                       return item['testName'];
//                                                     }).toList(),
//                                                     onChanged: (value) {
//                                                       if (value != null) {
//                                                         setState(() {
//                                                           test2 =
//                                                               value['testName']
//                                                                   .toString();
//                                                           testid2 = value['id']
//                                                               .toString();
//                                                           // print(test1);
//                                                         });
//                                                       } else {
//                                                         test2 = null;
//                                                       }
//                                                       Navigator.pop(context);
//                                                     },
//                                                   ),
//                                                 ),
//                                               ).show();
//                                             },
//                                             child: NeomphormDark(
//                                               child: Text(
//                                                 test2.toString(),
//                                                 style: tilte1Style,
//                                               ),
//                                               color: grey!,
//                                               width: .8,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               .9,
//                                           child: TextButton(
//                                             onPressed: () async {
//                                               AwesomeDialog(
//                                                 context: context,
//                                                 body: Container(
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       .8,
//                                                   height: 350,
//                                                   color: myMac1,
//                                                   child:
//                                                       CustomSearchableDropDown(
//                                                     primaryColor: Colors.green,
//                                                     menuMode: true,
//                                                     backgroundColor: nb4,
//                                                     hint: 'write',
//                                                     labelAlign: TextAlign.right,
//                                                     menuHeight: 240,
//                                                     // showClearButton: true,
//                                                     dropdownBackgroundColor: d1,
//                                                     labelStyle: const TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     items: checks,
//                                                     label:
//                                                         'أختر  ‏الفحص  ‏الثالث',
//                                                     prefixIcon: const Padding(
//                                                       padding:
//                                                           EdgeInsets.all(0.0),
//                                                       child: Icon(Icons.search),
//                                                     ),
//                                                     dropDownMenuItems:
//                                                         checks.map((item) {
//                                                       return item['testName'];
//                                                     }).toList(),
//                                                     onChanged: (value) {
//                                                       if (value != null) {
//                                                         setState(() {
//                                                           test3 =
//                                                               value['testName']
//                                                                   .toString();
//                                                           testid3 = value['id']
//                                                               .toString();
//                                                           // print(test1);
//                                                         });
//                                                       } else {
//                                                         test1 = null;
//                                                       }
//                                                       Navigator.pop(context);
//                                                     },
//                                                   ),
//                                                 ),
//                                               ).show();
//                                             },
//                                             child: NeomphormDark(
//                                               child: Text(
//                                                 test3.toString(),
//                                                 style: tilte1Style,
//                                               ),
//                                               color: grey!,
//                                               width: .8,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               .9,
//                                           child: TextButton(
//                                             onPressed: () async {
//                                               AwesomeDialog(
//                                                 context: context,
//                                                 body: Container(
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       .8,
//                                                   height: 350,
//                                                   color: myMac1,
//                                                   child:
//                                                       CustomSearchableDropDown(
//                                                     primaryColor: Colors.green,
//                                                     menuMode: true,
//                                                     backgroundColor: nb4,
//                                                     hint: 'write',
//                                                     labelAlign: TextAlign.right,
//                                                     menuHeight: 240,
//                                                     // showClearButton: true,
//                                                     dropdownBackgroundColor: d1,
//                                                     labelStyle: const TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     items: checks,
//                                                     label:
//                                                         'أختر  ‏الفحص  ‏الرابع',
//                                                     prefixIcon: const Padding(
//                                                       padding:
//                                                           EdgeInsets.all(0.0),
//                                                       child: Icon(Icons.search),
//                                                     ),
//                                                     dropDownMenuItems:
//                                                         checks.map((item) {
//                                                       return item['testName'];
//                                                     }).toList(),
//                                                     onChanged: (value) {
//                                                       if (value != null) {
//                                                         setState(() {
//                                                           test4 =
//                                                               value['testName']
//                                                                   .toString();
//                                                           testid4 = value['id']
//                                                               .toString();
//                                                           // print(test1);
//                                                         });
//                                                       } else {
//                                                         test4 = null;
//                                                       }
//                                                       Navigator.pop(context);
//                                                     },
//                                                   ),
//                                                 ),
//                                               ).show();
//                                             },
//                                             child: NeomphormDark(
//                                               child: Text(
//                                                 test4.toString(),
//                                                 style: tilte1Style,
//                                               ),
//                                               color: grey!,
//                                               width: .8,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               .9,
//                                           child: TextButton(
//                                             onPressed: () async {
//                                               AwesomeDialog(
//                                                 context: context,
//                                                 body: Container(
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       .8,
//                                                   height: 350,
//                                                   color: myMac1,
//                                                   child:
//                                                       CustomSearchableDropDown(
//                                                     primaryColor: Colors.green,
//                                                     menuMode: true,
//                                                     backgroundColor: nb4,
//                                                     hint: 'write',
//                                                     labelAlign: TextAlign.right,
//                                                     menuHeight: 240,
//                                                     // showClearButton: true,
//                                                     dropdownBackgroundColor: d1,
//                                                     labelStyle: const TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     items: checks,
//                                                     label:
//                                                         'أختر  ‏الفحص  ‏الخامس',
//                                                     prefixIcon: const Padding(
//                                                       padding:
//                                                           EdgeInsets.all(0.0),
//                                                       child: Icon(Icons.search),
//                                                     ),
//                                                     dropDownMenuItems:
//                                                         checks.map((item) {
//                                                       return item['testName'];
//                                                     }).toList(),
//                                                     onChanged: (value) {
//                                                       if (value != null) {
//                                                         setState(() {
//                                                           test5 =
//                                                               value['testName']
//                                                                   .toString();
//                                                           testid5 = value['id']
//                                                               .toString();
//                                                           // print(test1);
//                                                         });
//                                                       } else {
//                                                         test5 = null;
//                                                       }
//                                                       Navigator.pop(context);
//                                                     },
//                                                   ),
//                                                 ),
//                                               ).show();
//                                             },
//                                             child: NeomphormDark(
//                                               child: Text(
//                                                 test5.toString(),
//                                                 style: tilte1Style,
//                                               ),
//                                               color: grey!,
//                                               width: .8,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 : Container(
//                                     color: d1,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         NeomphormDark(
//                                           color: d2,
//                                           width: .43,
//                                           child: Column(
//                                             children: [
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: drugs,
//                                                           label:
//                                                               'أختر الدواء الاول',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               drugs.map((item) {
//                                                             return item[
//                                                                 'subject_name'];
//                                                           }).toList(),
//                                                           onChanged: (value) {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 ilacIName1 = value[
//                                                                         'subject_name']
//                                                                     .toString();
//                                                                 ilacId1 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                             } else {
//                                                               ilacIName1 = null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       ilacIName1.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: drugs,
//                                                           label:
//                                                               'أختر الدواء الثاني',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               drugs.map((item) {
//                                                             return item[
//                                                                 'subject_name'];
//                                                           }).toList(),
//                                                           onChanged: (value) {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 ilacIName2 = value[
//                                                                         'subject_name']
//                                                                     .toString();
//                                                                 ilacId2 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                             } else {
//                                                               ilacIName2 = null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       ilacIName2.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: drugs,
//                                                           label:
//                                                               'أختر الدواء الثالث',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               drugs.map((item) {
//                                                             return item[
//                                                                 'subject_name'];
//                                                           }).toList(),
//                                                           onChanged: (value) {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 ilacIName3 = value[
//                                                                         'subject_name']
//                                                                     .toString();
//                                                                 ilacId3 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                             } else {
//                                                               ilacIName3 = null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       ilacIName3.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: drugs,
//                                                           label:
//                                                               'أختر الدواء الرابع',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               drugs.map((item) {
//                                                             return item[
//                                                                 'subject_name'];
//                                                           }).toList(),
//                                                           onChanged: (value) {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 ilacIName4 = value[
//                                                                         'subject_name']
//                                                                     .toString();
//                                                                 ilacId4 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                             } else {
//                                                               ilacIName4 = null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       ilacIName4.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: drugs,
//                                                           label:
//                                                               'أختر الدواء الخامس',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               drugs.map((item) {
//                                                             return item[
//                                                                 'subject_name'];
//                                                           }).toList(),
//                                                           onChanged: (value) {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 ilacIName5 = value[
//                                                                         'subject_name']
//                                                                     .toString();
//                                                                 ilacId5 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                             } else {
//                                                               ilacIName5 = null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       ilacIName5.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         NeomphormDark(
//                                           color: nb4,
//                                           width: .43,
//                                           child: Column(
//                                             children: [
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: mydrugs,
//                                                           label:
//                                                               'أختر الدواء الاول',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               mydrugs
//                                                                   .map((item) {
//                                                             return item[
//                                                                     'ilacName'] +
//                                                                 '          ‏المتبقي   ' +
//                                                                 item['count'];
//                                                           }).toList(),
//                                                           onChanged:
//                                                               (value) async {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 myIlac1Name = value[
//                                                                         'ilacName']
//                                                                     .toString();
//                                                                 myIlacID1 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                               if (int.parse(value[
//                                                                       'count']) >
//                                                                   0) {
//                                                                 await Methods()
//                                                                     .updateClintDrug(
//                                                                         myIlacID1
//                                                                             .toString());
//                                                               } else {
//                                                                 Get.snackbar(
//                                                                     'drug is empty',
//                                                                     'message',
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .red);
//                                                               }
//                                                             } else {
//                                                               myIlac1Name =
//                                                                   null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       myIlac1Name.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: mydrugs,
//                                                           label:
//                                                               'أختر الدواء الثاني',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               mydrugs
//                                                                   .map((item) {
//                                                             return item[
//                                                                     'ilacName'] +
//                                                                 '          ‏المتبقي   ' +
//                                                                 item['count'];
//                                                           }).toList(),
//                                                           onChanged:
//                                                               (value) async {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 myIlac2Name = value[
//                                                                         'ilacName']
//                                                                     .toString();
//                                                                 myIlacID2 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                               if (int.parse(value[
//                                                                       'count']) >
//                                                                   0) {
//                                                                 await Methods()
//                                                                     .updateClintDrug(
//                                                                         myIlacID1
//                                                                             .toString());
//                                                               } else {
//                                                                 Get.snackbar(
//                                                                     'drug is empty',
//                                                                     'message',
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .red);
//                                                               }
//                                                               (myIlacID2
//                                                                   .toString());
//                                                             } else {
//                                                               myIlac2Name =
//                                                                   null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       myIlac2Name.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: mydrugs,
//                                                           label:
//                                                               'أختر الدواء الثالث',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               mydrugs
//                                                                   .map((item) {
//                                                             return item[
//                                                                     'ilacName'] +
//                                                                 '          ‏المتبقي   ' +
//                                                                 item['count'];
//                                                           }).toList(),
//                                                           onChanged:
//                                                               (value) async {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 myIlac3Name = value[
//                                                                         'ilacName']
//                                                                     .toString();
//                                                                 myIlacID3 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                               if (int.parse(value[
//                                                                       'count']) >
//                                                                   0) {
//                                                                 await Methods()
//                                                                     .updateClintDrug(
//                                                                         myIlacID1
//                                                                             .toString());
//                                                               } else {
//                                                                 Get.snackbar(
//                                                                     'drug is empty',
//                                                                     'message',
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .red);
//                                                               }
//                                                               (myIlacID3
//                                                                   .toString());
//                                                             } else {
//                                                               myIlac3Name =
//                                                                   null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       myIlac3Name.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: mydrugs,
//                                                           label:
//                                                               'أختر الدواء الرابع',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               mydrugs
//                                                                   .map((item) {
//                                                             return item[
//                                                                     'ilacName'] +
//                                                                 '          ‏المتبقي   ' +
//                                                                 item['count'];
//                                                           }).toList(),
//                                                           onChanged:
//                                                               (value) async {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 myIlac4Name = value[
//                                                                         'ilacName']
//                                                                     .toString();
//                                                                 myIlacID4 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                               if (int.parse(value[
//                                                                       'count']) >
//                                                                   0) {
//                                                                 await Methods()
//                                                                     .updateClintDrug(
//                                                                         myIlacID1
//                                                                             .toString());
//                                                               } else {
//                                                                 Get.snackbar(
//                                                                     'drug is empty',
//                                                                     'message',
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .red);
//                                                               }
//                                                               (myIlacID4
//                                                                   .toString());
//                                                             } else {
//                                                               myIlac4Name =
//                                                                   null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       myIlac4Name.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .45,
//                                                 child: TextButton(
//                                                   onPressed: () async {
//                                                     AwesomeDialog(
//                                                       context: context,
//                                                       body: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             .8,
//                                                         height: 350,
//                                                         color: myMac1,
//                                                         child:
//                                                             CustomSearchableDropDown(
//                                                           primaryColor:
//                                                               Colors.green,
//                                                           menuMode: true,
//                                                           backgroundColor: nb4,
//                                                           hint: 'write',
//                                                           labelAlign:
//                                                               TextAlign.right,
//                                                           menuHeight: 240,
//                                                           // showClearButton: true,
//                                                           dropdownBackgroundColor:
//                                                               nb3,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                           items: mydrugs,
//                                                           label:
//                                                               'أختر الدواء الخامس',
//                                                           prefixIcon:
//                                                               const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     0.0),
//                                                             child: Icon(
//                                                                 Icons.search),
//                                                           ),
//                                                           dropDownMenuItems:
//                                                               mydrugs
//                                                                   .map((item) {
//                                                             return item[
//                                                                     'ilacName'] +
//                                                                 '          ‏المتبقي   ' +
//                                                                 item['count'];
//                                                           }).toList(),
//                                                           onChanged:
//                                                               (value) async {
//                                                             if (value != null) {
//                                                               setState(() {
//                                                                 myIlac5Name = value[
//                                                                         'ilacName']
//                                                                     .toString();
//                                                                 myIlacID5 = value[
//                                                                         'id']
//                                                                     .toString();
//                                                               });
//                                                               if (int.parse(value[
//                                                                       'count']) >
//                                                                   0) {
//                                                                 await Methods()
//                                                                     .updateClintDrug(
//                                                                         myIlacID1
//                                                                             .toString());
//                                                               } else {
//                                                                 Get.snackbar(
//                                                                     'drug is empty',
//                                                                     'message',
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .red);
//                                                               }
//                                                               (myIlacID5
//                                                                   .toString());
//                                                             } else {
//                                                               myIlac5Name =
//                                                                   null;
//                                                             }
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ).show();
//                                                   },
//                                                   child: NeomphormDark(
//                                                     child: Text(
//                                                       myIlac5Name.toString(),
//                                                       style: tilte1Style,
//                                                     ),
//                                                     color: grey!,
//                                                     width: .8,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Row(
//                   //   children: [
//                   //     TextButton.icon(
//                   //         onPressed: () async {
//                   //           await choosImagr(ImageSource.gallery);
//                   //         },
//                   //         icon: const Icon(Icons.camera),
//                   //         label: const Text('image')),
//                   //     _image == null
//                   //         ? Container()
//                   //         : InkWell(
//                   //             onTap: () {
//                   //               Navigator.push(
//                   //                   context,
//                   //                   PageTransition(
//                   //                       type: PageTransitionType.scale,
//                   //                       alignment: Alignment.bottomCenter,
//                   //                       child: ImageView(
//                   //                         image: _image!,
//                   //                       )));
//                   //             },
//                   //             child: Image.memory(
//                   //               decodImage(imageINByte.toString()),
//                   //               width: 100,
//                   //             )
//                   //             // Image.file(
//                   //             //   _image!,
//                   //             //   width: 100,
//                   //             // ),
//                   //             ),
//                   //     TextButton.icon(
//                   //         onPressed: () async {
//                   //           // print(imageINByte);
//                   //           // print(widget.sickID);
//                   //           // print(encodImage(_image!.readAsBytesSync()));
//                   //           await Methods().addImage(
//                   //               widget.doctorID.toString(),
//                   //               encodImage(
//                   //                 _image!.readAsBytesSync(),
//                   //               ).toString());
//                   //           Navigator.push(
//                   //               context,
//                   //               MaterialPageRoute(
//                   //                 builder: (context) => ImageView1(),
//                   //               ));
//                   //         },
//                   //         icon: const Icon(Icons.upload_file),
//                   //         label: const Text('Upload'))
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           HapticFeedback.mediumImpact;
//           AwesomeDialog(
//             context: context,
//             dialogType: DialogType.question,
//             animType: AnimType.topSlide,
//             title: "الدواء",
//             desc: 'أدخل الدواء',
//             width: MediaQuery.of(context).size.width,
//             dismissOnTouchOutside: false,
//             btnCancelOnPress: () {},
//             btnOkOnPress: () async {
//               // print(imageINByte);
//               HapticFeedback.heavyImpact();
//               await Methods().addClientSickreview(
//                 status.text,
//                 session[widget.index]['temp'].toString(),
//                 widget.sickID.toString(),
//                 ilacIName1 == 'ilac1' ? '' : ilacIName1.toString(),
//                 ilacIName2 == 'ilac2' ? '' : ilacIName2.toString(),
//                 ilacIName3 == 'ilac3' ? '' : ilacIName3.toString(),
//                 ilacIName4 == 'ilac4' ? '' : ilacIName4.toString(),
//                 ilacIName5 == 'ilac5' ? '' : ilacIName5.toString(),
//                 widget.doctorID.toString(),
//                 DateTime.now().toString(),
//                 imageINByte.toString(),
//                 session[widget.index]['suger'].toString(),
//                 session[widget.index]['press'].toString(),
//                 session[widget.index]['weight'].toString(),
//                 session[widget.index]['tall'].toString(),
//                 session[widget.index]['pulse'].toString(),
//                 test1.toString(),
//                 test2.toString(),
//                 test3.toString(),
//                 test4.toString(),
//                 test5.toString(),
//                 myIlac1Name.toString(),
//                 myIlac2Name.toString(),
//                 myIlac3Name.toString(),
//                 myIlac4Name.toString(),
//                 myIlac5Name.toString(),
//               );

//               await Methods()
//                   .updateSessionIsSeenDoctor(widget.sessionId.toString());
//               setState(() {
//                 getClients();
//                 isseen = true;
//               });
//               await Methods().sendWhatssApp(
//                 widget.phone,
//                 """
//                 ${status.text} Status /n\n ${tempreture.text} Heat \n
                
//                 ${ilacIName1 == ' ‏العلاج الأول' ? '' : ilacIName1.toString()} \n
//                 ${ilacIName2 == ' ‏العلاج الثاني' ? '' : ilacIName2.toString()} \n
//                 ${ilacIName3 == ' ‏العلاج الثالث' ? '' : ilacIName3.toString()} \n
//                 ${ilacIName4 == ' ‏العلاج الرابع' ? '' : ilacIName4.toString()} \n
//                 ${ilacIName5 == ' ‏العلاج الخامس' ? '' : ilacIName5.toString()} \n
//                 ${DateTime.now().toString()}
//                 """,
//               );
//             },
//             body: Neomphorm(
//               width: .98,
//               child: TextField(
//                 controller: status,
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   enabled: true, hintMaxLines: 2,
//                   hintText: 'وصف الحاله',
//                   prefixIcon: Image.asset(
//                     'assets/healthy.png',
//                     width: 30,
//                   ),
//                   // helperText: 'helper',

//                   labelText: 'وصف الحاله',
//                   // counterText: 'counter',
//                   border: OutlineInputBorder(
//                     gapPadding: 4,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//           ).show();
//         },
//         child: const Icon(
//           Icons.add,
//         ),
//         backgroundColor: gren!,
//       ),
//     );
//   }
// }

// class ImageView extends StatelessWidget {
//   final File image;

//   const ImageView({Key? key, required this.image}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image'),
//       ),
//       body: Hero(tag: image, child: Image.file(image)),
//     );
//   }
// }

// class IlacCard extends StatelessWidget {
//   const IlacCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       scrollDirection: Axis.horizontal,
//       shrinkWrap: true,
//       children: [
//         Container(
//           color: d3,
//           height: 100,
//         ),
//         Container(
//           color: d1,
//           height: 100,
//         ),
//         Container(
//           color: d2,
//           height: 100,
//         ),
//       ],
//     );
//   }
// }
