import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';

class MustRegisterPage extends StatelessWidget {
  const MustRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text(
          'Must Register ',
          style: tilte2Style,
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SizedBox(
          height: 100,
          child: BubelButton(
            color: d1,
            child: Column(
              children: [
                Text(
                  'You Have Register for Continue',
                  style: tilte2Style,
                ),
                TextButton(
                  onPressed: () async {
                    Methods().sendWhatssApp('0798583052', '');
                  },
                  child: NeomphormDark(
                    child: const Text('‏تواصل معنا'),
                    color: d1,
                    width: .3,
                  ),
                )
              ],
            ),
            width: 322,
          ),
        ),
      ),
    );
  }
}
