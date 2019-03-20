
class NationalEducationStructure {
  NationalEducationStructure({this.id,
        this.parentId,
        this.name,
        this.children,
        this.spacing,
        this.pdfPath,
        this.coverPath,
        this.hasChild
        });

  final int id, parentId;
  final String name, pdfPath, coverPath;
  final List<NationalEducationStructure> children;
  final int spacing;
  final bool hasChild;

  factory NationalEducationStructure.fromJson(Map<String, dynamic> value) {
    return NationalEducationStructure(
        id: value['id'],
        parentId: value['parent_id'],
        name: value['name'].toString(),
        spacing: value['spacing'],
        pdfPath: value['pdf_path'].toString(),
        coverPath: value['cover_path'].toString(),
        hasChild: value['has_child'],
        children: (value['children'] != null) ? List<NationalEducationStructure>.from(
          value['children'].map((ne) => NationalEducationStructure.fromJson(ne))) : List<NationalEducationStructure>());
  }
}