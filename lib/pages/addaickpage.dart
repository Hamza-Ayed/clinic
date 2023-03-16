import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSickPage extends StatefulWidget {
  final String doctorId;

  const AddSickPage({Key? key, required this.doctorId}) : super(key: key);
  @override
  _AddSickPageState createState() => _AddSickPageState();
}

class _AddSickPageState extends State<AddSickPage> {
  TextEditingController name = TextEditingController();
  TextEditingController telphone = TextEditingController();
  TextEditingController site = TextEditingController();
  String gender = "male";

  String? birthDate = 'chose Birth date';
  String? dateRegister = '';
  DateTime selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDate = DateFormat("yyyy-MM-dd ").format(selectedDate);
      });
    }
  }

  @override
  void initState() {
    birthDate = DateFormat("yyyy-MM-dd ").format(selectedDate);
    dateRegister = DateFormat("yyyy-MM-dd ").format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: sa1,
              primary: Colors.green,
            ),
            onPressed: () async {
              await Methods().addSick(
                name.text.toString(),
                birthDate.toString(),
                telphone.text.toString(),
                widget.doctorId.toString(),
                gender.toString(),
                site.text.toString(),
                dateRegister.toString(),
              );
              Navigator.pop(context);
            },
            child: const Text('save'),
          ),
        ],
        backgroundColor: grey,
        elevation: 0,
        title: Text(
          'Add Sick ...',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Neomphorm(
                width: .9,
                child: TextField(
                  decoration:
                      const InputDecoration(hintText: 'Write here new Sick'),
                  controller: name,
                ),
              ),
              Neomphorm(
                width: .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('choose Birth date'),
                    TextButton(
                        onPressed: () {
                          selectDate(context);
                        },
                        child: Text(birthDate.toString())),
                  ],
                ),
              ),
              Neomphorm(
                width: .9,
                child: TextField(
                  decoration:
                      const InputDecoration(hintText: 'Write here  phone'),
                  controller: telphone,
                  keyboardType: TextInputType.phone,
                ),
              ),
              Neomphorm(
                width: .9,
                child: TextField(
                  decoration:
                      const InputDecoration(hintText: 'Write here  Site'),
                  controller: site,
                  keyboardType: TextInputType.text,
                ),
              ),
              Neomphorm(
                width: .9,
                child: SizedBox(
                  height: 50,
                  // color: nb1,
                  child: DropdownButton(
                    value: gender,
                    items: <String>['male', 'female']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text('choose'),
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
