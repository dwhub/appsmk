import 'package:flutter/material.dart';
import 'package:kurikulumsmk/model/school.dart';

class SchoolListTile extends StatelessWidget {
  SchoolListTile({this.school});
  final School school;

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
                  Icon(Icons.school, color: Colors.blue[500], size: 22),
                  Text(
                    ' ${school.name}',
                    style: new TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ]
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                'NPSN - ${school.npsn}',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Divider(),
            Text(
              '${school.address}',
              style: new TextStyle(
                fontSize: 13.0,
              ),
            ),
            Text(
              '${school.subDistrict}',
              style: new TextStyle(
                fontSize: 13.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                '${school.district}',
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

