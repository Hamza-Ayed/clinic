import 'package:doctors/constant/colors.dart';
import 'package:doctors/pages/method.dart';
import 'package:flutter/material.dart';

class SickPageAdmin extends StatefulWidget {
  final List list;

  const SickPageAdmin({Key? key, required this.list}) : super(key: key);

  @override
  _SickPageAdminState createState() => _SickPageAdminState();
}

class _SickPageAdminState extends State<SickPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors Page ${widget.list.length}',
          style: tilte2Style,
        ),
        elevation: 0,
        backgroundColor: grey!,
      ),
      backgroundColor: grey!,
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          var res = widget.list[index];

          return NeomphormDark(
              width: .9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeomphormDark(
                        child: Text(res['name'].toString()),
                        color: nb3,
                        width: .3,
                      ),
                      NeomphormDark(
                        child: Text(res['gender'].toString()),
                        width: .15,
                        color:
                            res['gender'].toString() == 'male' ? news1 : news2,
                      ),
                      NeomphormDark(
                        child: Text(res['doctor_name'].toString()),
                        width: .4,
                        color: news2.withOpacity(.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeomphormDark(
                        child: Text(res['telphone'].toString()),
                        color: gren!.withOpacity(.7),
                        width: .3,
                      ),
                      NeomphormDark(
                        child: Text(res['site'].toString()),
                        width: .2,
                        color: nb2,
                      ),
                      NeomphormDark(
                        child: Text(res['birth_date'].toString()),
                        width: .3,
                        color: nb4,
                      ),
                    ],
                  )
                ],
              ),
              color: nb1.withOpacity(.4));
        },
      ),
    );
  }
}
