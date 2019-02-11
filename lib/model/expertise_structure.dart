
class ExpertiseStructure {
  ExpertiseStructure({this.id,
        this.parentId,
        this.name,
        this.children,
        this.isCompetency,
        this.isProgram,
        this.order,
        this.title});

  final int id, parentId;
  final String order;
  final String title;
  final String name;
  final List<ExpertiseStructure> children;
  final bool isProgram;
  final bool isCompetency;

  factory ExpertiseStructure.fromJson(Map<String, dynamic> value) {
    return ExpertiseStructure(
        id: value['id'],
        parentId: value['parent_id'],
        name: value['name'].toString(),
        children: (value['children'] != null) ? List<ExpertiseStructure>.from(
          value['children'].map((expertiseStructure) => ExpertiseStructure.fromJson(expertiseStructure))) : List<ExpertiseStructure>(),
        isCompetency: false,
        isProgram: false);
  }
}
