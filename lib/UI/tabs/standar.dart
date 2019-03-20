import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/details/unnas_details.dart';
import 'package:kurikulumsmk/bloc/nes_bloc.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:kurikulumsmk/model/national_education.dart';
import 'package:kurikulumsmk/utils/text.dart';

class NationalEducationScreen extends StatefulWidget {
  @override
  _NationalEducationScreenState createState() => _NationalEducationScreenState();
}

class _NationalEducationScreenState extends State<NationalEducationScreen> {
  final nationalEducationBloc = kiwi.Container().resolve<NationalEducationBloc>();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nationalEducationBloc.reset();
  }

  @override
  Widget build(BuildContext context) {
    if (nationalEducationBloc.neStructureData.length == 0) {
      nationalEducationBloc.loadNationalEducationStructure.add(null);
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
                stream: nationalEducationBloc.nationalExamStructures,
                builder: (context, snapshot) {
                  if (!snapshot.hasData && nationalEducationBloc.neStructureData.length < 1)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (snapshot.hasError)
                    return PlaceHolderContent(
                      title: "Problem Occurred",
                      message: "Cannot connect to internet please try again",
                      tryAgainButton: (e) { nationalEducationBloc.loadNationalEducationStructure.add(null); },
                    );

                  nationalEducationBloc.neStructureData = snapshot.data as List<NationalEducationStructure>;
                  return StreamBuilder(
                    stream: nationalEducationBloc.searchValueChanged,
                    builder: (context, snapshot) {
                      List<NationalEducationStructure> data = List<NationalEducationStructure>();

                      if (snapshot.hasData && nationalEducationBloc.searchText.length > 0) {
                        data = nationalEducationBloc.filteredData;
                      } else {
                        data = nationalEducationBloc.viewData;
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
                              NationalEducationStructureItem(context, data[index], nationalEducationBloc),
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
class NationalEducationStructureItem extends StatelessWidget {
  final NationalEducationBloc nationalEducationBloc;

  const NationalEducationStructureItem(this.context, this.entry, this.nationalEducationBloc);

  final NationalEducationStructure entry;
  final BuildContext context;

  Widget _buildTiles(NationalEducationStructure root) {
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

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NationalExamDetailScreen(root.pdfPath, root.coverPath),
          ),
        );
      });
    }
    
    if (root.children.isNotEmpty) {
      return ExpansionTile(
        key: PageStorageKey<NationalEducationStructure>(root),
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
        key: PageStorageKey<NationalEducationStructure>(root),
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