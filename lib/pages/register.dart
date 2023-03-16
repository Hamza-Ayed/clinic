import 'package:doctors/Login/login_new.dart';
import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class Register extends StatefulWidget {
  final String deviceID;

  const Register({Key? key, required this.deviceID}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  bool sec = true;
  TextEditingController passController = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController clientName = TextEditingController();
  var visableoff = const Icon(
    Icons.visibility_off,
    color: Color(0xff4c5166),
  );
  var visable = const Icon(
    Icons.visibility,
    color: Color(0xff4c5166),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.close),
        //   onPressed: () => Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) =>
        //             LoginScreen(deviceNumber: widget.deviceID.toString()),
        //       )),
        // ),
        backgroundColor: const Color(0xff65b0bb),
        title: const Text('Create a New doctor'),
      ),
      // backgroundColor: ikea1,
      body: Stack(
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
                  // Color(0xff5a4e48),
                  Color(0xff508c95),
                  Color(0xff467b82),
                  Color(0xff3c6970),
                  Color(0xff32585d),
                  Color(0xff28464a),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    buildEmail(emailController),
                    const SizedBox(
                      height: 50,
                    ),
                    buildPassword(passController),
                    const SizedBox(
                      height: 50,
                    ),
                    buildTextfield(
                      clientName,
                      'Clinic Name',
                      'Clinic Name',
                      TextInputType.name,
                      const Icon(
                        Icons.control_point_duplicate_sharp,
                        color: Color(0xff4c5166),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    buildTextfield(
                      phone,
                      'Phone No.',
                      'Phone No.',
                      TextInputType.phone,
                      const Icon(
                        Icons.phone,
                        color: Color(0xff4c5166),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      // elevation: 5,
                      // shape: RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(15),
                      // ),
                      // color: const Color(0xff3c6970),
                      // padding: const EdgeInsets.all(30),
                      child: Text(
                        "Register a New Doctor Here",
                        style: TextStyle(
                            fontSize: 16,
                            color: nb3,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (emailController.text.isNotEmpty) {
                          await Methods()
                              .addNewDoctor(
                                  emailController.text.toString(),
                                  passController.text.toString(),
                                  phone.text.toString(),
                                  widget.deviceID.toString(),
                                  '1',
                                  clientName.text.toString(),
                                  DateTime.now().toString(),
                                  '1')
                              .then((value) {
                            // if (jsonDecode(value) == 'Added') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreenNew(
                                      deviceNumber: widget.deviceID),
                                ));
                            Methods().sendWhatssApp(phone.text,
                                'Hello from Face Doctor \n your Password is  ${passController.text}\n Your Name is ${emailController.text}\nand Your Clinic Name is\n ${clientName.text}');
                            // }
                          });
                        } else {
                          // Get.snackbar('you have enter email', 'message',
                          //     backgroundColor: Colors.red);
                        }
                      },
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
                // errorText: 'Username Can\'t Be Empty',
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

  Widget buildTextfield(TextEditingController controller, String text, hintText,
      TextInputType input, Icon icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
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
            controller: controller,
            keyboardType: input,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: icon,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black38)),
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
}
