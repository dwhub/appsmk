class ExpertiseField {
  const ExpertiseField({this.id, this.name, this.order});

  final int order;
  final String name;
  final int id;

  factory ExpertiseField.fromJson(Map<String, dynamic> value) {
    return ExpertiseField(
        id: value['id'],
        name: value['name'].toString(),
        order: value['order']);
  }
}
