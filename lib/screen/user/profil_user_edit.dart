import 'package:flutter/material.dart';
import 'package:portal_berita/model/profil_model.dart';

class ProfilUserEdit extends StatefulWidget {
  final ProfilModel model;
  final VoidCallback reload;
  const ProfilUserEdit(this.model, this.reload, {super.key});

  @override
  State<ProfilUserEdit> createState() => _ProfilUserEditState();
}

class _ProfilUserEditState extends State<ProfilUserEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profil',
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
