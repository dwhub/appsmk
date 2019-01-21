import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/details/alokasi_waktu.dart';
import 'package:kurikulumsmk/UI/details/buku_mapel.dart';
import 'package:kurikulumsmk/UI/details/course_duration.dart';
import 'package:kurikulumsmk/UI/details/ki_kd.dart';
import 'package:kurikulumsmk/UI/details/sekolah.dart';
import 'package:kurikulumsmk/model/expertise_structure.dart';

class CurriculumDetailScreen extends StatelessWidget {
  final ExpertiseStructure fields;
  final ExpertiseStructure program;
  final ExpertiseStructure expertise;

  const CurriculumDetailScreen(this.fields, this.program, this.expertise);

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
              leading: Text(fields.name.split(' ').first, style: TextStyle(fontWeight: FontWeight.w500)),
              title: Text('Bidang Keahlian:', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(fields.name.replaceFirst(new RegExp(fields.name.split(' ').first), ''), style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            ListTile(
              dense: true,
              leading: Text(program.name.split(' ').first, style: TextStyle(fontWeight: FontWeight.w500)),
              title: Text('Program Keahlian', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(program.name.replaceFirst(new RegExp(program.name.split(' ').first), ''), style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            ListTile(
              dense: true,
              leading: Text(expertise.name.split(' ').first, style: TextStyle(fontWeight: FontWeight.w500)),
              title: Text('Kompetensi Keahlian', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(expertise.name.replaceFirst(new RegExp(expertise.name.split(' ').first), ''), style: TextStyle(fontWeight: FontWeight.w500)),
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
                        debugPrint(expertise.id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDurationScreen(expertise.id),
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
                        debugPrint(expertise.id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlokasiWaktuDetailScreen(expertise.id),
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
                        debugPrint(expertise.id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SekolahDetailScreen(expertise.id),
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
                        debugPrint(expertise.id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KIAndKDDetailScreen(expertise.id),
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
                        debugPrint(expertise.id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BukuMapelDetailScreen(expertise.id),
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