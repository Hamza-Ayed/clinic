import 'package:doctors/models/PDF/pdf_api/api_pdf.dart';
import 'package:doctors/models/PDF/pdf_api/df_paragraph_api.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({
    Key? key,
    required this.titletpPDF,
    required this.date,
  }) : super(key: key);
  final String titletpPDF, date;
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // title:  Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonWidget(
                  text: 'Simple PDF',
                  onClicked: () async {
                    final pdfFile =
                        await PdfApi.generateCenteredText('Sample Text');

                    PdfApi.openFile(pdfFile);
                  },
                ),
                const SizedBox(height: 24),
                ButtonWidget(
                  text: 'Paragraphs PDF',
                  onClicked: () async {
                    final pdfFile = await PdfParagraphApi.generate(
                      widget.titletpPDF.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                      widget.date.toString(),
                    );

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
