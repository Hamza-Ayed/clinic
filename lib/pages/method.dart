// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
// import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/constant/url.dart';
import 'package:doctors/db/db.dart';
import 'package:doctors/db/sqlff.dart';
import 'package:doctors/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:whatsapp_share/whatsapp_share.dart';

class Methods {
  // List _tests = [];
  // List get listTests => _tests;
  List _drugs = [];
  List get listDrugs => _drugs;

  late Box box;
  Future openBox(tabel) async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox(tabel);
    return;
  }

  Future putData(data) async {
    await box.clear();
    // await box.add(data);
    for (var d in data) {
      box.add(d);
    }
  }

  Future getHive() async {
    var res = await http.post(
      Uri.parse(url),
      body: {
        'action': 'getHelthChecks',
      },
    );
    if (res.statusCode == 200) {
      var testhive = jsonDecode(res.body);
      for (var i = 0; i < testhive.length; i++) {
        await putData(testhive);
      }
      Fluttertoast.showToast(
        msg: 'sucse',
      );
    }
  }

  Future getHelthCheckstoSQL() async {
    var res = await http.post(
      Uri.parse(url + 'getHelthChecks.php'),
      body: {
        // 'action': 'getHelthChecks',
      },
    );
    if (res.statusCode == 200) {
      var decod = jsonDecode(res.body);
      for (var i = 0; i < decod.length; i++) {
        DBSql('ChecksHealth').insert({
          'testName': decod[i]['testName'].toString(),
        }).then((value) {
          print(' Tests inserted successfully : ' + value.toString());
        });
      }
      Fluttertoast.showToast(
        msg: 'sucse',
      );
    }
    print(res.body);
    Fluttertoast.showToast(
      msg: 'Faild',
    );
    // print(box!.get('name'));
    return jsonDecode(res.body);
  }

  Future getDrugsToSQL() async {
    var res = await http.post(
      Uri.parse(url + 'getDrugs.php'),
      body: {
        // 'action': 'getDrugs',
      },
    );
    if (res.statusCode == 200) {
      _drugs = jsonDecode(res.body);
      for (var i = 0; i < listDrugs.length; i++) {
        await DBSqlFF('Drugs').insert({
          'subject_name': listDrugs[i]['subject_name'].toString(),
          'barcode': listDrugs[i]['barcode'].toString(),
        }).then((value) {
          print('Drugs inserted successfully : ' + value.toString());
        });
      }

      Fluttertoast.showToast(
        msg: 'sucse',
      );
    }
  }

  Future getSick(String doctorID) async {
    var res = await http.post(Uri.parse(url + 'getSick.php'), body: {
      // 'action': 'getSick',
      'doctor_id': doctorID.toString(),
    });
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future drugsClient(String id) async {
    var res = await http.post(Uri.parse(url + 'ClientDrugs.php'), body: {
      // 'action': 'ClientDrugs',
      'id': id.toString(),
    });
    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    }
  }

  Future login(String name, pass, devicname) async {
    var res = await http.post(
      Uri.parse(url + 'LOGIN.php'),
      body: {
        // 'action': 'LOGIN',
        'password': pass.toString(),
        'device_id': devicname.toString(),
        'doctor_name': name.toString(),
      },
    );

    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addDrug(String subjectName) async {
    var res = await http.post(
      Uri.parse(url + 'AddDrug.php'),
      body: {
        // 'action': 'AddDrug',
        'subject_name': subjectName.toString(),
        // 'barcode': 'nothing',
      },
    );
    print(jsonDecode(res.body));
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addSick(String name, birthDate, telphone, doctorId, gender, site,
      dateRegister) async {
    var res = await http.post(
      Uri.parse(url + 'AddSick.php'),
      body: {
        'birth_date': birthDate.toString(),
        'name': name.toString(),
        'telphone': telphone.toString(),
        'doctor_id': doctorId.toString(),
        'gender': gender.toString(),
        'site': site.toString(),
        'dateRegister': dateRegister.toString(),
      },
    );
    // print(jsonDecode(res.body));
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addClientDrug(String ilacName, count, price, doctorID) async {
    var res = await http.post(
      Uri.parse(url + 'addClientDrug.php'),
      body: {
        // 'action': 'addClientDrug',
        'ilacName': ilacName.toString(),
        'count': count.toString(),
        'price': price.toString(),
        'doctor_id': doctorID.toString(),
      },
    );
    print(jsonDecode(res.body));
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addDoctors(
      String name, doctorId, password, phone, role, clientName, date) async {
    var res = await http.post(
      Uri.parse(url + 'AddDoctors.php'),
      body: {
        // 'action': 'AddDoctors',
        'doctor_name': name.toString(),
        'device_id': doctorId.toString(),
        'password': password.toString(),
        'roles_id': role.toString(),
        'phone': phone.toString(),
        'clientName': clientName.toString(),
        'reg': '1',
        'date_register': date.toString(),
      },
    );
    // print(jsonDecode(res.body));
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addSecretary(
      String name, doctorId, password, phone, role, date) async {
    var res = await http.post(
      Uri.parse(url + 'addSecretary.php'),
      body: {
        // 'action': 'AddDoctors',
        'secretary_name': name.toString(),
        'doctor_id': doctorId.toString(),
        'password': password.toString(),
        'roles_id': role.toString(),
        'phone': phone.toString(),
        'reg': '1',
        'date_register': date.toString(),
      },
    );
    print(jsonDecode(res.body));
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addImage(String name, image) async {
    var res = await http.post(
      Uri.parse(url + 'AddImages.php'),
      body: {
        'name': name.toString(),
        'image': image.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addClientSickreview(
      String status,
      tempreture,
      sickid,
      ilacid1,
      ilacid2,
      ilacid3,
      ilacid4,
      ilacid5,
      doctorID,
      date,
      image,
      suger,
      prussre,
      tall,
      pulse,
      weight,
      test1,
      test2,
      test3,
      test4,
      test5,
      mydrug1,
      mydrug2,
      mydrug3,
      mydrug4,
      mydrug5) async {
    var res = await http.post(
      Uri.parse(url + 'addClientSickreview.php'),
      body: {
        // 'action': 'addClientSickreview',
        'date': date.toString(),
        'status': status.toString(),
        'tempreture': tempreture.toString(),
        'sick_id': sickid.toString(),
        'ilac_id': ilacid1.toString(),
        'ilac_id2': ilacid2.toString(),
        'ilac_id3': ilacid3.toString(),
        'ilac_id4': ilacid4.toString(),
        'ilac_id5': ilacid5.toString(),
        'doctor_id': doctorID.toString(),
        'image': image.toString(),
        'suger': suger.toString(),
        'prussre': prussre.toString(),
        'weight': weight.toString(),
        'tall': tall.toString(),
        'pulse': pulse.toString(),
        'test1': test1.toString(),
        'test2': test2.toString(),
        'test3': test3.toString(),
        'test4': test4.toString(),
        'test5': test5.toString(),
        'mydrug1': mydrug1.toString(),
        'mydrug2': mydrug2.toString(),
        'mydrug3': mydrug3.toString(),
        'mydrug4': mydrug4.toString(),
        'mydrug5': mydrug5.toString(),
      },
    );
    // print(jsonDecode(res.body));
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future deleteSecretary(String secid) async {
    await http.post(
      Uri.parse(url + 'deleteSecretary.php'),
      body: {
        // 'action': 'DeleteDoctors',
        'secretary_id_tabi': secid.toString(),
      },
    ).then((value) => print(value));

    Fluttertoast.showToast(
      msg: 'sucsess',
    );
  }

  Future deleteSick(String sickId) async {
    await http.post(
      Uri.parse(url + 'DeleteSick.php'),
      body: {
        // 'action': 'DeleteDoctors',
        'sick_id': sickId.toString(),
      },
    ).then((value) => print(value));

    Fluttertoast.showToast(
      msg: 'sucsess',
    );
  }

  Future deleteClintDrug(String id) async {
    await http.post(
      Uri.parse(url + 'deleteClintDrug.php'),
      body: {
        // 'action': 'DeleteDoctors',
        'id': id.toString(),
      },
    ).then((value) => print(value));

    Fluttertoast.showToast(
      msg: 'sucsess',
    );
  }

  Future updateClintDrug(String id) async {
    var res = await http.post(
      Uri.parse(url + 'updateClintDrug.php'),
      body: {
        'id': id.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Updated') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }

    Fluttertoast.showToast(
      msg: 'updated',
    );
  }

  Future updateSessionIsSeenDoctor(String id) async {
    var res = await http.post(
      Uri.parse(url + 'updateSessionIsSeenDoctor.php'),
      body: {
        'id': id.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Updated') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }

    Fluttertoast.showToast(
      msg: 'sucsess',
    );
  }

  Future secretaryUpdate(String id, updated) async {
    var res = await http.post(
      Uri.parse(url + 'updateSecretary.php'),
      body: {
        // 'action': 'DeleteDoctors',
        'id': id.toString(),
        'updated': updated.toString()
      },
    );
    if (jsonDecode(res.body) == 'Updated') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }

    Fluttertoast.showToast(
      msg: 'sucsess',
    );
  }

  Future getImage() async {
    var res = await http.post(Uri.parse(url + 'getImage.php')).then((value) {
      print(jsonDecode(value.body));
      return jsonDecode(value.body);
    });
  }

  // List<Meeting> getDataSource() {
  //   final List<Meeting> meetings = <Meeting>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startTime =
  //       DateTime(today.year, today.month, today.day, 11, 0, 0);
  //   final DateTime endTime = startTime.add(const Duration(hours: 2));
  //   meetings.add(Meeting(
  //       'description', startTime, endTime, const Color(0xFF0F8644), false));

  //   return meetings;
  // }

  Future addAppointment(
      String description, startDate, endDate, color, doctorId, sickId) async {
    var res = await http.post(
      Uri.parse(url + 'addAppointment.php'),
      body: {
        'description': description.toString(),
        'startDate': startDate.toString(),
        'endDate': endDate.toString(),
        'color': color.toString(),
        'doctor_id': doctorId.toString(),
        'sick_id': sickId.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future getAppointmentDoctor(String sickId) async {
    var res = await http.post(Uri.parse(url + 'getAppointment.php'), body: {
      // 'action': 'getSick',
      'doctor_id': sickId.toString(),
    });
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future getAppointmentSick(String sickId) async {
    var res = await http.post(Uri.parse(url + 'getAppointmentSick.php'), body: {
      // 'action': 'getSick',
      'sick_id': sickId.toString(),
    });
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future getAppointmentforDate(String date) async {
    var res = await http.post(Uri.parse(url + 'appointmentfordate.php'), body: {
      // 'action': 'getSick',
      'date': date.toString(),
    });
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future deleteAppointment(String appointmentId) async {
    var res = await http.post(
      Uri.parse(url + 'deleteAppointment.php'),
      body: {
        // 'action': 'DeleteDoctors',
        'id': appointmentId.toString(),
      },
    );

    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future sendWhatssApp(String phone, message) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+962$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=+962$phone&text=${Uri.parse(message)}";
      }
    }

    await launch(url());
  }

  Future sendWhatssAppFile(String phone, File message) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+962$phone/?PDF=$message";
      } else {
        return "whatsapp://send?phone=+962$phone&text=$message";
      }
    }

    await launch(url());
  }

  Future sendSMS(String phone, message) async {
    if (Platform.isAndroid) {
      String uri = 'sms:+$phone?body=$message';
      await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      String uri = 'sms:$phone&body=$message';
      await launch(uri);
    }
  }

  void sendEmail(String email) async {
    var url = 'mailto:$email?subject=DeviceId&body=This email from Admin';
    print(url);
    await launch(url);
  }

  Future callPhone(String phoneNumber) async {
    await launch("tel://$phoneNumber");
  }

  Future getSecretary(String doctorID) async {
    var res = await http.post(Uri.parse(url + 'getSecretary.php'), body: {
      'doctorId': doctorID.toString(),
    });
    return jsonDecode(res.body);
  }

  Future getSecretarySalary(String doctorID) async {
    var res = await http.post(Uri.parse(url + 'getSecretarySalary.php'), body: {
      'doctor_id': doctorID.toString(),
    });
    return jsonDecode(res.body);
  }

  Future addSaatJob(
      String startjob, endjob, secretaryId, doctorId, date) async {
    var res = await http.post(
      Uri.parse(url + 'add_saatjob.php'),
      body: {
        'startjob': startjob.toString(),
        'endjob': endjob.toString(),
        'secretary_id': secretaryId.toString(),
        'doctor_id': doctorId.toString(),
        'date': date.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future getSecretarySaatJob() async {
    var res = await http.post(Uri.parse(url + 'getSaatJob.php'), body: {});
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future addSallary(String secretaryId, salary, salaryPluse, salaryMinus,
      doctorId, date) async {
    var res = await http.post(
      Uri.parse(url + 'addSalary.php'),
      body: {
        'Secretary_id': secretaryId.toString(),
        'salary': salary.toString(),
        'salary_pluse': salaryPluse.toString(),
        'salary_minus': salaryMinus.toString(),
        'doctor_id': doctorId.toString(),
        'date': date.toString()
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addClinicExpense(String electric, salary, visiting, clinikRental,
      water, gas, paper, medicalsupplies, doctorId) async {
    var res = await http.post(
      Uri.parse(url + 'addSalary.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'electric': electric.toString(),
        'salary': salary.toString(),
        'Visiting': visiting.toString(),
        'ClinikRental': clinikRental.toString(),
        'water': water.toString(),
        'gas': gas.toString(),
        'paper': paper.toString(),
        'medicalsupplies': medicalsupplies.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addNewDoctor(String name, password, phone, deviceID, role, clientName,
      date, reg) async {
    var res = await http.post(
      Uri.parse(url + 'AddDoctors.php'),
      body: {
        'doctor_name': name.toString(),
        'device_id': deviceID.toString(),
        'password': password.toString(),
        'roles_id': role.toString(),
        'phone': phone.toString(),
        'clientName': clientName.toString(),
        'reg': reg,
        'date_register': date.toString(),
      },
    );

    // var decode = jsonDecode(res.body);
    // print(jsonDecode(res.body));

    if (res.statusCode == 200) {
      // Get.snackbar('succes', 'message', backgroundColor: gren!);
      await DBSql('Users').insert({
        'username': name.toString(),
        'password': password.toString(),
        'devicename': deviceID.toString()
      });
      // Get.to(loginDoctor(name, password.toString(), deviceID.toString()));
    } else {
      // Get.snackbar('faild', 'message', backgroundColor: sa4);

      // print(jsonDecode(res.body));
      // Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }

    // if (res.statusCode == 200) {
    //   if (jsonDecode(res.body.toString()) == 'Added') {
    //     await CheckHealthSQL('Users').insert({
    //       'username': name.toString(),
    //       'password': password.toString(),
    //       'devicename': deviceID.toString()
    //     });

    //     Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    //   } else if (jsonDecode(res.body.toString()) == 'Not Added') {
    //     await CheckHealthSQL('Users')
    //         .deleteUser('Users', deviceID)
    //         .then((value) {});
    //     Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    //   }
    // }

    return res.body;
  }

  Future addElectricBill(String totalBill, kiloMonth, date, doctorId) async {
    var res = await http.post(
      Uri.parse(url + 'addElectric.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'total_bill': totalBill.toString(),
        'kilo_month': kiloMonth.toString(),
        'date': date.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addWater(String waterCount, date, doctorId) async {
    var res = await http.post(
      Uri.parse(url + 'addWater.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'waterCount': waterCount.toString(),
        'date': date.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addRental(String rentalCount, date, doctorId) async {
    var res = await http.post(
      Uri.parse(url + 'addRental.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'rent_count': rentalCount.toString(),
        'date': date.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addVisiting(String visitCount, date, doctorId) async {
    var res = await http.post(
      Uri.parse(url + 'addVisiting.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'visitCount': visitCount.toString(),
        'date': date.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addGas(String visitCount, date, doctorId) async {
    var res = await http.post(
      Uri.parse(url + 'addGas.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'gasCount': visitCount.toString(),
        'date': date.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addIhtiac(String ihtiacCount, date, doctorId) async {
    var res = await http.post(
      Uri.parse(url + 'addTibiIhtiac.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'count': ihtiacCount.toString(),
        'date': date.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future addPaper(String ihtiacCount, date, doctorId) async {
    var res = await http.post(
      Uri.parse(url + 'addpaper.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'paperCount': ihtiacCount.toString(),
        'date': date.toString(),
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future getSalaryTotal(String doctorID, date) async {
    var res = await http.post(Uri.parse(url + 'getSalaryTotal.php'), body: {
      'doctor_id': doctorID.toString(),
      'date': date.toString(),
    });
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

//
  Future showAllDoctors() async {
    var res = await http.post(Uri.parse(url + 'showDoctor.php'), body: {});
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future showSecretary() async {
    var res = await http.post(Uri.parse(url + 'showSecretary.php'), body: {});
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future showAllSick() async {
    var res = await http.post(Uri.parse(url + 'showAllSick.php'), body: {});
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  //updateStatus
  Future updateStatus(String doctorID, status) async {
    var res = await http.post(Uri.parse(url + 'UpdateStatusDoctor.php'), body: {
      'doctorId': doctorID.toString(),
      'status': status.toString(),
    });
    // print(jsonDecode(res.body));
    // return jsonDecode(res.body);
    if (jsonDecode(res.body) == 'Updated') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future loginDoctor(String name, pass, devicname) async {
    var res = await http.post(
      Uri.parse(url + 'LOGIN.php'),
      body: {
        'password': pass.toString(),
        'device_id': devicname.toString(),
        'doctor_name': name.toString(),
      },
    );

    if (jsonDecode(res.body).length == 1) {
      print(jsonDecode(res.body));

      // Get.to(
      //   () => HomePage(
      //     doctorID: jsonDecode(res.body)[0]['doctor_id'],
      //     deviceId: jsonDecode(res.body)[0]['device_id'],
      //     doctorName: jsonDecode(res.body)[0]['doctor_name'],
      //     isAdmin: jsonDecode(res.body)[0]['roles_id'],
      //   ),
      // );
      return jsonDecode(res.body);
    } else {
      return 'not match';
    }
  }

  Future forgotPassword(String deviceNo, email, phone) async {
    var res = await http.post(
      Uri.parse(url + 'forgotPassword.php'),
      body: {
        'phone': phone.toString(),
        'doctor_name': email.toString(),
        'deviceNo': deviceNo.toString(),
      },
    );

    if (jsonDecode(res.body).length == 1) {
      // print(jsonDecode(res.body));
      return jsonDecode(res.body);
    } else {
      return 'not match';
    }
  }

  Future getClients(String sickID) async {
    var res = await http.post(Uri.parse(url + 'getClient.php'), body: {
      'id': sickID.toString(),
    });
    // print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future getDrugsClient(String doctoId) async {
    var res = await http.post(Uri.parse(url + 'getClientDrugs.php'), body: {
      // 'action': 'getClientDrugs',
      'doctor_id': doctoId.toString(),
    });
    return jsonDecode(res.body);
  }

  Future getSession(String doctoId) async {
    var res = await http.post(Uri.parse(url + 'getSession.php'), body: {
      'doctor_id': doctoId.toString(),
      // 'date': date.toString(),
    });
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }

  Future insertSessionSecretary(String secrtaryId, date, doctorId, temp, suger,
      weight, press, tall, puls, sickId) async {
    var res = await http.post(
      Uri.parse(url + 'insertSession.php'),
      body: {
        'doctor_id': doctorId.toString(),
        'secretary_id': secrtaryId.toString(),
        'date': date.toString(),
        'temp': temp.toString(),
        'suger': suger.toString(),
        'press': press.toString(),
        'weight': weight.toString(),
        'tall': tall.toString(),
        'pulse': puls.toString(),
        'sick_id': sickId.toString()
      },
    );
    if (jsonDecode(res.body) == 'Added') {
      Fluttertoast.showToast(msg: 'sucsess', backgroundColor: Colors.green);
    } else {
      print(jsonDecode(res.body));
      Fluttertoast.showToast(msg: 'Faild', backgroundColor: Colors.red);
    }
  }

  Future loginSecretary(String namesec, passsec) async {
    var res = await http.post(
      Uri.parse(url + 'LOGINSec.php'),
      body: {
        // 'action': '',
        'password': passsec.toString(),
        'secretary_name': namesec.toString(),
      },
    );
    if (jsonDecode(res.body).length == 1) {
      // print(jsonDecode(res.body));
      return jsonDecode(res.body);
    } else {
      return 'not match';
    }
  }

  Future<void> share() async {
    // await WhatsappShare.share(
    //   text: 'Example share text',
    //   linkUrl: 'https://flutter.dev/',
    //   phone: '911234567890',
    // );
  }

  Future<void> shareFile(String phone, text, filepath) async {
    // await getImage();
    // Directory? directory;
    // if (Platform.isAndroid) {
    //   directory = await getExternalStorageDirectory();
    // } else {
    //   directory = await getApplicationDocumentsDirectory();
    // }
    // print('${directory!.path} / ${_image.path}');
    // await WhatsappShare.shareFile(
    //   text: text,
    //   phone: phone,
    //   filePath: ["$filepath"],
    // );
  }

  Future<void> isInstalled() async {
    // final val = await WhatsappShare.isInstalled();
    // print('Whatsapp is installed: $val');
  }
  // Future<void> isInstalled() async {
  //   final val =
  //       await WhatsappShare.isInstalled(package: Package.businessWhatsapp);
  //   print('Whatsapp Business is installed: $val');
  // }
}

class Neomphorm extends StatelessWidget {
  // final String title;
  final double width;
  final Widget child;
  const Neomphorm(
      {Key? key,
      // required this.title,
      required this.width,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        child: Center(child: child),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          // shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4, 7),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white12,
              offset: Offset(-7, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class NeomphormDark extends StatelessWidget {
  // final String title;
  final double width;
  final Widget child;
  final Color color;
  const NeomphormDark(
      {Key? key,
      // required this.title,
      required this.width,
      required this.child,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        child: Center(child: child),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12),
          // shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: color,
              offset: const Offset(4, 7),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white12,
              offset: Offset(-7, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class BubelButton extends StatelessWidget {
  const BubelButton({
    Key? key,
    required this.width,
    // required this.height,
    required this.color,
    required this.child,
  }) : super(key: key);

  final double width;
  // final double height;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: [
            color.withOpacity(.2),
            color.withOpacity(.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [.1, .9],
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.deepPurple.shade700,
              offset: const Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1),
          BoxShadow(
              color: Colors.deepPurple.shade200,
              offset: const Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
