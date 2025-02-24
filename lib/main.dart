import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mantenimiento_toner/views/auth/email_login.dart';
import 'package:mantenimiento_toner/views/auth/forgot_password.dart';
import 'package:mantenimiento_toner/views/auth/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que Flutter esté inicializado
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mantenimiento Tóner',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/emailLogin': (context) => EmailLoginScreen(),
        '/forgotPassword': (context) => ForgotPasswordScreen(),
      },
    );
  }
}
