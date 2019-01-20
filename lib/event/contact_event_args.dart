class ContactEventArgs {
  final int page;
  final int pageSize;
  final int districtId;
  final int provinceId;

  ContactEventArgs(this.page, this.pageSize, {this.provinceId = 0, this.districtId = 0});
}