import 'package:flutter/material.dart';

class SekolahDetailScreen extends StatelessWidget {
  final int id;
  
  const SekolahDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sekolah"),
      ),
      body: Text('Sekolah'),
    );
  }
}