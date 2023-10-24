import 'package:flutter/material.dart';
import 'package:portal_berita/screen/login/login.dart';

void main() {
  runApp(
    MaterialApp(
      home: const Login(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
