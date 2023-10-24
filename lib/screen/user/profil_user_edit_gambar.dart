import 'package:flutter/material.dart';
import 'package:portal_berita/model/profil_model.dart';

class ProfilUserEditGambar extends StatefulWidget {
  final ProfilModel model;
  final VoidCallback reload;
  const ProfilUserEditGambar(this.model, this.reload, {super.key});

  @override
  State<ProfilUserEditGambar> createState() => _ProfilUserEditGambarState();
}

class _ProfilUserEditGambarState extends State<ProfilUserEditGambar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Photo Profil',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
            fontFamily: 'Cairo',
          ),
        ),
        backgroundColor: Colors.blue[800],
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
