import 'package:doctors/db/db.dart';
import 'package:doctors/models/checkdb.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';

class HealthChecks extends StatefulWidget {
  const HealthChecks({Key? key}) : super(key: key);

  @override
  State<HealthChecks> createState() => _HealthChecksState();
}

class _HealthChecksState extends State<HealthChecks> {
  bool isloading = true;

  List checks = [];
  void getSql() async {
    await DBSql('ChecksHealth').getData('ChecksHealth').then((value) {
      setState(() {
        checks = value;
        isloading = false;
      });
      // print('checks is ' '$checks');
      if (checks.isEmpty) {
        Methods().getHelthCheckstoSQL();
        // .then((value) {
        //   setState(() {
        //     checks = value;
        //     isloading = false;
        //   });

        //   for (var i = 0; i < checks.length; i++) {
        //     CheckHealthSQL('ChecksHealth').insert({
        //       'testName': checks[i]['testName'].toString(),
        //     }).then((value) {
        //       // print('inserted successfully : ' + value.toString());
        //     });
        //   }
        //   // print(checks);
        // });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSql();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أسماء الفحوصات الطبية'),
        actions: [
          IconButton(
              onPressed: () {
                DBSql('ChecksHealth').deleteAll('ChecksHealth').then((value) {
                  setState(() {
                    // print(value);
                    checks = [];
                  });
                });
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: isloading
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: checks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        checks[index]['testName'].toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(checks[index]['testName'].toString()),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
