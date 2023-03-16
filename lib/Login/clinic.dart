import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:doctors/Login/new_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'method/provider_user.dart';

class Clinic extends StatelessWidget {
  Clinic({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _clinicnameController = TextEditingController();
  final _cityController = TextEditingController();

  late String _error = '';

  void _clearForm() {
    _clinicnameController.clear();
    _cityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(''),
      // ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ],
                      ),
                      Hero(
                        tag: 'a',
                        child: Image.asset(
                          'assets/logo.png',
                          height: 120,
                          width: 120,
                        ),
                      ),
                      const SizedBox(height: 32),
                      FadeInUpBig(
                        duration: const Duration(milliseconds: 1000),
                        child: TextFormField(
                          controller: _clinicnameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Clinic Name',
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.white),
                          ),
                          keyboardType:
                              TextInputType.text, // added keyboardType
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Clinic Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: TextFormField(
                          controller: _cityController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'City',
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.location_city,
                                color: Colors.white),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Site';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInDown(
                        duration: const Duration(milliseconds: 1000),
                        child: ElevatedButton(
                          onPressed: () {
                            final provider = Provider.of<UserProvider>(context,
                                listen: false);
                            final form = _formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              provider.addClinic(
                                _clinicnameController.text.trim(),
                                _cityController.text.trim(),
                              );
                              _clearForm();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            }
                          },
                          child: const Text('Add Clinic'),
                        ),
                      ),
                      if (_error.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            _error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
