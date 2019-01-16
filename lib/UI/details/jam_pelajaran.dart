import 'package:flutter/material.dart';

class JamPelajaranDetailScreen extends StatelessWidget {
  final int id;
  
  const JamPelajaranDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jam Pelajaran"),
      ),
      body: Text('Jam Pelajaran'),
    );
  }
}