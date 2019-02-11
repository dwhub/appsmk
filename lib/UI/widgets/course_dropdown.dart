import 'package:flutter/material.dart';
import 'package:kurikulumsmk/bloc/course_book_bloc.dart';
import 'package:kurikulumsmk/model/course_book.dart';

class CourseDropdown extends StatelessWidget {
  final CourseBookBloc courseBookBloc;

  CourseDropdown(this.courseBookBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: courseBookBloc.courses,
      builder: (context, snapshot) {
        if (!snapshot.hasData && courseBookBloc.courseData.length < 1)
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
          stream: courseBookBloc.courseValueChanged,
          builder: (context, valueChanged) {
            if (courseBookBloc.courseData.length < 1) {
              courseBookBloc.courseData = snapshot.data as List<Course>;
            }

            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<Course>(
                  value: courseBookBloc.selectedCourse,
                  hint: Text("Mata Pelajaran", style: TextStyle(fontWeight: FontWeight.bold)),
                  items: courseBookBloc.courseData.map((Course course) {
                      return DropdownMenuItem<Course>(
                        value: course,
                        child: Text(
                          course.name,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  onChanged: (Course newValue) {
                    courseBookBloc.courseChanged.add(newValue);
                  },
                ),
              ),
            );
          }
        );
      });
  }
}