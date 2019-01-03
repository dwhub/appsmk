import 'package:flutter/material.dart';

class KIAndKDDetailScreen extends StatelessWidget {
  final int id;
  
  const KIAndKDDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KI dan KD"),
      ),
      body: Text('KI dan KD'),
    );
  }
}