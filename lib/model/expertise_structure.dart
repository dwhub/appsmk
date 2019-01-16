
class ExpertiseStructure {
  ExpertiseStructure({this.id,
        this.parentId,
        this.name,
        this.children});

  final int id, parentId;
  final String name;
  final List<ExpertiseStructure> children;

  factory ExpertiseStructure.fromJson(Map<String, dynamic> value) {
    return ExpertiseStructure(
        id: value['id'],
        parentId: value['parent_id'],
        name: value['name'].toString(),
        children: (value['children'] != null) ? List<ExpertiseStructure>.from(
          value['children'].map((expertiseStructure) => ExpertiseStructure.fromJson(expertiseStructure))) : List<ExpertiseStructure>());
  }
}

abstract class IExpertiseStructureRepository {
  Future<List<ExpertiseStructure>> fetchExpertiseStructures();
}

class FetchExpertiseStructureException implements Exception {
  final _message;

  FetchExpertiseStructureException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}