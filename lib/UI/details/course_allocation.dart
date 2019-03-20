import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:kurikulumsmk/UI/widgets/course_alloc_group_dropdown.dart';
import 'package:kurikulumsmk/bloc/course_allocation_bloc.dart';
import 'package:kurikulumsmk/model/course_allocation.dart';

class CourseAllocationDetailScreen extends StatefulWidget {
  final int id;
  
  const CourseAllocationDetailScreen(this.id);

  @override
  CourseAllocationDetailScreenState createState() {
    return new CourseAllocationDetailScreenState(id);
  }
}

class CourseAllocationDetailScreenState extends State<CourseAllocationDetailScreen> {
  final courseAllocationBloc = kiwi.Container().resolve<CourseAllocationBloc>();
  final int competencyId;

  CourseAllocationDetailScreenState(this.competencyId);

  @override
  void initState() {
    super.initState();
    courseAllocationBloc.reset();
    courseAllocationBloc.competencyId = competencyId;
  }

  @override
  Widget build(BuildContext context) {
    if (courseAllocationBloc.courseGroupData.length == 0) {
      courseAllocationBloc.loadCourseGroup.add(null);
      courseAllocationBloc.selectedCourseGroup = null;
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Alokasi Waktu"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: StreamBuilder(
                  stream: courseAllocationBloc.courseAllocations,
                  builder: (context, snapshot) {
                    int rowsPerPage = 1;

                    if (snapshot.data != null) {
                      courseAllocationBloc.courseAllocationData = snapshot.data as List<CourseAllocation>;
                      if (courseAllocationBloc.courseAllocationData.length > 0) {
                        rowsPerPage = courseAllocationBloc.courseAllocationData.length;
                      }
                    }

                    return PaginatedDataTable(
                      header: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CourseAllocationGroupDropdown(courseAllocationBloc),
                          Divider(),
                        ],
                      ),
                      rowsPerPage: rowsPerPage,
                      columns: CourseAllocationColumn,
                      source: CourseAllocationDataSource(courseAllocationBloc.courseAllocationData));
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

const CourseAllocationColumn = <DataColumn>[
    DataColumn(
      label: const Text('Mata Pelajaran'),
    ),
    DataColumn(
      label: const Text('Alokasi Waktu'),
    ),
  ];

class CourseAllocationDataSource extends DataTableSource {
  final List<CourseAllocation> _courseAllocations;

  CourseAllocationDataSource(this._courseAllocations);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _courseAllocations.length)
      return null;
    final CourseAllocation courseAllocation = _courseAllocations[index];
    if (courseAllocation.order != null) {
      return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          DataCell(Text('${courseAllocation.order}.  ${courseAllocation.name}'), onTap: () {}),
          DataCell(Text('${courseAllocation.timeAllocation}'), onTap: () {}),
        ]
      );
    } else {
      return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          DataCell(Text('${courseAllocation.name}', textAlign: TextAlign.center,), onTap: () {}),
          DataCell(Text('${courseAllocation.timeAllocation}'), onTap: () {}),
        ]
      );
    }
  }

  @override
  int get rowCount => _courseAllocations.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}