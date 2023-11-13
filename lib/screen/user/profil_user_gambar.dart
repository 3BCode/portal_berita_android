import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:portal_berita/model/profil_model.dart';
import 'package:portal_berita/network/network.dart';

class ProfilUserGambar extends StatefulWidget {
  final ProfilModel model;
  const ProfilUserGambar(this.model, Future<void> Function() onRefresh, {super.key});

  @override
  State<ProfilUserGambar> createState() => _ProfilUserGambarState();
}

class _ProfilUserGambarState extends State<ProfilUserGambar> {
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(
          "${NetworkURL.server}../image/${widget.model.gambar}"),
    );
  }
}