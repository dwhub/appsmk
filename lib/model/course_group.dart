class CourseGroup {
  const CourseGroup({this.id, this.name, this.code});

  final String code;
  final String name;
  final int id;

  Future<List<CourseGroup>> getData(dynamic e) async {
    List<CourseGroup> result = List<CourseGroup>();

    result.add(CourseGroup(id: 1, name: 'Muatan Nasional', code: 'A'));
    result.add(CourseGroup(id: 2, name: 'Muatan Kewilayahan', code: 'B'));
    //result.add(CourseGroup(id: 3, name: 'Muatan Peminatan Kejuruan', code: 'C'));
    result.add(CourseGroup(id: 4, name: 'Dasar Bidang Keahlian', code: 'C1'));
    result.add(CourseGroup(id: 5, name: 'Dasar Program Keahlian', code: 'C2'));
    result.add(CourseGroup(id: 6, name: 'Kompetensi Keahlian', code: 'C3'));

    return result;
  }

  factory CourseGroup.fromJson(Map<String, dynamic> value) {
    return CourseGroup(
        id: value['id'],
        name: value['name'].toString(),
        code: value['code'].toString());
  }
}