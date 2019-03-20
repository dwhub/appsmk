import 'package:flutter/material.dart';
import 'package:kurikulumsmk/repository/fs_repository.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class NationalExamDetailScreen extends StatefulWidget {
  final String pdfPath;
  final String coverPath;

  const NationalExamDetailScreen(this.pdfPath, this.coverPath);

  @override
  NationalExamDetailScreenState createState() {
    return NationalExamDetailScreenState(pdfPath, coverPath);
  }
}

class NationalExamDetailScreenState extends State<NationalExamDetailScreen> {
  final String pdfPath;
  final String coverPath;

  NationalExamDetailScreenState(this.pdfPath, this.coverPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.jpg"), fit: BoxFit.fill)),
      child: FutureBuilder(
        future: FileServerRepository().downloadFile(widget.pdfPath) ,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!=null) {
              return PDFViewerScaffold(
                appBar: AppBar(),
                path: snapshot.data
              );
            }
          } else {
              return Center(child: CircularProgressIndicator());
            }
        }
      )
    );
  }

  @override
  void dispose() {
    //PdfViewerPlugin.close();
    super.dispose();
  }
}
