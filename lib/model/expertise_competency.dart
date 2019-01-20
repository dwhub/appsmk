class ExpertiseCompetency {
  const ExpertiseCompetency({this.id, this.name, this.order, this.program, this.programId, this.duration});

  final int order;
  final String name;
  final int id;
  final String program;
  final String programId;
  final int duration;

  factory ExpertiseCompetency.fromJson(Map<String, dynamic> value) {
    return ExpertiseCompetency(
        id: value['id'],
        name: value['name'].toString(),
        order: value['order'],
        program: value['expertise_program'].toString(),
        programId: value['expertis_program_id'].toString(),
        duration: value['duration']);
  }
}
