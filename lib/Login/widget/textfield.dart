import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controllername, required this.labelText, required this.validatorText, required this.inputype,
  });

  final TextEditingController controllername;
  final String labelText, validatorText;
  final TextInputType inputype;
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: TextFormField(
        controller: controllername,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: const Icon(Icons.person, color: Colors.white),
        ),
        keyboardType: inputype, // added keyboardType
        validator: (value) {
          if (value!.isEmpty) {
            return validatorText; //'Please enter Patient Site / City'
          }
          return null;
        },
      ),
    );
  }
}
