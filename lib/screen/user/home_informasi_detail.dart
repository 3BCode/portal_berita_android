import 'package:flutter/material.dart';
import 'package:portal_berita/model/informasi_model.dart';
import 'package:portal_berita/network/network.dart';
import 'package:portal_berita/screen/user/home_informasi_detail_gambar.dart';

class HomeInformasiDetail extends StatefulWidget {
  final InformasiModel model;
  const HomeInformasiDetail(this.model, {super.key});

  @override
  State<HomeInformasiDetail> createState() => _HomeInformasiDetailState();
}

class _HomeInformasiDetailState extends State<HomeInformasiDetail> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.model.judul,
          style: const TextStyle(
            fontSize: 10.0,
            color: Colors.black,
            fontFamily: 'MaisonNeue',
          ),
        ),
        backgroundColor: Colors.grey[50],
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeInformasiDetailGambar(widget.model),
                        ),
                      );
                    },
                    child: Image.network(
                      "${NetworkURL.server}../informasi/${widget.model.gambar}",
                      fit: BoxFit.fill,
                      height: 180,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Tanggal Posting ${widget.model.tanggal}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.model.judul,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontFamily: 'MaisonNeue',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.model.deskripsi,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.model.isi,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Divider(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
