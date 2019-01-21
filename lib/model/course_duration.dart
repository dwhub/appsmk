class CourseDuration {
  const CourseDuration({this.id, this.name, this.order, this.group,
                        this.competencyId, this.x1, this.x2, this.xi1,
                        this.xi2, this.xii1, this.xii2, this.xiii1,
                        this.xiii2});

  final int id;
  final int order;
  final int group;
  final int competencyId;
  final String name;
  final String x1;
  final String x2;
  final String xi1;
  final String xi2;
  final String xii1;
  final String xii2;
  final String xiii1;
  final String xiii2;

  factory CourseDuration.fromJson(Map<String, dynamic> value) {
    return CourseDuration(
        id: value['id'],
        order: value['order'],
        group: value['group'],
        competencyId: value['competency_id'],
        name: value['name'].toString(),
        x1: value['x1'].toString(),
        x2: value['x2'].toString(),
        xi1: value['xi1'].toString(),
        xi2: value['xi2'].toString(),
        xii1: value['xii1'].toString(),
        xii2: value['xii2'].toString(),
        xiii1: value['xiii1'].toString(),
        xiii2: value['xiii2'].toString(),);
  }
}
