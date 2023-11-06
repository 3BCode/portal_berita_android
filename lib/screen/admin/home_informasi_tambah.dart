import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:portal_berita/custom/customButton.dart';
import 'package:portal_berita/network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeInformasiTambah extends StatefulWidget {
  final VoidCallback reload;
  const HomeInformasiTambah(this.reload, {super.key});

  @override
  State<HomeInformasiTambah> createState() => _HomeInformasiTambahState();
}

class _HomeInformasiTambahState extends State<HomeInformasiTambah> {
  String? userid;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userid = preferences.getString("id");
    });
    print(userid);
  }

  File? _imageFile;
  final picker = ImagePicker();

  _pilihcamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        print('_image: $_imageFile');
      } else {
        print('No image selected');
      }
    });
  }

  final _key = GlobalKey<FormState>();
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController isiController = TextEditingController();

  cek() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      submit();
    }
  }

  submit() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const AlertDialog(
            title: Text('Processing..'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 16,
                ),
                Text("Please wait...")
              ],
            ),
          ),
        );
      },
    );

    var uri = Uri.parse(NetworkURL.informasiTambah());
    var request = http.MultipartRequest("POST", uri);

    request.fields['judul'] = judulController.text.trim();
    request.fields['deskripsi'] = deskripsiController.text.trim();
    request.fields['isi'] = isiController.text.trim();

    var pic = await http.MultipartFile.fromPath("gambar", _imageFile!.path);
    request.files.add(pic);

    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((a) {
      final data = jsonDecode(a);
      int value = data['value'];
      String message = data['message'];
      if (value == 1) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Information"),
                content: Text(message),
                actions: <Widget>[
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        Navigator.pop(context);
                        widget.reload();
                      });
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              );
            });
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Warning"),
              content: Text(message),
              actions: <Widget>[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Ok",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          },
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = SizedBox(
      width: double.infinity,
      height: 150.0,
      child: Image.asset('images/placeholder.png'),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Informasi',
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.white,
            fontFamily: 'MaisonNeue',
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
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(
              width: double.infinity,
              height: 150.0,
              child: InkWell(
                onTap: () {
                  _pilihcamera();
                },
                child: _imageFile == null
                    ? placeholder
                    : Image.file(
                        _imageFile!,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            TextFormField(
              validator: (e) {
                if (e == null || e.isEmpty) {
                  return "isikan judul berita";
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              minLines: 1,
              controller: judulController,
              decoration: const InputDecoration(
                hintText: "isikan judul berita",
                labelText: "Isikan judul berita",
                icon: Icon(Icons.text_increase),
              ),
            ),
            TextFormField(
              validator: (e) {
                if (e == null || e.isEmpty) {
                  return "isikan deskripsi berita";
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              minLines: 1,
              controller: deskripsiController,
              decoration: const InputDecoration(
                hintText: "isikan deskripsi berita",
                labelText: "isikan deskripsi berita",
                icon: Icon(Icons.text_increase),
              ),
            ),
            TextFormField(
              validator: (e) {
                if (e == null || e.isEmpty) {
                  return "isikan isi berita";
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              minLines: 1,
              controller: isiController,
              decoration: const InputDecoration(
                hintText: "isikan isi berita",
                labelText: "isikan isi berita",
                icon: Icon(Icons.text_increase),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                cek();
              },
              child: CustomButton(
                "Tambah",
                color: Colors.blue[800]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
