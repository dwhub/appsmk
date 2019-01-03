import 'package:flutter/material.dart';
import 'package:kurikulumsmk/model/contact.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactState();
}

class _ContactState extends State<ContactScreen> {
  List<Contact> contact = Contact().getDummyData();

  Provinsi selectedProvinsi;
  List<Provinsi> provinsi = <Provinsi>[const Provinsi(1,"Jawa Tengah"), const Provinsi(2,"D.I.Y")];

  Kabupaten selectedKabupaten;
  List<Kabupaten> kabupaten = <Kabupaten>[const Kabupaten(1,"Sleman"), const Kabupaten(2,"Bantul")];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: DropdownButton<Provinsi>(
            value: selectedProvinsi,
            hint: Text("Provinsi"),
            onChanged: (Provinsi newValue) {
              setState(() {
                selectedProvinsi = newValue;
              });
            },
            items: provinsi.map((Provinsi provinsi) {
              return new DropdownMenuItem<Provinsi>(
                value: provinsi,
                child: new Text(
                  provinsi.name,
                  style: new TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: DropdownButton<Kabupaten>(
            value: selectedKabupaten,
            hint: Text("Kabupaten"),
            onChanged: (Kabupaten newValue) {
              setState(() {
                selectedKabupaten = newValue;
              });
            },
            items: kabupaten.map((Kabupaten kabupaten) {
              return new DropdownMenuItem<Kabupaten>(
                value: kabupaten,
                child: new Text(
                  kabupaten.name,
                  style: new TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: contact.length,
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 30.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            Text(
                              '${contact[position].person}',
                              style: new TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ]
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.phone),
                            Text(
                              '${contact[position].notelp}',
                              style: new TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ]
                        ),
                        Text(
                          '${contact[position].alamat}',
                          style: new TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ]
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

class Provinsi {
  const Provinsi(this.id,this.name);

  final String name;
  final int id;
}

class Kabupaten {
  const Kabupaten(this.id,this.name);

  final String name;
  final int id;
}