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
    String _x1, _x2, _xi1, _xi2, _xii1, _xii2, _xiii1, _xiii2;

    if (value['x1'].toString() == '0') {
      _x1 = '-';
    } else {
      _x1 = value['x1'].toString();
    }

    if (value['x2'].toString() == '0') {
      _x2 = '-';
    } else {
      _x2 = value['x2'].toString();
    }

    if (value['xi1'].toString() == '0') {
      _xi1 = '-';
    } else {
      _xi1 = value['xi1'].toString();
    }

    if (value['xi2'].toString() == '0') {
      _xi2 = '-';
    } else {
      _xi2 = value['xi2'].toString();
    }

    if (value['xii1'].toString() == '0') {
      _xii1 = '-';
    } else {
      _xii1 = value['xii1'].toString();
    }

    if (value['xii2'].toString() == '0') {
      _xii2 = '-';
    } else {
      _xii2 = value['xii2'].toString();
    }

    if (value['xiii1'].toString() == '0') {
      _xiii1 = '-';
    } else {
      _xiii1 = value['xiii1'].toString();
    }

    if (value['xiii2'].toString() == '0') {
      _xiii2 = '-';
    } else {
      _xiii2 = value['xiii2'].toString();
    }

    return CourseDuration(
        id: value['id'],
        order: value['order'],
        group: value['group'],
        competencyId: value['competency_id'],
        name: value['name'].toString(),
        x1: _x1,
        x2: _x2,
        xi1: _xi1,
        xi2: _xi2,
        xii1: _xii1,
        xii2: _xii2,
        xiii1: _xiii1,
        xiii2: _xiii2);
  }
}
