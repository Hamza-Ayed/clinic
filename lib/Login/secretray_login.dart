import 'dart:async';
import 'dart:ui';

import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/method.dart';
import 'package:doctors/pages/secretary_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_new.dart';

class SecretaryLoginPage extends StatefulWidget {
  const SecretaryLoginPage({Key? key}) : super(key: key);

  @override
  _SecretaryLoginPageState createState() => _SecretaryLoginPageState();
}

class _SecretaryLoginPageState extends State<SecretaryLoginPage>
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
  List secretary = [];
  List doctors = [];
  bool islogin = false;
  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
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
      duration: const Duration(
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

    Timer(const Duration(milliseconds: 500), () {
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
      backgroundColor: nb1,
      body: ScrollConfiguration(
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
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: news2,
                                )),
                            Text(
                              'FACE DOCTOR \nSecretary Page ',
                              style: TextStyle(
                                color: d3,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                wordSpacing: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // component1(
                          //     nameController,
                          //     Icons.account_circle_outlined,
                          //     'Doctor name...',
                          //     false,
                          //     false),
                          component1(emailController, Icons.email_outlined,
                              'Email...', false, true),
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
                                  setState(() {
                                    islogin = true;
                                  });
                                  await Methods()
                                      .loginSecretary(emailController.text,
                                          passController.text)
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg: 'Sucssess', backgroundColor: gren);
                                    setState(() {
                                      islogin = false;
                                    });
                                    print(value);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SecretaryPage(
                                            secretaryId: value[0]
                                                    ['secretary_id_tabi']
                                                .toString(),
                                            doctorId: value[0]['doctor_id']
                                                .toString(),
                                            doctorName: value[0]['clientName']
                                                .toString(),
                                            roleId:
                                                value[0]['roles_id'].toString(),
                                            secretaryName: value[0]
                                                    ['secretary_name']
                                                .toString(),
                                          ),
                                        ));
                                  });
                                },
                              ),
                              SizedBox(width: size.width / 20),
                              // component2(
                              //   'Forgotten password!',
                              //   2.58,
                              //   () {
                              //     HapticFeedback.lightImpact();
                              //     Fluttertoast.showToast(
                              //         msg: 'Forgotten password button pressed');
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   flex: 6,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       component2('Create a new Account', 2, () {
                    //         HapticFeedback.lightImpact();
                    //         Fluttertoast.showToast(
                    //             msg: 'Create a new account button pressed');
                    //       }),
                    //       SizedBox(height: size.height * .05),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
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
            child: islogin
                ? const CupertinoActivityIndicator(
                    radius: 22,
                  )
                : Text(
                    string,
                    style: TextStyle(color: Colors.white.withOpacity(.8)),
                  ),
          ),
        ),
      ),
    );
  }
}
