import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portal_berita/custom/customButton.dart';
import 'package:portal_berita/model/informasi_model.dart';
import 'package:portal_berita/network/network.dart';
import 'package:http/http.dart' as http;

class HomeInformasiEdit extends StatefulWidget {
  final InformasiModel model;
  final VoidCallback reload;
  const HomeInformasiEdit(this.model, this.reload, {super.key});

  @override
  State<HomeInformasiEdit> createState() => _HomeInformasiEditState();
}

class _HomeInformasiEditState extends State<HomeInformasiEdit> {
  final _key = GlobalKey<FormState>();

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

  late TextEditingController judulController;
  late TextEditingController deskripsiController;
  late TextEditingController isiController;

  setup() {
    judulController = TextEditingController(text: widget.model.judul);
    deskripsiController = TextEditingController(text: widget.model.deskripsi);
    isiController = TextEditingController(text: widget.model.isi);
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Processing..'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 16,
                ),
                Text("Please wait...")
              ],
            ),
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
                  'Go Back',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );

    var uri = Uri.parse(NetworkURL.informasiEdit());
    var request = http.MultipartRequest("POST", uri);

    request.fields['judul'] = judulController.text.trim();
    request.fields['deskripsi'] = deskripsiController.text.trim();
    request.fields['isi'] = isiController.text.trim();
    request.fields['informasiid'] = widget.model.id;

    if (_imageFile == null) {
      request.fields['gambar'] = widget.model.gambar;
    } else {
      var pic = await http.MultipartFile.fromPath("gambar", _imageFile!.path);
      request.files.add(pic);
    }

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
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Informasi',
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
                    ? Image.network(
                        '${NetworkURL.server}/informasi/${widget.model.gambar}')
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
                labelText: "Isikan deskripsi berita",
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
                labelText: "Isikan isi berita",
                icon: Icon(Icons.text_increase),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: CustomButton(
                "Edit",
                color: Colors.blue[800]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
