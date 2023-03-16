import 'package:doctors/models/PDF/pdf_api/api_pdf.dart';
import 'package:doctors/models/PDF/pdf_api/df_paragraph_api.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  final String reviewId, doctorName;

  const ReviewPage({Key? key, required this.reviewId, required this.doctorName})
      : super(key: key);
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review ' + widget.reviewId.toString()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  final pdfFile = await PdfParagraphApi.generate(
                    widget.reviewId.toString(),
                    DateTime.now().toString(),
                    widget.doctorName,
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                    DateTime.now().toString(),
                  );

                  PdfApi.openFile(pdfFile);
                },
                icon: const Icon(
                  Icons.print,
                  size: 40,
                )),
          )
        ],
      ),
      body: Center(),
    );
  }
}
