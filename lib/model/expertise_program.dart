class ExpertiseProgram {
  const ExpertiseProgram({this.id, this.name, this.order, this.field, this.fieldId});

  final int order;
  final String name;
  final int id;
  final String field;
  final String fieldId;

  factory ExpertiseProgram.fromJson(Map<String, dynamic> value) {
    return ExpertiseProgram(
        id: value['id'],
        name: value['name'].toString(),
        order: value['order'],
        field: value['expertise_field'].toString(),
        fieldId: value['expertis_field_id'].toString());
  }
}
