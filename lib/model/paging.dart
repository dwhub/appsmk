class Paging {
  Paging({this.page,
        this.size,
        this.total});
  
  final int page, size, total;

  factory Paging.fromJson(Map<dynamic, dynamic> value) {
    return Paging(
        page: value['page'],
        size: value['size'],
        total: value['total']);
  }
}