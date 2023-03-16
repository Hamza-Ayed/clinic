import 'dart:math';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:doctors/Login/widget/scaffold_widget.dart';
import 'package:doctors/Login/widget/textfield.dart';
import 'package:doctors/db/sqlff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'method/provider_user.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final patintNameController = TextEditingController();
  final phoneController = TextEditingController();
  final siteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _clearForm() {
    patintNameController.clear();
    phoneController.clear();
    siteController.clear();
    _controller.clear();
  }

  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select birthdate',
      cancelText: 'Cancel',
      confirmText: 'Select',
      fieldLabelText: 'Birthdate',
      fieldHintText: 'Month/Date/Year',
    );
    if (picked != null) {
      setState(() {
        _controller.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  String? _gender;

  @override
  Widget build(BuildContext context) {
    return stackWidget(
      context,
      'assets/background1.png',
      'Add Patient Details',
      Form(
        child: Column(
          children: [
            TextFieldWidget(
                controllername: patintNameController,
                labelText: 'Patient Name',
                validatorText: 'Please enter your username',
                inputype: TextInputType.text),
            const SizedBox(
              height: 20,
            ),
            FadeInDown(
              duration: const Duration(milliseconds: 1000),
              child: TextField(
                readOnly: true,
                controller: _controller,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'Birthdate',
                  hintText: 'Month/Date/Year',
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
                controllername: phoneController,
                labelText: 'Phone Number',
                validatorText: 'Please enter Phone number',
                inputype: TextInputType.phone),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
                controllername: siteController,
                labelText: 'City',
                validatorText: 'Please enter Patient Site / City',
                inputype: TextInputType.text),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              child: CupertinoSegmentedControl(
                groupValue: _gender,
                onValueChanged: (value) {
                  setState(() {
                    _gender = value.toString();
                    HapticFeedback.heavyImpact();
                  });
                },
                children: const {
                  'Male': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Male'),
                  ),
                  'Female': Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Female'),
                  ),
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // final provider =
                //     Provider.of<UserProvider>(context, listen: false);
                final form = _formKey.currentState;
                // if (form != null && form.validate()) {
                //   form.save();
                // provider.addPatient(
                //   patintNameController.text.trim(),
                //   siteController.text.trim(),
                //   _gender.toString(),
                //   phoneController.text.trim(),
                //   // _userType.toString(),
                // );
                // _clearForm();
                DBSqlFF('ChecksHealth').insert({
                  'ChecksHealth': patintNameController.text,
                  // 'birhdate': _controller.text,
                  // 'gender': _gender.toString(),
                  // 'site': siteController.text,
                  // 'phone': phoneController.text,
                  // 'lastVisit': DateTime.now().toString()
                }).then((value) {
                  print('Drugs inserted successfully : ' + value.toString());
                });
                // } else {
                //   print('error is : ' + e.toString());
                // }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
