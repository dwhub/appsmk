import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/course_allocation_bloc.dart';
import 'package:kurikulumsmk/event/course_duration_event_args.dart';
import 'package:kurikulumsmk/model/course_group.dart';

class CourseAllocationGroupDropdown extends StatelessWidget {
  final CourseAllocationBloc courseAllocationBloc;

  CourseAllocationGroupDropdown(this.courseAllocationBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: courseAllocationBloc.courseGroups,
      builder: (context, snapshot) {
        if (!snapshot.hasData && courseAllocationBloc.courseGroupData.length < 1)
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 15.0,
                width: 15.0,
              ),
            ),
          );

        return StreamBuilder(
          stream: courseAllocationBloc.courseGroupValueChanged,
          builder: (context, valueChanged) {
            if (courseAllocationBloc.courseGroupData.length < 1) {
              courseAllocationBloc.courseGroupData = snapshot.data as List<CourseGroup>;
              courseAllocationBloc.courseGroupChanged.add(courseAllocationBloc.courseGroupData[0]);
              courseAllocationBloc.loadCourseAllocation.add(CourseAllocationEventArgs(courseAllocationBloc.competencyId, 
                            courseAllocationBloc.courseGroupData[0].id));
            }

            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<CourseGroup>(
                  value: courseAllocationBloc.selectedCourseGroup,
                  hint: Text("Grup Mata Pelajaran"),
                  items: courseAllocationBloc.courseGroupData.map((CourseGroup courseGroup) {
                      return DropdownMenuItem<CourseGroup>(
                        value: courseGroup,
                        child: Text(
                          courseGroup.name,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  onChanged: (CourseGroup newValue) {
                    courseAllocationBloc.courseGroupChanged.add(newValue);
                    courseAllocationBloc.loadCourseAllocation.add(CourseAllocationEventArgs(courseAllocationBloc.competencyId, 
                        newValue.id));
                  },
                ),
              ),
            );
          }
        );
      });
  }
}