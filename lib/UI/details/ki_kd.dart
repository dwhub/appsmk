import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:kurikulumsmk/UI/details/ki_kd_details.dart';
import 'package:kurikulumsmk/UI/widgets/course_kikd_group_dropdown.dart';
import 'package:kurikulumsmk/bloc/course_kikd_bloc.dart';
import 'package:kurikulumsmk/model/course_kikd.dart';

class KIAndKDDetailScreen extends StatefulWidget {
  final int id;
  
  const KIAndKDDetailScreen(this.id);

  @override
  KIAndKDDetailScreenState createState() {
    return new KIAndKDDetailScreenState(id);
  }
}

class KIAndKDDetailScreenState extends State<KIAndKDDetailScreen> {
  final courseKIKDBloc = kiwi.Container().resolve<CourseKIKDBloc>();
  final int competencyId;

  KIAndKDDetailScreenState(this.competencyId);

  @override
  void initState() {
    super.initState();
    courseKIKDBloc.reset();
    courseKIKDBloc.competencyId = competencyId;
  }

  @override
  Widget build(BuildContext context) {
    if (courseKIKDBloc.courseGroupData.length == 0) {
      courseKIKDBloc.loadCourseGroup.add(null);
      courseKIKDBloc.selectedCourseGroup = null;
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("KI dan KD"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: StreamBuilder(
                  stream: courseKIKDBloc.courseKIKDs,
                  builder: (context, snapshot) {
                    int rowsPerPage = 1;

                    if (snapshot.data != null) {
                      courseKIKDBloc.courseKIKDData = snapshot.data as List<CourseKIKD>;
                      if (courseKIKDBloc.courseKIKDData.length > 0) {
                        rowsPerPage = courseKIKDBloc.courseKIKDData.length;
                      }
                    }

                    return PaginatedDataTable(
                      header: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CourseKIKDGroupDropdown(courseKIKDBloc),
                          Divider(),
                        ],
                      ),
                      rowsPerPage: rowsPerPage,
                      columns: CourseKIKDColumn,
                      source: CourseKIKDDataSource(courseKIKDBloc.courseKIKDData, competencyId, context));
                  }
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}

const CourseKIKDColumn = <DataColumn>[
    DataColumn(
      label: const Text('Mata Pelajaran'),
    ),
  ];

class CourseKIKDDataSource extends DataTableSource {
  final List<CourseKIKD> _courseKIKDs;
  final BuildContext context;
  final int competencyId;

  CourseKIKDDataSource(this._courseKIKDs, this.competencyId, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _courseKIKDs.length)
      return null;
    final CourseKIKD courseKIKD = _courseKIKDs[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text((courseKIKD.parentId > 0) ? '    ${courseKIKD.name}' : '${courseKIKD.order}. ${courseKIKD.name}'), 
        onTap: () {
          if (!courseKIKD.haveChildren) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KIKDDetailScreen(courseKIKD.id, competencyId),
              ),
            );
          }
          return;
        }),
      ]
    );
  }

  @override
  int get rowCount => _courseKIKDs.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}