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