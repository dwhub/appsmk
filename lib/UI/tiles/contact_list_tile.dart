import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kurikulumsmk/model/contact.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class ContactListTile extends StatelessWidget {
  ContactListTile({this.contact});
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        ),
        color: Colors.white,
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.blue[500], size: 22),
                    Text(
                      '${contact.name}',
                      style: new TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ]
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.phone, color: Colors.blue[500], size: 22),
                    GestureDetector(
                      child: new Text('${contact.phone}', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontStyle: FontStyle.italic)),
                      onTap: () {
                        Clipboard.setData(new ClipboardData(text: contact.phone));
                        launcher.launch('tel:' + contact.phone);
                      },
                    ),
                    /*Text(
                      '${contact.phone}',
                      style: new TextStyle(
                        fontSize: 16.0,
                      ),
                    ),*/
                  ]
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Text(
                  '${contact.address}',
                  style: new TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
            ]
          ),
        ),
      );
  }
}

/*ListView.builder(
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
                              '${contact[position].name}',
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
                              '${contact[position].phone}',
                              style: new TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ]
                        ),
                        Text(
                          '${contact[position].address}',
                          style: new TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ]
                    ),
                ],
              );
            }
          )*/