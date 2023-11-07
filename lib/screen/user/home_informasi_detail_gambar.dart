import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:portal_berita/model/informasi_model.dart';
import 'package:portal_berita/network/network.dart';

class HomeInformasiDetailGambar extends StatefulWidget {
  final InformasiModel model;
  const HomeInformasiDetailGambar(this.model, {super.key});

  @override
  State<HomeInformasiDetailGambar> createState() => _HomeInformasiDetailGambarState();
}

class _HomeInformasiDetailGambarState extends State<HomeInformasiDetailGambar> {
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(
          "${NetworkURL.server}../informasi/${widget.model.gambar}"),
    );
  }
}