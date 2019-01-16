import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/pages/kurikulum_detail.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kurikulumsmk/model/expertise_structure.dart';
import 'package:kurikulumsmk/repository/expertise_structure_repository.dart';

class KurikulumScreen extends StatefulWidget {
  @override
  _KurikulumScreenState createState() => _KurikulumScreenState();
}

List<ExpertiseStructure> data = List<ExpertiseStructure>();

class _KurikulumScreenState extends State<KurikulumScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                ),
                trailing: IconButton(icon: Icon(Icons.cancel), onPressed: () {
                  //controller.clear();
                  //onSearchTextChanged('');
                }),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<ExpertiseStructure>>(
            future: ExpertiseStructureRepository().fetchExpertiseStructures(),
            builder: (context, snapshots) {
              if (snapshots.hasError)
                return PlaceHolderContent(
                  title: "Problem Occurred",
                  message: "Cannot connect to internet please try again",
                  tryAgainButton: _tryAgainButtonClick,
                );
              switch (snapshots.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  data = snapshots.data;
                  return ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                            ExpertiseStructureItem(context, snapshots.data[index]),
                          itemCount: snapshots.data.length,
                        );
                default:
              }
            })
        )
      ]
    );
  }

  _tryAgainButtonClick(bool _) => setState(() {});
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class ExpertiseStructureItem extends StatelessWidget {
  const ExpertiseStructureItem(this.context, this.entry);

  final ExpertiseStructure entry;
  final BuildContext context;

  Widget _buildTiles(ExpertiseStructure root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.name), onTap: () {
      debugPrint(root.id.toString());

      ExpertiseStructure structureProgram = ExpertiseStructure();

      for (var fields in data) {
        for (var program in fields.children) {
          if (program.id == root.parentId) {
            structureProgram = program;
          }
        }
      }

      ExpertiseStructure structureRoot = ExpertiseStructure();

      for (var field in data) {
        if (field.id == structureProgram.parentId) {
          structureRoot = field;
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KurikulumDetailScreen(structureRoot, structureProgram, root),
        ),
      );
    });
    return ExpansionTile(
      key: PageStorageKey<ExpertiseStructure>(root),
      title: Text(root.name),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}