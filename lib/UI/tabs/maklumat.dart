import 'package:flutter/material.dart';
import 'package:kurikulumsmk/utils/rich_text_view.dart';

class MaklumatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            Center(
              child: Text('\nMAKLUMAT', style: Theme.of(context).textTheme.title,),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: SafeArea(
                  child: RichTextView(
                    textAlign: TextAlign.justify,
                    text: "\nYang terhormat,"
                        "\n\nBapak/Ibu Kepala Sekolah Menengah Kejuruan (SMK)'"
                        "\ndi seluruh Indonesia'"
                        "\n\n     Dengan hormat,'"
                        "\n\n     Perlu kami sampaikan kepada Bapak/Ibu Kepala SMK di seluruh Indonesia bahwa dengan bangga kami meluncurkan Program Aplikasi Kurikulum SMK. Aplikasi tersebut dapat diunduh di Google Play Store, dengan tautan: https://play.google.com/store/apps/details?id=com.kurikulumsmk.kurikulumsmk. Kami mohon perkenan Bapak/Ibu mengunduh aplikasi tersebut."
                        "\n\n     Sebagai informasi, dalam Aplikasi Kurikulum SMK tersaji berbagai informasi yang berkaitan dengan SMK. Saat ini informasi yang utama ada dalam aplikasi tersebut meliputi Spektrum SMK, Struktur Kurikulum SMK, KI dan KD tiap-tiap mata pelajaran yang diajarkan di SMK, serta informasi mengenai SMK-SMK yang ada di seluruh Indonesia. Dalam hal ini, untuk informasi setiap sekolah meliputi nama dan alamat lengkap SMK serta Bidang Keahlian, Program Keahlian, dan Kompetensi Keahlian yang dimiliki setiap sekolah."
                        "\n\n     Mengapa kami menyajikan informasi tentang SMK sedemikian lengkap? Tidak lain karena kami ingin sekali berkontribusi kepada masyarakat luas yang ingin mengetahui berbagai hal mengenai SMK di Indonesia. Terutama, kepada para orang tua yang menginginkan anaknya bersekolah di SMK dan para siswa kelas IX SMP/MTs yang ingin melanjutkan pendidikannya di SMK, kami berusaha dengan aplikasi tersebut memberikan informasi selengkap-lengkapnya dan sejelas-jelasnya mengenai SMK-SMK yang tepat dimasuki sesuai minat dan bakat masing-masing."
                        "\n\n     Bapak/Ibu Kepala SMK yang kami hormati, sangat mungkin terjadi data-data SMK yang kami peroleh ada yang tidak tepat, karena terjadinya perubahan-perubahan kebijakan pengelolaan. Sebagai contoh, terjadinya penambahan Kompetensi Keahlian di suatu SMK atau sebaliknya karena ditutupnya suatu Kompetensi Keahlian di SMK yang lain.'),"
                        "\n\n     Berkenaan dengan hal tersebut, apabila ketika Bapak/Ibu membuka Aplikasi Kurikulum SMK dan mengetahui bahwa data-data mengenai SMK Bapak/Ibu terdapat ketidaksesuaian, kami mohon Bapak/Ibu bisa menginformasikan kepada kami melalui narahubung (contact person):"
                  ),
                ),
              ),
            ),
          ]
      )
    );
  }
}