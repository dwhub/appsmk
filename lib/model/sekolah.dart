class Sekolah {
  String npsn;
  String nama;
  String alamat;
  String kecamatan;
  String kabupaten;
  String provinsi;

  Sekolah([this.npsn,
        this.nama,
        this.alamat,
        this.kecamatan,
        this.kabupaten,
        this.provinsi]);

  List<Sekolah> getDummyData() {
    List<Sekolah> result = new List<Sekolah>();

    result.add(Sekolah("11222","SMK1N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("10111","SMK2N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("20392","SMK3N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("39281","SMK4N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("28234","SMK5N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("17892","SMK6N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("12384","SMK7N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("19283","SMK8N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));

    return result;
  }
}