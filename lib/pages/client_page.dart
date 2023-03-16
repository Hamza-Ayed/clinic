import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/constant/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'method.dart';

class ClientPage extends StatefulWidget {
  final String doctorID;

  const ClientPage({Key? key, required this.doctorID}) : super(key: key);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  TextEditingController count = TextEditingController();
  TextEditingController updatedCountController = TextEditingController();
  TextEditingController ilacName = TextEditingController();
  TextEditingController price = TextEditingController();
  String? drugName = "";
  String? totlaPrice = "0";
  String drugID = "";
  bool isloading = true;
  List drugs = [];

  Future getDrugsClient(String doctoId) async {
    var res = await http.post(Uri.parse(url + 'getClientDrugs.php'), body: {
      // 'action': 'getClientDrugs',
      'doctor_id': doctoId.toString(),
    });
    if (res.statusCode == 200) {
      var decod = jsonDecode(res.body);
      // ignore: avoid_print
      // print(decod);
      setState(() {
        isloading = false;
        drugs = decod;
        totlaPrice = drugs[0]['total_price'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDrugsClient(widget.doctorID.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text(
          'My Drugs',
          style: TextStyle(
              fontSize: 20,
              color: nb1,
              fontWeight: FontWeight.bold,
              fontFamily: 'Helvetica'),
        ),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.sell),
          )
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: isloading
            ? CircularProgressIndicator(
                color: nb1,
              )
            : Column(
                children: [
                  BubelButton(
                      width: MediaQuery.of(context).size.width,
                      color: d3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BubelButton(
                            width: MediaQuery.of(context).size.width * .3,
                            color: d1,
                            child: Text('Name', style: tilteStyle),
                          ),
                          BubelButton(
                            color: nb4,
                            width: MediaQuery.of(context).size.width * .2,
                            child: Text('count', style: tilteStyle),
                          ),
                          BubelButton(
                            color: nb3,
                            width: MediaQuery.of(context).size.width * .2,
                            child: Text('Price', style: tilteStyle),
                          ),
                          BubelButton(
                            color: d2,
                            width: MediaQuery.of(context).size.width * .2,
                            child: Text('Total ', style: tilteStyle),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      addSemanticIndexes: true,
                      itemCount: drugs.length,
                      itemBuilder: (context, index) {
                        if (drugs.isEmpty) {
                          return const Center(
                            child: Text('noooooooooooooo'),
                          );
                        }
                        var res = drugs[index];
                        return Slidable(
                          key: const ValueKey(0),

                          // The start action pane is the one at the left or the top side.
                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(onDismissed: () async {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: const Text('Delet'),
                                  content: const Text('Are you sure to Delete'),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: const Text('cancel'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                    ),
                                    CupertinoDialogAction(
                                        child: const Text('Ok'),
                                        onPressed: () async {
                                          await Methods().deleteClintDrug(
                                              res['id'].toString());
                                          setState(() {
                                            getDrugsClient(
                                                widget.doctorID.toString());
                                          });
                                          Navigator.of(context).pop(true);
                                        }),
                                  ],
                                ),
                              );
                            }),

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
                                      title: const Text('Delet'),
                                      content:
                                          const Text('Are you sure to Delete'),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: const Text('cancel'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                        ),
                                        CupertinoDialogAction(
                                            child: const Text('Ok'),
                                            onPressed: () async {
                                              await Methods().deleteClintDrug(
                                                  res['id'].toString());
                                              setState(() {
                                                getDrugsClient(
                                                    widget.doctorID.toString());
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
                              SlidableAction(
                                // An action can be bigger than the others.
                                // flex: 2,
                                onPressed: (context) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.topSlide,
                                    title: "الدواء",
                                    desc: 'أدخل الدواء',
                                    width: MediaQuery.of(context).size.width,
                                    dismissOnTouchOutside: false,
                                    btnCancelOnPress: () {
                                      Navigator.pop(context);
                                    },
                                    btnOkOnPress: () async {
                                      // print(widget.doctorID.toString());
                                      setState(() {
                                        isloading = true;
                                      });
                                      await Methods().updateClintDrug(
                                        res['id'],
                                      );
                                      setState(() {
                                        getDrugsClient(
                                            widget.doctorID.toString());
                                        isloading = false;
                                      });
                                    },
                                    body: TextField(
                                      decoration: InputDecoration(
                                          hintText: res['count']),
                                      controller: updatedCountController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ).show();
                                },
                                backgroundColor: const Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: Icons.archive,
                                label: 'Archive',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.topSlide,
                                    title: "الدواء",
                                    desc: 'أدخل الدواء',
                                    width: MediaQuery.of(context).size.width,
                                    dismissOnTouchOutside: false,
                                    btnCancelOnPress: () {
                                      Navigator.pop(context);
                                    },
                                    btnOkOnPress: () async {
                                      // print(widget.doctorID.toString());
                                      setState(() {
                                        isloading = true;
                                      });
                                      await Methods().updateClintDrug(
                                        res['id'],
                                      );
                                      setState(() {
                                        getDrugsClient(
                                            widget.doctorID.toString());
                                        isloading = false;
                                      });
                                    },
                                    body: TextField(
                                      decoration: InputDecoration(
                                          hintText: res['count']),
                                      controller: updatedCountController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ).show();
                                },
                                backgroundColor: const Color(0xFF0392CF),
                                foregroundColor: Colors.white,
                                icon: Icons.save,
                                label: 'Update',
                              ),
                            ],
                          ),

                          child: Card(
                            color: Colors.grey[300],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BubelButton(
                                  width: MediaQuery.of(context).size.width * .3,
                                  color: d1,
                                  child: Text(res['ilacName'].toString(),
                                      style: tilteStyle),
                                ),
                                BubelButton(
                                    color: nb4,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/weight.png',
                                          width: 15,
                                        ),
                                        Text(res['count'].toString(),
                                            style: tilteStyle),
                                      ],
                                    )),
                                BubelButton(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    color: nb3,
                                    child: Text(res['price'].toString(),
                                        style: tilteStyle)),
                                BubelButton(
                                  child: Text(res['total_price_drug']),
                                  color: d2,
                                  width: MediaQuery.of(context).size.width * .2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      )),
      bottomNavigationBar: SizedBox(
        height: 60,
        // color: Colors.grey[400],
        child: Neomphorm(
            width: 1,
            child: Text('Total price For all Drugs is ' + totlaPrice.toString(),
                style: tilte2Style)),
      ),
      floatingActionButton: FloatingActionButton(
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
            btnOkOnPress: () async {
              // print(widget.doctorID.toString());
              setState(() {
                isloading = true;
              });
              await Methods().addClientDrug(
                ilacName.text.toString(),
                count.text.toString(),
                price.text.toString(),
                widget.doctorID.toString(),
              );
              setState(() {
                getDrugsClient(widget.doctorID.toString());
                isloading = false;
              });
            },
            body: Column(
              children: [
                TextField(
                  decoration:
                      const InputDecoration(hintText: '‏أدخل اسم الدواء'),
                  controller: ilacName,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: '‏أدخل الكمية'),
                  controller: count,
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: '‏أدخل سعر شراء'),
                  controller: price,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          ).show();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green.shade400,
      ),
    );
  }
}
