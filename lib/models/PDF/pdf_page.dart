// import 'dart:io';

// import 'package:flutter/material.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:syncfusion_flutter_pdf/pdf.dart';

// // import 'mobile.dart';
// import 'dart:typed_data';
// import 'package:flutter/services.dart' show rootBundle;

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// import 'mobile.dart' if (dart.library.html) 'web.dart';

// class Pdf extends StatefulWidget {
//   const Pdf({Key? key}) : super(key: key);

//   @override
//   _PdfState createState() => _PdfState();
// }

// class _PdfState extends State<Pdf> {
//   Future<void> _createPDF() async {
//     PdfDocument document = PdfDocument();
//     final page = document.pages.add();
//     // final Uint8List fontData = File('font/Helvetica.ttf').readAsBytesSync();
//     // final PdfFont font = PdfTrueTypeFont(fontData, 12);
//     page.graphics.drawString("""
//     m,dlkalklkad
//     sgdkjhsdkj 
//     sdjhdkjasd sdbkasd asjdbasd kbsd a
//     aksdbkajdhj jd asdl
//     jbasdkjbakd 
    


//     bkjdaks jdbakjbd     ajsdbkajda d kk
//     """, PdfStandardFont(PdfFontFamily.helvetica, 20));

//     // page.graphics.drawImage(
//     //     PdfBitmap(await _readImageData('Pdf_Succinctly.jpg')),
//     //     const Rect.fromLTWH(0, 100, 440, 550));

//     PdfGrid grid = PdfGrid();
//     grid.style = PdfGridStyle(
//         font: PdfStandardFont(PdfFontFamily.helvetica, 30),
//         cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

//     grid.columns.add(count: 3);
//     grid.headers.add(1);

//     PdfGridRow header = grid.headers[0];
//     header.cells[0].value = 'Roll No';
//     header.cells[1].value = 'Name';
//     header.cells[2].value = 'Class';

//     PdfGridRow row = grid.rows.add();
//     row.cells[0].value = '1';
//     row.cells[1].value = 'Arya';
//     row.cells[2].value = '6';

//     row = grid.rows.add();
//     row.cells[0].value = '2';
//     row.cells[1].value = 'John';
//     row.cells[2].value = '9';

//     row = grid.rows.add();
//     row.cells[0].value = '3';
//     row.cells[1].value = 'Tony';
//     row.cells[2].value = '8';

//     grid.draw(
//         page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

//     List<int> bytes = document.save();
//     document.dispose();

//     saveAndLaunchFile(bytes, 'Output.pdf');
//   }

//   Future<Uint8List> _readImageData(String name) async {
//     final data = await rootBundle.load('assets/logo.png');
//     return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: TextButton.icon(
//             onPressed: () async {
//               // pdfPagePrint();
//               await _createPDF();
//             },
//             icon: const Icon(
//               Icons.location_pin,
//               color: Colors.red,
//             ),
//             label: const Text(
//               'pdf',
//             )),
//       ),
//     );
//   }
// }
