class SchoolEventArgs {
  final int page;
  final int pageSize;
  final int districtId;
  final int provinceId;
  final int competendyId;
  final int schoolType;

  SchoolEventArgs(this.page, this.pageSize, {this.provinceId = 0, this.districtId = 0, this.competendyId = 0, this.schoolType = 0});
}