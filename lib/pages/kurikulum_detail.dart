import 'package:flutter/material.dart';
import 'package:kurikulumsmk/details/alokasi_waktu.dart';
import 'package:kurikulumsmk/details/buku_mapel.dart';
import 'package:kurikulumsmk/details/jam_pelajaran.dart';
import 'package:kurikulumsmk/details/ki_kd.dart';
import 'package:kurikulumsmk/details/sekolah.dart';

class KurikulumDetailScreen extends StatelessWidget {
  final int id;

  const KurikulumDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurikulum Detail"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ListTile(
              dense: true,
              leading: Text('1.', style: TextStyle(fontWeight: FontWeight.w500)),
              title: Text('Bidang Keahlian:', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Teknologi dan Rekayasa', style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            ListTile(
              dense: true,
              leading: Text('1.1.', style: TextStyle(fontWeight: FontWeight.w500)),
              title: Text('Program Keahlian', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Teknik Konstruksi dan Properti', style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            ListTile(
              dense: true,
              leading: Text('1.1.1.', style: TextStyle(fontWeight: FontWeight.w500)),
              title: Text('Kompetensi Keahlian', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Konstruksi Gedung, Sanitasi, dan Perawatan (4 Tahun)', style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            Divider(),
            SizedBox(
              height: 300,
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Jam Pelajaran'),
                      leading: Icon(
                        Icons.library_books,
                        color: Colors.blue[500],
                      ),
                      onTap: () { 
                        debugPrint(id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JamPelajaranDetailScreen(id),
                          ),
                        );
                      }
                    ),
                    ListTile(
                      title: Text('Alokasi Waktu'),
                      leading: Icon(
                        Icons.schedule,
                        color: Colors.blue[500],
                      ),
                      onTap: () { 
                        debugPrint(id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlokasiWaktuDetailScreen(id),
                          ),
                        );
                      }
                    ),
                    ListTile(
                      title: Text('Sekolah'),
                      leading: Icon(
                        Icons.school,
                        color: Colors.blue[500],
                      ),
                      onTap: () { 
                        debugPrint(id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SekolahDetailScreen(id),
                          ),
                        );
                      }
                    ),
                    ListTile(
                      title: Text('KI & KD'),
                      leading: Icon(
                        Icons.accessibility,
                        color: Colors.blue[500],
                      ),
                      onTap: () { 
                        debugPrint(id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KIAndKDDetailScreen(id),
                          ),
                        );
                      }
                    ),
                    ListTile(
                      title: Text('Buku Mapel'),
                      leading: Icon(
                        Icons.book,
                        color: Colors.blue[500],
                      ),
                      onTap: () { 
                        debugPrint(id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BukuMapelDetailScreen(id),
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          ],
        )  
      ),
    );
  }
}

/*
        RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            Navigator.pop(context);
          },
          child: Text('Kurikulum Id ' + id.toString()),
        ),
        */