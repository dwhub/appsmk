class SchoolEventArgs {
  final int page;
  final int pageSize;
  final int districtId;
  final String subDistrict;
  final int provinceId;
  final int competencyId;
  final int schoolType;

  SchoolEventArgs(this.page, this.pageSize, {this.provinceId = 0, this.districtId = 0, this.subDistrict = "", this.competencyId = 0, this.schoolType = 0});
}