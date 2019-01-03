class Contact {
  String person;
  String notelp;
  String alamat;

  Contact([this.person,
        this.notelp,
        this.alamat]);

  List<Contact> getDummyData() {
    List<Contact> result = new List<Contact>();

    result.add(Contact("Arif Hidayat","081360190789","Jalan Geureute 1 No. 260, Kuta Padang, Kec. Johan Pahlawan, Meulaboh, Kab. Aceh Barat, Prov. Aceh"));
    result.add(Contact("Agus Setiyadi Zarkasi","081360190789","Jalan Tgk. Lampoh Bungong, No. 3A, 40 M dari kantor Geuchik Gampong Batoh, Desa Batoh, Kec. Leung Bata, Kota Banda Aceh, Prov. Aceh"));
    result.add(Contact("Nicko Roni Setiawan","081360190789","Jalan Geureute 1 No. 260, Kuta Padang, Kec. Johan Pahlawan, Meulaboh, Kab. Aceh Barat, Prov. Aceh"));
    result.add(Contact("Erdis Kamanjaya","081360190789","Jalan Pahlawan, Gang Semesta, Kel/Desa Batang Beruh, Kecamatan Sidikalang, Kab. Dairi, Prop. Sumatera Utara"));
    result.add(Contact("Achlul Chairi","081360190789","Jalan Komplek Mutiara Lorong 02 No. 07, Desa Alue Awe, Kec. Muara Dua, Kota Lhokseumawe, Prov. Aceh"));
    result.add(Contact("Nicko Roni Setiawan	","081360190789","Jalan Sengeda, Depan SMA Muhammadiyah Mampak, Kebayakan, Takengon, Kab. Aceh Tengah, Prov. Aceh"));
    result.add(Contact("Erdis Kamanjaya","081360190789","Jalan Pahlawan, Gang Semesta, Kel/Desa Batang Beruh, Kecamatan Sidikalang, Kab. Dairi, Prop. Sumatera Utara"));
    result.add(Contact("Arif Hidayat","081360190789","Jalan Komplek Mutiara Lorong 02 No. 07, Desa Alue Awe, Kec. Muara Dua, Kota Lhokseumawe, Prov. Aceh"));

    return result;
  }
}