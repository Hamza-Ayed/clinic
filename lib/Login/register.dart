import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'method/provider_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emialController = TextEditingController();
  final _phoneController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _clinicNameController = TextEditingController();
  String _userType = 'Doctor';

  final List<String> _userTypes = ['Doctor', 'Admin', 'Secretary'];
  void _clearForm() {
    _usernameController.clear();
    _passwordController.clear();
    _emialController.clear();
    _phoneController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _clinicNameController.clear();
    setState(() {
      _userType = '';
    });
  }

  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              decoration:
                                  const InputDecoration(labelText: 'Username'),
                              keyboardType:
                                  TextInputType.text, // added keyboardType
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              obscureText: false,
                              keyboardType: TextInputType
                                  .visiblePassword, // added keyboardType
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _emialController,
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType
                                  .emailAddress, // added keyboardType
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _phoneController,
                              decoration:
                                  const InputDecoration(labelText: 'Phone'),
                              keyboardType:
                                  TextInputType.phone, // added keyboardType
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _firstNameController,
                              decoration: const InputDecoration(
                                  labelText: 'First Name'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _lastNameController,
                              decoration:
                                  const InputDecoration(labelText: 'Last Name'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _clinicNameController,
                              decoration: const InputDecoration(
                                  labelText: 'Clinic Name'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your clinic name';
                                }
                                return null;
                              },
                            ),
                            CupertinoFormRow(
                              prefix: const Text('User Type'),
                              child: CupertinoPicker(
                                itemExtent: 32,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _userType = _userTypes[index];
                                  });
                                },
                                children:
                                    _userTypes.map((e) => Text(e)).toList(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                final provider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  provider.addUser(
                                    _usernameController.text.trim(),
                                    _passwordController.text.trim(),
                                    _emialController.text.trim(),
                                    _phoneController.text.trim(),
                                    _userType.toString(),
                                    _firstNameController.text.trim(),
                                    _lastNameController.text.trim(),
                                    DateTime.now().toString(),
                                    _clinicNameController.text,
                                  );
                                  _clearForm();
                                }
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
