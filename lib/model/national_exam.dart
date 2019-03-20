
class NationalExamStructure {
  NationalExamStructure({this.id,
        this.parentId,
        this.name,
        this.children,
        this.spacing,
        this.pdfPath,
        this.coverPath
        });

  final int id, parentId;
  final String name, pdfPath, coverPath;
  final List<NationalExamStructure> children;
  final int spacing;

  factory NationalExamStructure.fromJson(Map<String, dynamic> value) {
    return NationalExamStructure(
        id: value['id'],
        parentId: value['parent_id'],
        name: value['name'].toString(),
        spacing: value['spacing'],
        pdfPath: value['pdf_path'].toString(),
        coverPath: value['cover_path'].toString(),
        children: (value['children'] != null) ? List<NationalExamStructure>.from(
          value['children'].map((ne) => NationalExamStructure.fromJson(ne))) : List<NationalExamStructure>());
  }
}