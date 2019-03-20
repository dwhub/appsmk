import 'package:flutter/material.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kurikulumsmk/event/course_event_args.dart';
import 'package:kurikulumsmk/model/course_kikd.dart';
import 'package:kurikulumsmk/repository/course_repository.dart';

class KIKDDetailScreen extends StatefulWidget {
  final int courseId;
  final int competencyId;
  
  KIKDDetailScreen(this.courseId, this.competencyId);

  @override
  KIKDDetailScreenState createState() {
    return new KIKDDetailScreenState(courseId, competencyId);
  }
}

List<KIKD> data = List<KIKD>();

class KIKDDetailScreenState extends State<KIKDDetailScreen> {
  final int courseId;
  final int competencyId;

  KIKDDetailScreenState(this.courseId, this.competencyId);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: FutureBuilder<List<KIKD>>(
                  future: CourseRepository().fetchKIKDDetails(KIKDDetailEventArgs(competencyId, courseId)),
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                                    child: ListView.separated(
                                    separatorBuilder: (context, index) => Divider(),
                                    itemBuilder: (BuildContext context, int index) =>
                                      KIKDDetailItem(context, snapshots.data[index]),
                                    itemCount: snapshots.data.length,
                                  ),
                          ),
                        );
                      default:
                    }
                  })
              ),
          ],
        )
      ),
    );
  }

  _tryAgainButtonClick(bool _) => setState(() {});
}

class KIKDDetailItem extends StatelessWidget {
  const KIKDDetailItem(this.context, this.entry);

  final KIKD entry;
  final BuildContext context;

  Widget _buildTiles(KIKD root) {
    if (root.details.isEmpty) return ListTile(title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(alignment: Alignment.topLeft, child: Text('    ')),
        Align(alignment: Alignment.topLeft, child: Padding(
          padding: const EdgeInsets.all(6),
          child: Text(root.order + '. '),
        )),
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text(root.name)
          )
        )
      ],
    ), onTap: () {});
    return ExpansionTile(
      key: PageStorageKey<KIKD>(root),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(root.order + '. '),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(root.name),
            )
          ),
        ],
      ),
      children: root.details.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}