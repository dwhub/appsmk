import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/tiles/school_list_tile.dart';
import 'package:kurikulumsmk/common/placeholder_content.dart';
import 'package:kurikulumsmk/model/district.dart';
import 'package:kurikulumsmk/model/province.dart';
import 'package:kurikulumsmk/model/school.dart';
import 'package:kurikulumsmk/repository/school_repository.dart';
import 'package:kurikulumsmk/utils/constants.dart';

class DataSekolahScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataSekolahState();
}

class _DataSekolahState extends State<DataSekolahScreen> {
  //List<School> sekolah = School().getDummyData();
  bool filterVisible = false;

  Province selectedProvinsi;
  List<Province> provinsi = <Province>[const Province(id: 1, name: "Jawa Tengah"), const Province(id: 2, name: "D.I.Y")];

  District selectedKabupaten;
  List<District> kabupaten = <District>[const District(id: 1, name: "Sleman"), const District(id: 2, name: "Bantul")];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            setState(() {
              filterVisible = !filterVisible; //? false : true;
            });
          },
          color: Colors.blue,
          padding: EdgeInsets.all(10.0),
          child: Column( // Replace with a Row for horizontal icon + text
            children: <Widget>[
              IconTheme(
                  data: IconThemeData(
                      color: Colors.white), 
                  child: Icon(Icons.search),
              ),
            ],
          ),
        ),
        Visibility(
          child: SizedBox(
            height: 300,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: DropdownButton<Province>(
                      value: selectedProvinsi,
                      hint: Text("Provinsi"),
                      onChanged: (Province newValue) {
                        setState(() {
                          selectedProvinsi = newValue;
                        });
                      },
                      items: provinsi.map((Province provinsi) {
                        return new DropdownMenuItem<Province>(
                          value: provinsi,
                          child: new Text(
                            provinsi.name,
                            style: new TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          visible: filterVisible,
        ),
        Expanded(
          child: FutureBuilder<Schools>(
            future: SchoolRepository().fetchSchools(1, 20),
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
                  return SchoolsTile(schools: snapshots.data);
                default:
              }
            })
        )
      ],
    );
  }

  _tryAgainButtonClick(bool _) => setState(() {});
}

class SchoolsTile extends StatefulWidget {
  final Schools schools;

  SchoolsTile({Key key, this.schools}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SchoolsTileState();
}

class SchoolsTileState extends State<SchoolsTile> {
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.STABLE;
  final ScrollController scrollController = new ScrollController();

  List<School> schools;
  int currentPageNumber;

  @override
  void initState() {
    schools = widget.schools.schools;
    currentPageNumber = widget.schools.paging.page;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: onNotification,
        child: new ListView.builder(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            controller: scrollController,
            itemCount: schools.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return SchoolListTile(school: schools[index]);
            }));
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == LoadMoreStatus.STABLE) {
          loadMoreStatus = LoadMoreStatus.LOADING;
          SchoolRepository()
              .fetchSchools(currentPageNumber + 1, 20)
              .then((schoolsObject) {
            currentPageNumber = schoolsObject.paging.page;
            loadMoreStatus = LoadMoreStatus.STABLE;
            setState(() => schools.addAll(schoolsObject.schools));
          });
        }
      }
    }
    return true;
  }
}

// high level Function
var function = (String msg) => '!!!${msg.toUpperCase()}!!!';