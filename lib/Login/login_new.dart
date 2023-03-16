// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctors/Login/secretray_login.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/db/db.dart';
import 'package:doctors/pages/home_page.dart';
import 'package:doctors/pages/method.dart';
import 'package:doctors/pages/must_reg_page.dart';
import 'package:doctors/pages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreenNew extends StatefulWidget {
  final String deviceNumber;

  const LoginScreenNew({Key? key, required this.deviceNumber})
      : super(key: key);
  @override
  _LoginScreenNewState createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends State<LoginScreenNew>
    with TickerProviderStateMixin {
  AnimationController? controller1;
  AnimationController? controller2;
  Animation<double>? animation1;
  Animation<double>? animation2;
  Animation<double>? animation3;
  Animation<double>? animation4;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phone = TextEditingController();
  List doctor = [];
  String devicNo = '';
  bool isloading = true;
  Future get() async {
    await DBSql('Users').getData('Users').then((value) {
      if (value.isNotEmpty) {
        if (value.length == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  // doctorID: '3',
                  doctorID: value[0]['doctorId'],
                  deviceId: value[0]['devicename'],
                  doctorName: value[0]['username'],
                  isAdmin: 'roles_id',
                ),
              ));
          setState(() {
            isloading = false;
          });
          Methods()
              .loginDoctor(
                  value[0]['username'],
                  value[0]['password'].toString(),
                  value[0]['devicename'].toString())
              .then((value) {
            setState(() {
              doctor = value;
              isloading = true;
              print(doctor);
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
          });
        }
      }
    });
  }

  @override
  void initState() {
    devicNo = widget.deviceNumber.toString();
    super.initState();
    get();
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1!,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1!.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1!,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2!,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2!.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2!,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(Duration(milliseconds: 500), () {
      controller1!.forward();
    });

    controller2!.forward();
  }

  @override
  void dispose() {
    controller1!.dispose();
    controller2!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff192028),
      body: Center(
        child: isloading
            ? ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: size.height * (animation2!.value + .58),
                          left: size.width * .21,
                          child: CustomPaint(
                            painter: MyPainter(50),
                          ),
                        ),
                        Positioned(
                          top: size.height * .98,
                          left: size.width * .1,
                          child: CustomPaint(
                            painter: MyPainter(animation4!.value - 30),
                          ),
                        ),
                        Positioned(
                          top: size.height * .5,
                          left: size.width * (animation2!.value + .8),
                          child: CustomPaint(
                            painter: MyPainter(30),
                          ),
                        ),
                        Positioned(
                          top: size.height * animation3!.value,
                          left: size.width * (animation1!.value + .1),
                          child: CustomPaint(
                            painter: MyPainter(60),
                          ),
                        ),
                        Positioned(
                          top: size.height * .1,
                          left: size.width * .8,
                          child: CustomPaint(
                            painter: MyPainter(animation4!.value),
                          ),
                        ),
                        Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.only(top: size.height * .1),
                                child: Text(
                                  'FACE DOCTOR ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    wordSpacing: 4,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // component1(
                                  //     nameController,
                                  //     Icons.account_circle_outlined,
                                  //     'Doctor name...',
                                  //     false,
                                  //     false),
                                  component1(
                                      emailController,
                                      Icons.email_outlined,
                                      'Email...',
                                      false,
                                      true),
                                  component1(passController, Icons.lock_outline,
                                      'Password...', true, false),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      component2(
                                        'LOGIN',
                                        2.58,
                                        () async {
                                          HapticFeedback.lightImpact();
                                          final bool isValid =
                                              EmailValidator.validate(
                                                  emailController.text);
                                          Fluttertoast.showToast(
                                              msg: 'Email is valid? ' +
                                                  (isValid ? 'yes' : 'no'));
                                          // print(nameController.text);
                                          // print(passController.text);
                                          // print(widget.deviceNumber);

                                          await Methods()
                                              .loginDoctor(
                                                  emailController.text,
                                                  passController.text,
                                                  widget.deviceNumber
                                                      .toString())
                                              .then((value) {
                                            setState(() {
                                              doctor = value;
                                              print(doctor);
                                            });
                                            if (int.parse(doctor[0]
                                                        ['session_period']) >
                                                    14 &&
                                                doctor[0]['reg'].toString() ==
                                                    '2') {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .scale,
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child:
                                                        const MustRegisterPage()),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type:
                                                      PageTransitionType.scale,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: HomePage(
                                                    isAdmin: 'no',
                                                    doctorName: doctor[0]
                                                            ['clientName']
                                                        .toString(),
                                                    doctorID: doctor[0]
                                                            ['doctor_id']
                                                        .toString(),
                                                    deviceId: widget
                                                        .deviceNumber
                                                        .toString(),
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                          await DBSql('Users')
                                              .getData('Users')
                                              .then((value) {
                                            if (value.isEmpty) {
                                              DBSql('Users').insert({
                                                'username': emailController.text
                                                    .toString(),
                                                'password': passController.text
                                                    .toString(),
                                                'devicename': widget
                                                    .deviceNumber
                                                    .toString(),
                                                'doctorId': doctor[0]
                                                        ['doctor_id']
                                                    .toString(),
                                              });
                                            } else {
                                              return print(value);
                                            }
                                          });
                                        },
                                      ),
                                      SizedBox(width: size.width / 20),
                                      component2(
                                        'Forgotten password!',
                                        2.58,
                                        () {
                                          HapticFeedback.lightImpact();
                                          AwesomeDialog(
                                              context: context,
                                              title:
                                                  'Please send your Phone Number',
                                              body: Column(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                          sigmaY: 15,
                                                          sigmaX: 15,
                                                        ),
                                                        child: Container(
                                                          height:
                                                              size.width / 8,
                                                          width:
                                                              size.width / 1.2,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                      size.width /
                                                                          30),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    .05),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: TextField(
                                                            controller:
                                                                emailController,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            14),
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .email),
                                                                hintText:
                                                                    'Your Email here',
                                                                hintStyle:
                                                                    const TextStyle(
                                                                        color: Colors
                                                                            .black38)),
                                                          ),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                          sigmaY: 15,
                                                          sigmaX: 15,
                                                        ),
                                                        child: Container(
                                                          height:
                                                              size.width / 8,
                                                          width:
                                                              size.width / 1.2,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                      size.width /
                                                                          30),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    .05),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: TextField(
                                                            controller: phone,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            14),
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .phone),
                                                                hintText:
                                                                    'Your Phone here',
                                                                hintStyle:
                                                                    const TextStyle(
                                                                        color: Colors
                                                                            .black38)),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              btnOkOnPress: () async {
                                                await Methods()
                                                    .forgotPassword(
                                                        widget.deviceNumber
                                                            .toString(),
                                                        emailController.text,
                                                        phone.text)
                                                    .then((value) {
                                                  print(value);
                                                  if (value.length == 1) {
                                                    Methods().sendWhatssApp(
                                                        phone.text,
                                                        'Your password is ${value[0]['password']}');
                                                  } else if (value ==
                                                      'not match') {
                                                    HapticFeedback.vibrate();
                                                    Fluttertoast.showToast(
                                                        toastLength:
                                                            Toast.LENGTH_LONG,
                                                        backgroundColor: d2,
                                                        msg: 'Not Match Sorry');
                                                  }
                                                });
                                              }).show();
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Forgotten password button pressed');
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  component2(
                                    'If I Secretary',
                                    2,
                                    () {
                                      HapticFeedback.lightImpact();

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SecretaryLoginPage()));
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  component2(
                                    'Create a new Account',
                                    2,
                                    () {
                                      HapticFeedback.lightImpact();
                                      Fluttertoast.showToast(
                                          msg:
                                              'Create a new account button pressed');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Register(
                                                deviceID: widget.deviceNumber
                                                    .toString()),
                                          ));
                                    },
                                  ),
                                  SizedBox(height: size.height * .05),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : CupertinoActivityIndicator(
                radius: 46,
              ),
      ),
    );
  }

  Widget component1(TextEditingController textController, IconData icon,
      String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: textController,
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            textInputAction:
                isEmail ? TextInputAction.next : TextInputAction.done,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
              colors: [d2, d4],
              stops: [.1, .9],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
