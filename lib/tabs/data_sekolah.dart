import 'package:flutter/material.dart';
import 'package:kurikulumsmk/model/sekolah.dart';

class DataSekolahScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataSekolahState();
}

class _DataSekolahState extends State<DataSekolahScreen> {
  List<Sekolah> sekolah = Sekolah().getDummyData();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () => {},
          color: Colors.blue,
          padding: EdgeInsets.all(10.0),
          child: Column( // Replace with a Row for horizontal icon + text
            children: <Widget>[
              IconTheme(
                  data: IconThemeData(
                      color: Colors.white), 
                  child: Icon(Icons.search),
              ),
              Text("Detailed Filter",
                style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sekolah.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    title: Text(
                      '${sekolah[position].nama}',
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    subtitle: Text(
                      '${sekolah[position].alamat}',
                      style: new TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    leading: Text(
                      '${sekolah[position].npsn}',
                      style: new TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onTap: () => {},
                  ),
                ],
              );
            }
          )
        )
      ],
    );
  }
}