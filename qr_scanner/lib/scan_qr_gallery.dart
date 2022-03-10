import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQRGalleryPage extends StatefulWidget {
  const ScanQRGalleryPage({Key? key}) : super(key: key);

  @override
  State<ScanQRGalleryPage> createState() => _ScanQRGalleryPageState();
}

class _ScanQRGalleryPageState extends State<ScanQRGalleryPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  String qrData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Scan QR"),
      ),
      body: Container(
          child: selectedImage != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.file(
                        File(selectedImage!.path),
                        width: 200,
                        height: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    qrData != ''
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: InkWell(
                                  onTap: () async {
                                    try {
                                      await launch(qrData);
                                    } catch (e) {
                                      const snackBar = SnackBar(
                                        content: Text('An error occured'),
                                        backgroundColor: Colors.red,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(qrData,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue)),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Icon(Icons.link)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () async {
                              await QrCodeToolsPlugin.decodeFrom(
                                      selectedImage!.path)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    qrData = value;
                                  });
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text('Cannot Scan this image!'),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }).onError((error, stackTrace) {
                                const snackBar = SnackBar(
                                  content: Text('An error occured'),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                            child: const Text('Scan')),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () async {
                              await _picker
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) {
                                setState(() {
                                  selectedImage = value;
                                });
                              }).onError((error, stackTrace) {
                                const snackBar = SnackBar(
                                  content: Text('An error occured'),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                            child: const Text('Select Image')),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            await _picker
                                .pickImage(source: ImageSource.gallery)
                                .then((value) {
                              setState(() {
                                selectedImage = value;
                              });
                            }).onError((error, stackTrace) {
                              const snackBar = SnackBar(
                                content: Text('An error occured'),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          },
                          child: const Text('Select Image')),
                    )
                  ],
                )),
    );
  }
}
