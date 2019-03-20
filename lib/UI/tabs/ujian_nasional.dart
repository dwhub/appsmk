import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/details/unnas_details.dart';
import 'package:kurikulumsmk/bloc/nexam_bloc.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:kurikulumsmk/model/national_exam.dart';
import 'package:kurikulumsmk/utils/text.dart';

class NationalExamScreen extends StatefulWidget {
  @override
  _NationalExamScreenState createState() => _NationalExamScreenState();
}

class _NationalExamScreenState extends State<NationalExamScreen> {
  final nationalExamBloc = kiwi.Container().resolve<NationalExamBloc>();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nationalExamBloc.reset();
  }

  @override
  Widget build(BuildContext context) {
    if (nationalExamBloc.neStructureData.length == 0) {
      nationalExamBloc.loadNationalExamStructure.add(null);
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Serba Serbi Ujian Nasional 2019"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: nationalExamBloc.nationalExamStructures,
                builder: (context, snapshot) {
                  if (!snapshot.hasData && nationalExamBloc.neStructureData.length < 1)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (snapshot.hasError)
                    return PlaceHolderContent(
                      title: "Problem Occurred",
                      message: "Cannot connect to internet please try again",
                      tryAgainButton: (e) { nationalExamBloc.loadNationalExamStructure.add(null); },
                    );

                  nationalExamBloc.neStructureData = snapshot.data as List<NationalExamStructure>;
                  return StreamBuilder(
                    stream: nationalExamBloc.searchValueChanged,
                    builder: (context, snapshot) {
                      List<NationalExamStructure> data = List<NationalExamStructure>();

                      if (snapshot.hasData && nationalExamBloc.searchText.length > 0) {
                        data = nationalExamBloc.filteredData;
                      } else {
                        data = nationalExamBloc.viewData;
                      }

                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          color: Colors.white.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) =>
                              NationalExamStructureItem(context, data[index], nationalExamBloc),
                            itemCount: data.length,
                          ),
                      ),
                    );
                  });
                }
              ),
            )
          ]
        ),
      ),
    );
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class NationalExamStructureItem extends StatelessWidget {
  final NationalExamBloc curriculumBloc;

  const NationalExamStructureItem(this.context, this.entry, this.curriculumBloc);

  final NationalExamStructure entry;
  final BuildContext context;

  Widget _buildTiles(NationalExamStructure root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Row(
          children: <Widget>[ 
            Text(TextAddin.addSpacing(root.spacing)),
            Flexible(
              child: Text(root.name)
            ),
          ]
        ),
        onTap: () {
        debugPrint(root.id.toString());

        String pdfPath;
        if (root.name.trim().toLowerCase() == "jadwal") {
          pdfPath = "jadwal_ujian_2019.pdf";
        } else if ((root.name.trim().toLowerCase() != "jadwal") && root.pdfPath.isEmpty) {
          pdfPath = "file-not-found.pdf";
        } else {
          pdfPath = root.pdfPath;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NationalExamDetailScreen(pdfPath, root.coverPath),
          ),
        );
      });
    }
    
    if (root.children.isNotEmpty) {
      return ExpansionTile(
        key: PageStorageKey<NationalExamStructure>(root),
        title: Row(
          children: <Widget>[
            Text(TextAddin.addSpacing(root.spacing)),
            Flexible(
              child: Text(root.name)
            ),
          ],
        ),
        children: root.children.map(_buildTiles).toList(),
      );
    } else {
      return ExpansionTile(
        key: PageStorageKey<NationalExamStructure>(root),
        title: Text(root.name),
        children: root.children.map(_buildTiles).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}