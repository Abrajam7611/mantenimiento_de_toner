import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text(
          'Correo de usuario autenticado: $email',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
