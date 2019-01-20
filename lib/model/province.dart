class Province {
  const Province({this.id, this.name});

  final String name;
  final int id;

  factory Province.fromJson(Map<String, dynamic> value) {
    return Province(
        id: value['id'],
        name: value['name'].toString());
  }
}
