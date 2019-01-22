class CourseAllocation {
  const CourseAllocation({this.id, this.name, this.order, this.group,
                        this.competencyId, this.timeAllocation});

  final int id;
  final int order;
  final int group;
  final int competencyId;
  final String name;
  final int timeAllocation;

  factory CourseAllocation.fromJson(Map<String, dynamic> value) {
    return CourseAllocation(
        id: value['id'],
        order: value['order'],
        group: value['group'],
        competencyId: value['competency_id'],
        name: value['name'].toString(),
        timeAllocation: value['time_allocation']);
  }
}
