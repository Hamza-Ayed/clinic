import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/constant/url.dart';
import 'package:doctors/pages/method.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DrugsPage extends StatefulWidget {
  final String doctorId;

  const DrugsPage({Key? key, required this.doctorId}) : super(key: key);
  @override
  _DrugsPageState createState() => _DrugsPageState();
}

class _DrugsPageState extends State<DrugsPage> {
  TextEditingController subjectName = TextEditingController();
  String? drugName = "";
  String drugID = "";
  bool isloading = true;
  List drugs = [];

  Future getDrugs() async {
    var res = await http.post(Uri.parse(url + 'getDrugs.php'), body: {
      // 'action': 'getDrugs',
      // 'doctor_id': doctorId.toString(),
    });
    if (res.statusCode == 200) {
      var decod = jsonDecode(res.body);
      // print(decod);
      // await putData(decod);
      setState(() {
        isloading = false;
        drugs = decod;
      });
    }
  }

  // Box? box;
  // Future openBox(teamName) async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   box = await Hive.openBox(teamName);
  //   return;
  // }

  // Future putData(data) async {
  //   await box!.clear();
  //   // await box.add(data);
  //   for (var d in data) {
  //     box!.add(d);
  //   }
  // }

  // List data = [];
  // Box? box;

  // Future<bool> getAllData() async {
  //   await openBox('drugs');
  //   var mymap = box!.toMap().values.toList();
  //   if (mymap.isEmpty) {
  //     data.add('empty');
  //   } else {
  //     data = mymap;
  //     data.add(mymap);
  //     print(data);
  //     // data.
  //   }
  //   return Future.value(true);
  // }

  @override
  void initState() {
    getDrugs();
    // getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drugs Page'),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () async {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.topSlide,
                    title: "الدواء",
                    desc: 'أدخل الدواء',
                    width: MediaQuery.of(context).size.width,
                    dismissOnTouchOutside: false,
                    btnCancelOnPress: () {},
                    body: TextField(
                      decoration: const InputDecoration(
                          hintText: 'Write here new Drug'),
                      controller: subjectName,
                    ),
                    btnOkOnPress: () async {
                      Methods().addDrug(subjectName.text.toString());
                    },
                  ).show();
                },
                icon: const Icon(Icons.add_circle),
                label: const Text('أضف علاج جديد')),
            Container(
              width: MediaQuery.of(context).size.width * .8,
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
                items: drugs,
                label: 'Select Drug',
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(Icons.search),
                ),
                dropDownMenuItems: drugs.map((item) {
                  return item['subject_name'];
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      drugName = value['subject_name'].toString();
                      drugID = value['id'].toString();
                    });
                  } else {
                    drugName = null;
                  }
                  // Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
