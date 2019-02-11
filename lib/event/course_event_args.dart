class CourseDurationEventArgs {
  final int competencyId;
  final int groupId;

  CourseDurationEventArgs(this.competencyId, this.groupId);
}

class CourseAllocationEventArgs {
  final int competencyId;
  final int groupId;

  CourseAllocationEventArgs(this.competencyId, this.groupId);
}

class CourseKIKDEventArgs {
  final int competencyId;
  final int groupId;

  CourseKIKDEventArgs(this.competencyId, this.groupId);
}

class KIKDDetailEventArgs {
  final int competencyId;
  final int courseId;

  KIKDDetailEventArgs(this.competencyId, this.courseId);
}

class CourseBookEventArgs {
  final int competencyId;
  final int groupId;

  CourseBookEventArgs(this.competencyId, this.groupId);
}

class CourseEventArgs {
  final int competencyId;
  final int groupId;

  CourseEventArgs(this.competencyId, {this.groupId});
}