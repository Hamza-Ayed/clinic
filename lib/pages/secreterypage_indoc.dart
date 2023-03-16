import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/constant/url.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddSecretary extends StatefulWidget {
  final String doctorID, deviceId;

  const AddSecretary({Key? key, required this.doctorID, required this.deviceId})
      : super(key: key);
  @override
  _AddSecretaryState createState() => _AddSecretaryState();
}

class _AddSecretaryState extends State<AddSecretary> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool isloading = true;
  String? birthDate;
  List list = [];
  bool valBox = false;
  String? updated = '1';

  Future getSecretary() async {
    var res = await http.post(Uri.parse(url + 'getSecretary.php'), body: {
      // 'action': 'getSecretary',
      'doctor_id': widget.doctorID.toString(),
    });
    if (res.statusCode == 200) {
      var decod = jsonDecode(res.body);
      print(decod);
      setState(() {
        isloading = false;
        list = decod;
      });
    }
  }

  @override
  void initState() {
    getSecretary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        title: Text(
          ' ‏إضافة سكرتير',
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
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              child: Icon(
                Icons.person_add,
                color: gren,
              ),
              onTap: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.topSlide,
                    title: "الدواء",
                    desc: 'أدخل الدواء',
                    width: MediaQuery.of(context).size.width,
                    dismissOnTouchOutside: false,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      setState(() {
                        isloading = true;
                      });
                      await Methods()
                          .addSecretary(
                              name.text.toString(),
                              widget.doctorID.toString(),
                              pass.text.toString(),
                              phone.text.toString(),
                              '2',
                              DateTime.now().toString())
                          // Navigator.pop(context);
                          .then((value) {
                        setState(() {
                          isloading = false;
                          getSecretary();
                        });
                      });
                    },
                    body: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                              hintText: ' ‏اكتب اسم السكرتير'),
                          textInputAction: TextInputAction.next,
                          controller: name,
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(hintText: 'Password'),
                          controller: pass,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              hintText: '‏اكتب رقم هاتف السكرتير'),
                          controller: phone,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    )).show();
              },
            ),
          )
        ],
      ),
      backgroundColor: grey,
      body: SafeArea(
          child: Center(
        child: isloading
            ? const LinearProgressIndicator()
            : list.isEmpty
                ? const Text('No Secretary Yet!....')
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var res = list[index];
                      return Neomphorm(
                        width: .09,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (res['roles_id'] == '1') {
                                    setState(() {
                                      updated = '2';
                                      // print(updated);
                                    });
                                  } else if (res['roles_id'] == '2') {
                                    setState(() {
                                      updated = '1';
                                      // print(updated);
                                    });
                                  }
                                  AwesomeDialog(
                                      context: context,
                                      title: '‏أعطي الصلاحية',
                                      dialogBackgroundColor:
                                          res['roles_id'] == '2'
                                              ? gren!.withOpacity(.5)
                                              : Colors.red.shade300,
                                      body: Column(
                                        children: [
                                          res['roles_id'] == '2'
                                              ? Text(
                                                  '‏هل أنت متأكد من إعطاء صلاحية',
                                                  style: tilte1Style,
                                                )
                                              : Text(
                                                  '‏هل أنت متأكد من  ‏سحب صلاحية',
                                                  style: tilte1Style,
                                                ),
                                          // CheckboxListTile(
                                          //   autofocus: true, dense: true,
                                          //   // secondary: const Icon(Icons.local_offer),
                                          //   title: valBox
                                          //       ? const Text(' 👍',
                                          //           style: TextStyle(
                                          //             fontSize: 19,
                                          //             fontWeight:
                                          //                 FontWeight.bold,
                                          //             color: Colors.green,
                                          //           ))
                                          //       : const Text(
                                          //           '👎🏻',
                                          //           style: TextStyle(
                                          //             fontSize: 18,
                                          //             fontWeight:
                                          //                 FontWeight.bold,
                                          //             color: Colors.red,
                                          //           ),
                                          //         ),
                                          //   // subtitle: Text('Offer'),
                                          //   value: valBox, checkColor: sa3,
                                          //   selectedTileColor: sa5,
                                          //   onChanged: (value) {
                                          //     setState(() {
                                          //       valBox = value!;
                                          //       // print(valyatak);
                                          //     });
                                          //   },
                                          // ),
                                        ],
                                      ),
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        setState(() {
                                          isloading = true;
                                        });

                                        await Methods().secretaryUpdate(
                                          res['secretary_id_tabi'].toString(),
                                          // res['roles_id'] == '1' ? '1' : '2',
                                          updated.toString(),
                                        );
                                        setState(() {
                                          isloading = false;
                                          getSecretary();
                                        });
                                      }).show();
                                },
                                child: NeomphormDark(
                                    width: .08,
                                    child: res['roles_id'] == '1'
                                        ? const Text('👍')
                                        : const Text('👎🏻'),
                                    color: res['roles_id'] == '1'
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              Text(res['secretary_name'].toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              // Text(res['password'],
                              //     style: const TextStyle(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.bold)),
                              Text(res['phone'].toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      isloading = true;
                                    });
                                    Methods()
                                        .deleteSecretary(
                                            res['secretary_id_tabi'].toString())
                                        .then((value) {
                                      setState(() {
                                        isloading = false;
                                        getSecretary();
                                      });
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      )),
    );
  }
}
