import 'package:flutter/material.dart';

class BukuMapelDetailScreen extends StatelessWidget {
  final int id;
  
  const BukuMapelDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buku Mapel"),
      ),
      body: Text('Buku Mapel'),
    );
  }
}