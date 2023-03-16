import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctors/constant/url.dart';
import 'package:doctors/db/db.dart';
import 'package:doctors/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'must_reg_page.dart';
import 'register.dart';
import 'secretary_page.dart';

class LoginScreen extends StatefulWidget {
  final String deviceNumber;

  const LoginScreen({Key? key, required this.deviceNumber}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController secpassController = TextEditingController();
  TextEditingController secemailController = TextEditingController();
  bool rememberpwd = false;
  bool sec = true;
  bool newDoctor = false;
  List doctor = [], secretary = [];
  var visable = const Icon(
    Icons.visibility,
    color: Color(0xff4c5166),
  );
  var visableoff = const Icon(
    Icons.visibility_off,
    color: Color(0xff4c5166),
  );
  late Box user = Hive.box('users');
  @override
  void initState() {
    // Hive.openBox('users');
    print(widget.deviceNumber);
    DBSql('Users').getData('Users').then((value) {
      if (value.isNotEmpty) {
        // CheckHealthSQL('Users').getData('Users').then((value) {
        setState(() {
          var decode = value;
          emailController.text = decode[0]['username'];
          passController.text = decode[0]['password'];
          print(decode);

          // if (decode.length == 1) {
          // login(email.text.toString(), pass.text.toString(),
          //     widget.deviceNumber.toString());
          //   Navigator.push(
          //     context,
          //     PageTransition(
          //       type: PageTransitionType.scale,
          //       alignment: Alignment.bottomCenter,
          //       child: HomePage(
          //         doctorID: doctor[0]['doctor_id'].toString(),
          //         deviceId: widget.deviceNumber.toString(),
          //       ),
          //     ),
          // );
          // }
        });
        // });
      } else {
        setState(() {
          newDoctor = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newDoctor
          ? Register(
              deviceID: widget.deviceNumber.toString(),
            )
          : AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff65b0bb),
                            Color(0xff5a4e48),
                            Color(0xff508c95),
                            Color(0xff467b82),
                            Color(0xff3c6970),
                            Color(0xff32585d),
                            Color(0xff28464a),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              const Text(
                                "Face Doctor ☺️",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     TextButton(
                              //         onPressed: () {
                              //           CheckHealthSQL('Users')
                              //               .deleteAll('Users')
                              //               .then((value) {
                              //             setState(() {
                              //               print(value.toString());
                              //             });
                              //           });
                              //         },
                              //         child: const Text('delete')),
                              //     TextButton(
                              //         onPressed: () {
                              //           CheckHealthSQL('Users')
                              //               .getData('Users')
                              //               .then((value) {
                              //             setState(() {
                              //               print(value.toString());
                              //             });
                              //           });
                              //         },
                              //         child: const Text('show')),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 100,
                              ),
                              buildEmail(emailController),
                              const SizedBox(
                                height: 50,
                              ),
                              buildPassword(passController),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildSecretaryPage(),
                                  buildForgetPassword()
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              buildLoginButton(),
                              const SizedBox(
                                height: 30,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     buildFacebook(),
                              //     buildGoogle(),
                              //     buildTwitter()
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 60,
                              // ),
                              // const Text(
                              //   "الشروط والاحكام",
                              //   style: TextStyle(color: Colors.white, fontSize: 10),
                              // )
                              TextButton(
                                  onPressed: () {
                                    DBSql('Users')
                                        .deleteAll('Users')
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Register(
                                                deviceID: widget.deviceNumber),
                                          ));
                                    });
                                  },
                                  child: const Text(
                                    'Delete if You are not Register',
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildEmail(TextEditingController email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff4c5166),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  Widget buildPassword(TextEditingController password) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          height: 60,
          child: TextField(
            controller: password,
            obscureText: sec,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      sec = !sec;
                    });
                  },
                  icon: sec ? visableoff : visable,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: const Icon(
                  Icons.vpn_key,
                  color: Color(0xff4c5166),
                ),
                hintText: "passwdord",
                hintStyle: const TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildSecretaryPage() {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          // Theme(
          //     data: ThemeData(unselectedWidgetColor: Colors.white),
          //     child: Checkbox(
          //       value: rememberpwd,
          //       checkColor: Colors.blueGrey,
          //       activeColor: Colors.white,
          //       onChanged: (value) {
          //         setState(() {
          //           rememberpwd != value;
          //         });
          //       },
          //     )),
          InkWell(
            onTap: () {
              AwesomeDialog(
                  context: context,
                  title: 'Secretary Page',
                  body: Column(
                    children: [
                      buildEmail(secemailController),
                      const SizedBox(
                        height: 50,
                      ),
                      buildPassword(secpassController),
                      const SizedBox(
                        height: 50,
                      ),
                      buildLoginSecButton()
                    ],
                  )).show();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SecretaryPage(),
              //     ));
            },
            child: const Text(
              "Secretary Page",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForgetPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: const Text("Send DeviceId to Login",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        onPressed: () {
          sendEmail('masahamdev@gmail.com');
          print(widget.deviceNumber.toString());
        },
      ),
    );
  }

  void sendEmail(String email) async {
    var url =
        'mailto:$email?subject=DeviceId&body=${widget.deviceNumber.toString()}';
    await launch(url);
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
    if (res.statusCode == 200) {
      var decode = jsonDecode(res.body);
      if (decode.length == 1) {
        print(decode);

        setState(() {
          doctor = decode;
        });
        if (int.parse(doctor[0]['session_period']) > 14 &&
            doctor[0]['reg'].toString() == '2') {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: const MustRegisterPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.bottomCenter,
              child: HomePage(
                isAdmin: 'no',
                doctorName: doctor[0]['clientName'].toString(),
                doctorID: doctor[0]['doctor_id'].toString(),
                deviceId: widget.deviceNumber.toString(),
              ),
            ),
          );
        }
        await DBSql('Users').getData('Users').then((value) {
          if (value.isEmpty) {
            DBSql('Users').insert({
              'username': emailController.text.toString(),
              'password': passController.text.toString(),
              'devicename': widget.deviceNumber.toString(),
            });
          } else {
            return print('User not null');
          }
        });
        Fluttertoast.showToast(
          msg: 'success',
        );
      }
    } else if (jsonDecode(res.body) == 'not match') {
      DBSql('Users').deleteAll('Users').then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(deviceID: widget.deviceNumber),
            ));
      });
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
    var decode = jsonDecode(res.body);
    if (decode.length == 1) {
      setState(() {
        secretary = decode;
        print(secretary);
      });
      Fluttertoast.showToast(
        msg: 'success',
      );
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.bottomCenter,
          child: SecretaryPage(
            secretaryId: '',
            doctorName: secretary[0]['doctor_name'],
            doctorId: secretary[0]['doctor_id'].toString(),
            roleId: secretary[0]['roles_id'].toString(),
            secretaryName: secretary[0]['secretary_name'],
          ),
        ),
      );
    }
  }

  Widget buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            await DBSql('Users').getData('Users').then((value) {
              if (value.isNotEmpty) {
                setState(() {
                  doctor = value;
                  emailController.text = doctor[0]['username'].toString();
                  passController.text = doctor[0]['password'].toString();
                });
              } else {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment.bottomCenter,
                      child: Register(deviceID: widget.deviceNumber)),
                );
                return print('User is null');
              }
            });
            await loginDoctor(emailController.text.toString(),
                passController.text.toString(), widget.deviceNumber.toString());

            await DBSql('Users').getData('Users').then((value) {
              if (value.isEmpty) {
                DBSql('Users').insert({
                  'username': emailController.text.toString(),
                  'password': passController.text.toString(),
                  'devicename': widget.deviceNumber.toString()
                });
              } else {
                //   return print('User not null');
              }
            });
            // print(doctor[0]['doctor_id'].toString());
          },
          // elevation: 5,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15),
          // ),
          // color: const Color(0xff3c6970),
          // padding: const EdgeInsets.all(30),
          child: const Text(
            "Login",
            style: TextStyle(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildLoginSecButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            // await CheckHealthSQL('Users').getData('Users').then((value) {
            //   if (value.isNotEmpty) {
            //     setState(() {
            //       doctor = value;
            //       secemail.text = doctor[0]['username'].toString();
            //       secpass.text = doctor[0]['password'].toString();
            //     });
            //   } else {
            //     return print('Secretary  null');
            //   }
            // });

            await loginSecretary(
              secemailController.text,
              secpassController.text,
            );
            // print(secretary[0]['device_id'].toString());
            // print(secemail.text);
            // await CheckHealthSQL('Users').getData('Users').then((value) {
            //   if (value.isEmpty) {
            //     CheckHealthSQL('Users').insert({
            //       'username': secemail.text.toString(),
            //       'password': secpass.text.toString(),

            //     });
            //   } else {
            //     return print('User not null');
            //   }
            // });
          },
          // elevation: 5,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15),
          // ),
          // color: const Color(0xFF342CA5),
          // padding: const EdgeInsets.all(30),
          child: const Text(
            "Login",
            style: TextStyle(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildFacebook() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/facebook.png"),
    );
  }

  Widget buildGoogle() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/search.png"),
    );
  }

  Widget buildTwitter() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/twitter.png"),
    );
  }
}
