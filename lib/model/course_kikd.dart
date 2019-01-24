class CourseKIKD {
  const CourseKIKD({this.id, this.name, this.order, this.group,
                    this.competencyId, this.parentId, this.haveChildren});

  final int id;
  final int order;
  final int group;
  final int competencyId;
  final String name;
  final int parentId;
  final bool haveChildren;

  factory CourseKIKD.fromJson(Map<String, dynamic> value) {
    return CourseKIKD(
        id: value['id'],
        order: value['order'],
        group: value['group'],
        competencyId: value['competency_id'],
        name: value['name'].toString(),
        parentId: value['parent_id'],
        haveChildren: value['have_children']);
  }
}

class KIKD {
  const KIKD({this.id, this.name, this.order, this.details});

  final int id;
  final String order;
  final String name;
  final List<KIKD> details;


  factory KIKD.fromJson(Map<String, dynamic> value) {
    return KIKD(
        id: value['id'],
        order: value['order'],
        name: value['name'].toString(),
        details: (value['kds'] != null) ? List<KIKD>.from(
          value['kds'].map((kd) => KIKD.fromJson(kd))) : List<KIKD>());
  }
}

class KD {
  const KD({this.id, this.name, this.order});

  final int id;
  final int order;
  final String name;

  factory KD.fromJson(Map<String, dynamic> value) {
    return KD(
        id: value['id'],
        order: value['order'],
        name: value['name'].toString());
  }
}