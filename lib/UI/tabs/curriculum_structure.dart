import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/pages/curriculum_detail.dart';
import 'package:kurikulumsmk/bloc/curriculum_bloc.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kurikulumsmk/model/expertise_structure.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class KurikulumScreen extends StatefulWidget {
  @override
  _KurikulumScreenState createState() => _KurikulumScreenState();
}

class _KurikulumScreenState extends State<KurikulumScreen> {
  final curriculumBloc = kiwi.Container().resolve<CurriculumBloc>();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    curriculumBloc.reset();
  }

  @override
  Widget build(BuildContext context) {
    if (curriculumBloc.expertiseStructureData.length == 0) {
      curriculumBloc.loadExpertiseStructure.add(null);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 50,
                  child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Icon(Icons.search, size: 30, color: Colors.blue,),
                      )),
                      Container(
                        width: 300,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                                hintText: 'Search', border: InputBorder.none),
                                onChanged: (String text) {
                                  curriculumBloc.searchExpertise.add(text);
                                },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(icon: Icon(Icons.cancel, color: Colors.blue,), onPressed: () {
                            textController.clear();
                            curriculumBloc.searchExpertise.add('');
                          }),
                        ),
                      ),
                    ],
                  )
                  /*ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                          onChanged: (String text) {
                            curriculumBloc.searchExpertise.add(text);
                          },
                    ),
                    trailing: IconButton(icon: Icon(Icons.cancel), onPressed: () {
                      textController.clear();
                      curriculumBloc.searchExpertise.add('');
                    }),
                  ), */
                ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: curriculumBloc.expertiseStructures,
            builder: (context, snapshot) {
              if (!snapshot.hasData && curriculumBloc.expertiseStructureData.length < 1)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (snapshot.hasError)
                return PlaceHolderContent(
                  title: "Problem Occurred",
                  message: "Cannot connect to internet please try again",
                  tryAgainButton: (e) { curriculumBloc.loadExpertiseStructure.add(null); },
                );

              curriculumBloc.expertiseStructureData = snapshot.data as List<ExpertiseStructure>;
              return StreamBuilder(
                stream: curriculumBloc.searchValueChanged,
                builder: (context, snapshot) {
                  List<ExpertiseStructure> data = List<ExpertiseStructure>();

                  if (snapshot.hasData && curriculumBloc.searchText.length > 0) {
                    data = curriculumBloc.filteredData;
                  } else {
                    data = curriculumBloc.viewData;
                  }

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) =>
                              ExpertiseStructureItem(context, data[index], curriculumBloc),
                            itemCount: data.length,
                          ),
                  ),
                );
              });
            }
          ),
        )
      ]
    );
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class ExpertiseStructureItem extends StatelessWidget {
  final CurriculumBloc curriculumBloc;

  const ExpertiseStructureItem(this.context, this.entry, this.curriculumBloc);

  final ExpertiseStructure entry;
  final BuildContext context;

  Widget _buildTiles(ExpertiseStructure root) {
    if (root.children.isEmpty && root.order != null) {
      return ListTile(
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('      '),
              Text(root.order),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                  child: Text(root.title),
                )
              ),
            ],
        ),
        onTap: () {
        debugPrint(root.id.toString());

        ExpertiseStructure structureProgram = ExpertiseStructure();

        for (var fields in curriculumBloc.expertiseStructureData) {
          for (var program in fields.children) {
            if (program.id == root.parentId) {
              structureProgram = program;
            }
          }
        }

        ExpertiseStructure structureRoot = ExpertiseStructure();

        for (var field in curriculumBloc.expertiseStructureData) {
          if (field.id == structureProgram.parentId) {
            structureRoot = field;
          }
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurriculumDetailScreen(structureRoot, structureProgram, root),
          ),
        );
      });
    } else if (root.children.isEmpty && root.order == null) {
      return ListTile(
        title: Text(root.name),
        onTap: () {
        debugPrint(root.id.toString());

        ExpertiseStructure structureProgram = ExpertiseStructure();

        for (var fields in curriculumBloc.expertiseStructureData) {
          for (var program in fields.children) {
            if (program.id == root.parentId) {
              structureProgram = program;
            }
          }
        }

        ExpertiseStructure structureRoot = ExpertiseStructure();

        for (var field in curriculumBloc.expertiseStructureData) {
          if (field.id == structureProgram.parentId) {
            structureRoot = field;
          }
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurriculumDetailScreen(structureRoot, structureProgram, root),
          ),
        );
      });
    }
    
    if (root.order != null) {
      return ExpansionTile(
        key: PageStorageKey<ExpertiseStructure>(root),
        title: Row(
          children: <Widget>[
            Text('   '),
            Text(root.order),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                child: Text(root.title),
              )
            ),
          ],
        ),
        children: root.children.map(_buildTiles).toList(),
      );
    } else {
      return ExpansionTile(
        key: PageStorageKey<ExpertiseStructure>(root),
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