import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/course_book_bloc.dart';
import 'package:kurikulumsmk/event/course_event_args.dart';
import 'package:kurikulumsmk/model/course_group.dart';

class CourseBookGroupDropdown extends StatelessWidget {
  final CourseBookBloc courseBookBloc;

  CourseBookGroupDropdown(this.courseBookBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: courseBookBloc.courseGroups,
      builder: (context, snapshot) {
        if (!snapshot.hasData && courseBookBloc.courseGroupData.length < 1)
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
          stream: courseBookBloc.courseGroupValueChanged,
          builder: (context, valueChanged) {
            if (courseBookBloc.courseGroupData.length < 1) {
              courseBookBloc.courseGroupData = snapshot.data as List<CourseGroup>;
              courseBookBloc.courseGroupChanged.add(courseBookBloc.courseGroupData[0]);
            }

            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<CourseGroup>(
                  value: courseBookBloc.selectedCourseGroup,
                  hint: Text("Grup Mata Pelajaran", style: TextStyle(fontWeight: FontWeight.bold)),
                  items: courseBookBloc.courseGroupData.map((CourseGroup courseGroup) {
                      return DropdownMenuItem<CourseGroup>(
                        value: courseGroup,
                        child: Text(
                          courseGroup.name,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  onChanged: (CourseGroup newValue) {
                    courseBookBloc.courseGroupChanged.add(newValue);
                  },
                ),
              ),
            );
          }
        );
      });
  }
}