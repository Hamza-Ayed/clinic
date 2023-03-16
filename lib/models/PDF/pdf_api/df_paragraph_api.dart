import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'api_pdf.dart';

class PdfParagraphApi {
  static Future<File> generate(
      sickName,
      date,
      doctorName,
      ilac1,
      ilac2,
      ilac3,
      ilac4,
      ilac5,
      status,
      tempreture,
      age,
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
    final pdf = Document();

    final customFont =
        Font.ttf(await rootBundle.load('font/NizarBBCKurdish-Regular.ttf'));

    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        build: (context) => <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Paragraph(
                // alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 9),
                text: '‏بسم الله الرحمن الرحيم',
                style: TextStyle(
                  font: customFont,
                  fontSize: 19,
                ),
                textAlign: TextAlign.center),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Paragraph(
                          text: doctorName.toString(),
                          style: TextStyle(
                            font: customFont,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center),
                      Paragraph(
                          // alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(right: 9),
                          text: '‏     عيادة الدكتور   ',
                          style: TextStyle(
                            font: customFont,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  buildCustomHeader(doctorName.toString()),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Paragraph(
                      // alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 9),
                      text: '‏      ‏اسم المراجع   ',
                      style: TextStyle(
                        font: customFont,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center),
                  Paragraph(
                      // alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 9),
                      text: sickName.toString(),
                      style: TextStyle(
                        font: customFont,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center),
                  Paragraph(
                      text: age.toString() + ' Years Old',
                      style: TextStyle(
                        font: customFont,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.right),
                ],
              )
            ],
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),

          // ...buildBulletPoints(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Paragraph(
                text: date.toString(),
                style: TextStyle(
                  font: customFont,
                  fontSize: 16,
                ),
                textAlign: TextAlign.right),
            Paragraph(
                text: tempreture.toString() + ' C',
                style: TextStyle(
                  font: customFont,
                  fontSize: 26,
                ),
                textAlign: TextAlign.right),
          ]),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Positioned(
              right: 8,
              child: Container(
                // width: 20 * PdfPageFormat.cm,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 3,
                      color: PdfColors.blue400,
                    ),
                    top: BorderSide(
                      width: 2,
                      color: PdfColors.blue,
                    ),
                    bottom: BorderSide(
                      width: 3,
                      color: PdfColors.blue,
                    ),
                    left: BorderSide(
                      width: 2,
                      color: PdfColors.blue,
                    ),
                  ),
                ),

                child: Container(
                  padding: const EdgeInsets.all(9),
                  child: Paragraph(
                      text: status.toString(),
                      style: TextStyle(
                        font: customFont,
                        fontSize: 26,
                      ),
                      textAlign: TextAlign.right),
                ),
                // ]),

                //   ],
                // ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 10 * PdfPageFormat.cm,
                  // color: PdfColors.grey100,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 3,
                        color: PdfColors.red,
                      ),
                      top: BorderSide(
                        width: 2,
                        color: PdfColors.yellow,
                      ),
                      bottom: BorderSide(
                        width: 3,
                        color: PdfColors.green,
                      ),
                      left: BorderSide(
                        width: 2,
                        color: PdfColors.blue,
                      ),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        children: [
                          Paragraph(
                              text: mydrug1.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify),
                          Paragraph(
                              text: mydrug2.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.right),
                          Paragraph(
                              text: mydrug3.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                          Paragraph(
                              text: mydrug4.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                          Paragraph(
                              text: mydrug5.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 3,
                        color: PdfColors.red,
                      ),
                      top: BorderSide(
                        width: 2,
                        color: PdfColors.red,
                      ),
                      bottom: BorderSide(
                        width: 3,
                        color: PdfColors.green,
                      ),
                      left: BorderSide(
                        width: 3,
                        color: PdfColors.red,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('‏الأدوية التي تم أخذها في العيادة',
                        style: TextStyle(
                          font: customFont,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Header(
                child: Text(' ‏الأدوية',
                    style: TextStyle(
                      font: customFont,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center),
              ),
              Paragraph(
                  text: '‏الفحوصات المطلوبة',
                  style: TextStyle(
                    font: customFont,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.right),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  width: 8 * PdfPageFormat.cm,
                  // color: PdfColors.grey100,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 3,
                        color: PdfColors.red,
                      ),
                      top: BorderSide(
                        width: 2,
                        color: PdfColors.yellow,
                      ),
                      bottom: BorderSide(
                        width: 3,
                        color: PdfColors.green,
                      ),
                      left: BorderSide(
                        width: 2,
                        color: PdfColors.blue,
                      ),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        children: [
                          Paragraph(
                              text: ilac1.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify),
                          Paragraph(
                              text: ilac2.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.right),
                          Paragraph(
                              text: ilac3.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                          Paragraph(
                              text: ilac4.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                          Paragraph(
                              text: ilac5.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  width: 8 * PdfPageFormat.cm,
                  // color: PdfColors.grey100,
                  // alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 3,
                        color: PdfColors.blue400,
                      ),
                      top: BorderSide(
                        width: 2,
                        color: PdfColors.brown,
                      ),
                      bottom: BorderSide(
                        width: 3,
                        color: PdfColors.green,
                      ),
                      left: BorderSide(
                        width: 2,
                        color: PdfColors.green,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        children: [
                          Paragraph(
                              text: test1.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                          Paragraph(
                              text: test2.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                          Paragraph(
                              text: test3.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                          Paragraph(
                              text: test4.toString(),
                              style: TextStyle(
                                font: customFont,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left),
                          Paragraph(
                            text: test5.toString(),
                            style: TextStyle(
                              font: customFont,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Text('text')
            ],
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildLink(),
          SizedBox(height: 0.5 * PdfPageFormat.cm),

          // Paragraph(text: 'this is my home screennbmnbcmn'),
          // Paragraph(text: LoremText().paragraph(60)),
          // Paragraph(text: LoremText().paragraph(60)),
          // Paragraph(text: LoremText().paragraph(60)),
        ],
        // footer: (context) {
        //   final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

        //   return Container(
        //     alignment: Alignment.centerRight,
        //     margin: const EdgeInsets.only(top: 1 * PdfPageFormat.cm),
        //     child: Text(
        //       text,
        //       style: const TextStyle(color: PdfColors.black),
        //     ),
        //   );
        // },
      ),
    );
    return PdfApi.saveDocument(name: '$sickName .pdf', pdf: pdf);
  }

  static Widget buildCustomHeader(String doctorName) => Container(
        padding: const EdgeInsets.only(
            bottom: 5 * PdfPageFormat.mm, left: 5 * PdfPageFormat.mm),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 3,
              color: PdfColors.blue,
            ),
            left: BorderSide(
              width: 2,
              color: PdfColors.blue,
            ),
          ),
        ),
        child: Column(
          children: [
            // Text(
            //   doctorName.toString(),
            //   textDirection: TextDirection.rtl,
            //   style: const TextStyle(
            //     fontSize: 16,
            //     color: PdfColors.black,
            //   ),
            // ),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            PdfLogo(),
            // Image.network('src')
          ],
        ),
      );

  static Widget buildCustomHeadline() => Header(
        child: Text(
          'My Third Headline',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(color: PdfColors.red),
      );

  static Widget buildLink() => UrlLink(
        destination: 'https://play.google.com/store/apps/developer?id=MHAT',
        child: Text(
          'FaceDoctor For Apps  Call Us Now',
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue300,
          ),
        ),
      );

  static List<Widget> buildBulletPoints() => [
        Bullet(text: 'First Bullet'),
        Bullet(text: 'Second Bullet'),
        Bullet(text: 'Third Bullet'),
        Bullet(text: 'nbnbm')
      ];
}
