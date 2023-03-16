import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';

class ImageView1 extends StatefulWidget {
  const ImageView1({Key? key}) : super(key: key);

  @override
  _ImageView1State createState() => _ImageView1State();
}

class _ImageView1State extends State<ImageView1> {
  List img = [];
  @override
  void initState() {
    Methods().getImage().then((value) {
      setState(() {
        img = value;
        print(img);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('img test'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: img.length,
          itemBuilder: (BuildContext context, int index) {
            var res = img[index];
            return Card(
              child: Column(
                children: [
                  Text(res['name'].toString()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
