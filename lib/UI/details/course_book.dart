import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:kurikulumsmk/UI/widgets/course_book_group_dropdown.dart';
import 'package:kurikulumsmk/UI/widgets/course_dropdown.dart';
import 'package:kurikulumsmk/bloc/course_book_bloc.dart';
import 'package:kurikulumsmk/event/course_event_args.dart';
import 'package:kurikulumsmk/model/course_book.dart';

class CourseBookDetailScreen extends StatefulWidget {
  final int competencyId;
  
  const CourseBookDetailScreen(this.competencyId);

  @override
  CourseBookDetailScreenState createState() {
    return new CourseBookDetailScreenState(competencyId);
  }
}

class CourseBookDetailScreenState extends State<CourseBookDetailScreen> {
  final courseBookBloc = kiwi.Container().resolve<CourseBookBloc>();
  final int competencyId;

  CourseBookDetailScreenState(this.competencyId);

  @override
  void initState() {
    super.initState();
    courseBookBloc.reset();
    courseBookBloc.competencyId = competencyId;
  }

  @override
  Widget build(BuildContext context) {

    if (courseBookBloc.courseBookData.length < 1) {
      courseBookBloc.loadCourseBook.add(CourseBookEventArgs(courseBookBloc.competencyId, 1));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Buku Mapel"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: FlatButton(
              onPressed: () {
                courseBookBloc.showFilter.add(!courseBookBloc.filterVisible);
              },
              color: Colors.blue,
              padding: EdgeInsets.all(10.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconTheme(
                    data: IconThemeData(
                        color: Colors.white), 
                    child: Text('Filter', style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            ),
          ),
          StreamBuilder(
            stream: courseBookBloc.filterSelected,
            builder: (context, snapshot) {
              if (courseBookBloc.courseGroupData.length == 0 && courseBookBloc.filterVisible) {
                courseBookBloc.loadCourseGroup.add(null);
                courseBookBloc.selectedCourseGroup = null;
              }

              return Visibility(
                child: CourseBookFilter(courseBookBloc),
                visible: courseBookBloc.filterVisible,
              );
            }
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(5),
              child: StreamBuilder(
                stream: courseBookBloc.courseBooks,
                builder: (context, snapshot) {
                  int rowsPerPage = 1;

                  if (snapshot.data != null) {
                    courseBookBloc.courseBookData = snapshot.data as List<CourseBook>;
                    if (courseBookBloc.courseBookData.length > 0) {
                      rowsPerPage = courseBookBloc.courseBookData.length;
                    }
                  }

                  List<DataColumn> courseAllColumn = List<DataColumn>();
                  courseAllColumn.addAll(CourseBookColumn);

                  if (courseBookBloc.xSelected) {
                    courseAllColumn.addAll(CourseXColumn);
                  }

                  if (courseBookBloc.xiSelected) {
                    courseAllColumn.addAll(CourseXIColumn);
                  }

                  if (courseBookBloc.xiiSelected) {
                    courseAllColumn.addAll(CourseXIIColumn);
                  }

                  if (courseBookBloc.xiiiSelected) {
                    courseAllColumn.addAll(CourseXIIIColumn);
                  }

                  courseAllColumn.addAll(CourseLastColumn);

                  return PaginatedDataTable(
                    header: Text((courseBookBloc.selectedCourseGroup == null) ? "Muatan Nasional" : courseBookBloc.selectedCourseGroup.name),
                    rowsPerPage: rowsPerPage,
                    columns: courseAllColumn,
                    source: CourseBookDataSource(courseBookBloc.courseBookData, courseBookBloc));
                }
              ),
            ),
          )
        ],
      )
    );
  }
}

class CourseBookFilter extends StatelessWidget {
  final CourseBookBloc courseBookBloc;

  CourseBookFilter([this.courseBookBloc]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CourseBookGroupDropdown(courseBookBloc),
            CourseDropdown(courseBookBloc),
            StreamBuilder(
              stream: courseBookBloc.classValueChanged,
              builder: (context, snapshot) { 
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Checkbox(
                              value: courseBookBloc.xSelected,
                              onChanged: (bool e) { 
                                courseBookBloc.selectedClass["x"] = e;
                                courseBookBloc.xSelected = e;
                                courseBookBloc.classChanged.add(courseBookBloc.selectedClass);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text('X'),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Checkbox(
                              value: courseBookBloc.xiSelected,
                              onChanged: (bool e) { 
                                courseBookBloc.selectedClass["xi"] = e;
                                courseBookBloc.xiSelected = e;
                                courseBookBloc.classChanged.add(courseBookBloc.selectedClass);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text('XI'),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Checkbox(
                              value: courseBookBloc.xiiSelected,
                              onChanged: (bool e) { 
                                courseBookBloc.selectedClass["xii"] = e;
                                courseBookBloc.xiiSelected = e;
                                courseBookBloc.classChanged.add(courseBookBloc.selectedClass);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text('XII'),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Checkbox(
                              value: courseBookBloc.xiiiSelected,
                              onChanged: (bool e) { 
                                courseBookBloc.selectedClass["xiii"] = e;
                                courseBookBloc.xiiiSelected = e;
                                courseBookBloc.classChanged.add(courseBookBloc.selectedClass);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text('XIII'),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      courseBookBloc.loadCourseBook.add(CourseBookEventArgs(courseBookBloc.competencyId, courseBookBloc.selectedCourseGroup.id));
                      courseBookBloc.showFilter.add(false);
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const CourseBookColumn = <DataColumn>[
    DataColumn(
      label: const Text('Mata Pelajaran'),
    ),
  ];

const CourseXColumn = <DataColumn>[
    DataColumn(
      label: const Text('X'),
    ),
  ];

const CourseXIColumn = <DataColumn>[
    DataColumn(
      label: const Text('XI'),
    ),
  ];

const CourseXIIColumn = <DataColumn>[
    DataColumn(
      label: const Text('XII'),
    ),
  ];

const CourseXIIIColumn = <DataColumn>[
    DataColumn(
      label: const Text('XIII'),
    ),
  ];

const CourseLastColumn = <DataColumn>[
    DataColumn(
      label: const Text('BS'),
    ),
    DataColumn(
      label: const Text('BG'),
    ),
    DataColumn(
      label: const Text('Total'),
    ),
  ];

class CourseBookDataSource extends DataTableSource {
  final List<CourseBook> _courseBooks;
  final CourseBookBloc _courseBookBloc;

  CourseBookDataSource(this._courseBooks, this._courseBookBloc);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _courseBooks.length)
      return null;
    final CourseBook courseBook = _courseBooks[index];
    return DataRow.byIndex(
      index: index,
      cells: createDataCell(courseBook)
    );
  }

  List<DataCell> createDataCell(CourseBook courseBook) {
    List<DataCell> result = List<DataCell>();

    result.add(DataCell(Text('${courseBook.name}'), onTap: () {}));

    if (_courseBookBloc.xSelected) {
      result.add(DataCell(Text('${courseBook.x}'), onTap: () {}));
    }

    if (_courseBookBloc.xiSelected) {
      result.add(DataCell(Text('${courseBook.xi}'), onTap: () {}));
    }

    if (_courseBookBloc.xiiSelected) {
      result.add(DataCell(Text('${courseBook.xii}'), onTap: () {}));
    }

    if (_courseBookBloc.xiiiSelected) {
      result.add(DataCell(Text('${courseBook.xiii}'), onTap: () {}));
    }

    result.add(DataCell(Text('${courseBook.studentBook}'), onTap: () {}));
    result.add(DataCell(Text('${courseBook.teacherBook}'), onTap: () {}));
    result.add(DataCell(Text('${courseBook.total}'), onTap: () {}));

    return result;
  }

  @override
  int get rowCount => _courseBooks.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
