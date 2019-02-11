class Course {
  const Course({this.id, this.name, this.order, this.groupId});

  final int id;
  final int order;
  final int groupId;
  final String name;

  factory Course.fromJson(Map<String, dynamic> value) {
    return Course(
        id: value['id'],
        order: value['order'],
        groupId: value['group_id'],
        name: value['name'].toString());
  }
}

class CourseBook {
  const CourseBook({this.id, this.courseId, this.competencyId, this.name,
                        this.studentBook, this.teacherBook, this.total, this.x,
                        this.xi, this.xii, this.xiii});

  final int id, courseId, competencyId, studentBook, teacherBook, total;
  final String name, x, xi, xii, xiii;

  factory CourseBook.fromJson(Map<String, dynamic> value) {
    return CourseBook(
        id: value['id'],
        courseId: value['course_id'],
        name: value['name'].toString(),
        competencyId: value['competency_id'],
        studentBook: value['student_book'],
        teacherBook: value['teacher_book'],
        total: value['total'],
        x: value['x'].toString(),
        xi: value['xi'].toString(),
        xii: value['xii'].toString(),
        xiii: value['xiii'].toString());
  }
}

