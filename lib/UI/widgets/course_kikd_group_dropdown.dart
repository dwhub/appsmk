import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/course_kikd_bloc.dart';
import 'package:kurikulumsmk/event/course_event_args.dart';
import 'package:kurikulumsmk/model/course_group.dart';

class CourseKIKDGroupDropdown extends StatelessWidget {
  final CourseKIKDBloc courseKIKDBloc;

  CourseKIKDGroupDropdown(this.courseKIKDBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: courseKIKDBloc.courseGroups,
      builder: (context, snapshot) {
        if (!snapshot.hasData && courseKIKDBloc.courseGroupData.length < 1)
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
          stream: courseKIKDBloc.courseGroupValueChanged,
          builder: (context, valueChanged) {
            if (courseKIKDBloc.courseGroupData.length < 1) {
              courseKIKDBloc.courseGroupData = snapshot.data as List<CourseGroup>;
              courseKIKDBloc.courseGroupChanged.add(courseKIKDBloc.courseGroupData[0]);
              courseKIKDBloc.loadCourseKIKD.add(CourseKIKDEventArgs(courseKIKDBloc.competencyId, 
                            courseKIKDBloc.courseGroupData[0].id));
            }

            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<CourseGroup>(
                  value: courseKIKDBloc.selectedCourseGroup,
                  hint: Text("Grup Mata Pelajaran"),
                  items: courseKIKDBloc.courseGroupData.map((CourseGroup courseGroup) {
                      return DropdownMenuItem<CourseGroup>(
                        value: courseGroup,
                        child: Text(
                          courseGroup.name,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  onChanged: (CourseGroup newValue) {
                    courseKIKDBloc.courseGroupChanged.add(newValue);
                    courseKIKDBloc.loadCourseKIKD.add(CourseKIKDEventArgs(courseKIKDBloc.competencyId, 
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