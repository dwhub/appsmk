import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:kurikulumsmk/UI/widgets/course_group_dropdown.dart';
import 'package:kurikulumsmk/bloc/course_duration_bloc.dart';
import 'package:kurikulumsmk/model/course_duration.dart';

class CourseDurationScreen extends StatefulWidget {
  final int id;
  
  const CourseDurationScreen(this.id);

  @override
  CourseDurationScreenState createState() {
    return new CourseDurationScreenState(id);
  }
}

class CourseDurationScreenState extends State<CourseDurationScreen> {
  final courseDurationBloc = kiwi.Container().resolve<CourseDurationBloc>();
  final int competencyId;

  CourseDurationScreenState(this.competencyId);

  @override
  void initState() {
    super.initState();
    courseDurationBloc.reset();
    courseDurationBloc.competencyId = competencyId;
  }

  @override
  Widget build(BuildContext context) {
    if (courseDurationBloc.courseGroupData.length == 0) {
      courseDurationBloc.loadCourseGroup.add(null);
      courseDurationBloc.selectedCourseGroup = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Jam Pelajaran"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(5),
              child: StreamBuilder(
                stream: courseDurationBloc.courseDurations,
                builder: (context, snapshot) {
                  int rowsPerPage = 1;

                  if (snapshot.data != null) {
                    courseDurationBloc.courseDurationData = snapshot.data as List<CourseDuration>;
                    if (courseDurationBloc.courseDurationData.length > 0) {
                      rowsPerPage = courseDurationBloc.courseDurationData.length;
                    }
                  }

                  return PaginatedDataTable(
                    header: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CourseGroupDropdown(courseDurationBloc),
                        Divider(),
                      ],
                    ),
                    rowsPerPage: rowsPerPage,
                    columns: CourseDurationColumn,
                    source: CourseDurationDataSource(courseDurationBloc.courseDurationData));
                }
              ),
            ),
          )
        ],
      )
    );
  }
}

const CourseDurationColumn = <DataColumn>[
    DataColumn(
      label: const Text('Mata Pelajaran'),
    ),
    DataColumn(
      label: const Text('X - 1'),
    ),
    DataColumn(
      label: const Text('X - 2'),
    ),
    DataColumn(
      label: const Text('XI - 1'),
    ),
    DataColumn(
      label: const Text('XI - 2'),
    ),
    DataColumn(
      label: const Text('XII - 1'),
    ),
    DataColumn(
      label: const Text('XII - 2'),
    ),
    DataColumn(
      label: const Text('XIII - 1'),
    ),
    DataColumn(
      label: const Text('XIII - 2'),
    ),
  ];

class CourseDurationDataSource extends DataTableSource {
  final List<CourseDuration> _courseDurations;

  CourseDurationDataSource(this._courseDurations);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _courseDurations.length)
      return null;
    final CourseDuration courseDuration = _courseDurations[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${courseDuration.order}.  ${courseDuration.name}'), onTap: () {}),
        DataCell(Text('${courseDuration.x1}'), onTap: () {}),
        DataCell(Text('${courseDuration.x2}'), onTap: () {}),
        DataCell(Text('${courseDuration.xi1}'), onTap: () {}),
        DataCell(Text('${courseDuration.xi2}'), onTap: () {}),
        DataCell(Text('${courseDuration.xii1}'), onTap: () {}),
        DataCell(Text('${courseDuration.xii2}'), onTap: () {}),
        DataCell(Text('${courseDuration.xiii1}'), onTap: () {}),
        DataCell(Text('${courseDuration.xiii2}'), onTap: () {}),
      ]
    );
  }

  @override
  int get rowCount => _courseDurations.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}