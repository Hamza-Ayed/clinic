import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class UserProvider with ChangeNotifier {
  final String _baseUrl = 'https://facedoctor.000webhostapp.com/newdoct';
  late Box<String> _responseBox;
  String? _error;
  final _storage = const FlutterSecureStorage();
  UserProvider() {
    _initResponseBox();
  }

  Future<void> _initResponseBox() async {
    await Hive.openBox<String>('responses');
    _responseBox = Hive.box<String>('responses');
  }

  // Future<void> addUser(
  //     String username,
  //     String password,
  //     String email,
  //     String phone,
  //     String type,
  //     String firstName,
  //     String lastName,
  //     String timestamp,
  //     String clinicName) async {
  //   final String url = '$_baseUrl/addUser.php';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: jsonEncode({
  //         'username': username,
  //         'password': password,
  //         'email': email,
  //         'phone': phone,
  //         'type': type,
  //         'first_name': firstName,
  //         'last_name': lastName,
  //         'timestamp': timestamp,
  //         'clinic_name': clinicName,
  //       }),
  //     );
  //     final responseBody = response.body;
  //     if (response.statusCode == 200) {
  //       _responseBox.put('addUserResponse', responseBody);
  //       print(responseBody);
  //     } else {
  //       _error = 'HTTP error ${response.statusCode}: $responseBody';
  //     }
  //   } catch (error) {
  //     _error = 'HTTP error: $error';
  //   }
  //   notifyListeners();
  // }
  Future addUser(
      String username,
      String password,
      String email,
      String phone,
      String type,
      String firstName,
      String lastName,
      String dateRegister,
      String clinicName) async {
    const url =
        'https://facedoctor.000webhostapp.com/newdoct/addUser.php'; // Replace with the URL of your PHP script
    final response = await http.post(Uri.parse(url), body: {
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'type': type,
      'first_name': firstName,
      'last_name': lastName,
      'date_register': dateRegister,
      'clinic_name': clinicName
    });

    return jsonDecode(response.body);
  }

  Future<bool> login(String username, String password) async {
    const url = 'https://facedoctor.000webhostapp.com/newdoct/login.php';
    final response = await http.post(Uri.parse(url), body: {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse == 'User not found') {
        Fluttertoast.showToast(msg: 'User not found');
        throw Exception(jsonDecode(response.body));
      } else {
        // Save the token and other fields securely
        await _storage.write(
            key: 'token', value: jsonResponse['token'].toString());
        await _storage.write(key: 'userId', value: jsonResponse['userId']);
        await _storage.write(key: 'username', value: jsonResponse['username']);
        await _storage.write(key: 'email', value: jsonResponse['email']);
        await _storage.write(
            key: 'first_name', value: jsonResponse['first_name']);
        await _storage.write(
            key: 'last_name', value: jsonResponse['last_name']);
        // Notify listeners that the user is logged in

        Fluttertoast.showToast(msg: 'Login successful');
        print(jsonResponse);
        notifyListeners();
        return true;
      }
    } else {
      Fluttertoast.showToast(msg: 'Login failed');
      return false;
    }
  }

  void logout() {
    _responseBox.deleteAll(['loginResponse']);
    notifyListeners();
  }

  Future addClinic(String name, String site) async {
    var res = await http.post(
      Uri.parse('https://facedoctor.000webhostapp.com/newdoct/addClinic.php'),
      body: {
        'name': name,
        'site': site,
        'date': DateTime.now().toString(),
      },
    );
    if (res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: 'Record added successfully', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(
          msg: 'Failed to add record', backgroundColor: Colors.red);
    }
  }

  Future addPatient(String name, String site, String gender,phone) async {
    var res = await http.post(
      Uri.parse('https://facedoctor.000webhostapp.com/newdoct/addPatient.php'),
      body: {
        'name': name,
        'site': site,
        'birthdate': DateTime.now().toString(),
        'gender': gender,
        'phone':phone
      },
    );
    if (res.statusCode == 201) {
      Fluttertoast.showToast(
          msg: 'Record added successfully', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(
          msg: 'Failed to add record', backgroundColor: Colors.red);
    }
  }

  String? get error => _error;

  String? get addUserResponse =>
      _responseBox.get('addUserResponse', defaultValue: null);

  String? get loginResponse =>
      _responseBox.get('loginResponse', defaultValue: null);
}
