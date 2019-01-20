class District {
  const District({this.id, this.name});

  final String name;
  final int id;

  factory District.fromJson(Map<String, dynamic> value) {
    return District(
        id: value['id'],
        name: value['name'].toString());
  }
}
