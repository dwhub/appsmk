import 'package:flutter/material.dart';

class AlokasiWaktuDetailScreen extends StatelessWidget {
  final int id;
  
  const AlokasiWaktuDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alokasi Waktu"),
      ),
      body: Text('Alokasi Waktu'),
    );
  }
}