import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/course_duration_bloc.dart';
import 'package:kurikulumsmk/event/course_duration_event_args.dart';
import 'package:kurikulumsmk/model/course_group.dart';

class CourseGroupDropdown extends StatelessWidget {
  final CourseDurationBloc courseDurationBloc;

  CourseGroupDropdown(this.courseDurationBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: courseDurationBloc.courseGroups,
      builder: (context, snapshot) {
        if (!snapshot.hasData && courseDurationBloc.courseGroupData.length < 1)
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
          stream: courseDurationBloc.courseGroupValueChanged,
          builder: (context, valueChanged) {
            if (courseDurationBloc.courseGroupData.length < 1) {
              courseDurationBloc.courseGroupData = snapshot.data as List<CourseGroup>;
              courseDurationBloc.courseGroupChanged.add(courseDurationBloc.courseGroupData[0]);
              courseDurationBloc.loadCourseDuration.add(CourseDurationEventArgs(courseDurationBloc.competencyId, 
                            courseDurationBloc.courseGroupData[0].id));
            }

            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<CourseGroup>(
                  value: courseDurationBloc.selectedCourseGroup,
                  hint: Text("Grup Mata Pelajaran"),
                  items: courseDurationBloc.courseGroupData.map((CourseGroup courseGroup) {
                      return DropdownMenuItem<CourseGroup>(
                        value: courseGroup,
                        child: Text(
                          courseGroup.name,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  onChanged: (CourseGroup newValue) {
                    courseDurationBloc.courseGroupChanged.add(newValue);
                    courseDurationBloc.loadCourseDuration.add(CourseDurationEventArgs(courseDurationBloc.competencyId, 
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