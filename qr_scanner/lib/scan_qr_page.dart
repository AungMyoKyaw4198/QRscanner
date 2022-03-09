import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Scan QR Code"),
      ),
      body: Stack(
        children: [
          // QR area
          Align(
            alignment: Alignment.topCenter,
            child: QRView(
              cameraFacing: CameraFacing.front,
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderWidth: 5,
                borderColor: Colors.white,
              ),
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 50,
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      setState(() {});
                    },
                    icon: FutureBuilder(
                      future: controller?.getFlashStatus(),
                      builder: (context, snapshot) {
                        if (snapshot.data == true) {
                          return const Icon(
                            Icons.flash_auto,
                            color: Colors.indigo,
                          );
                        } else {
                          return const Icon(
                            Icons.flash_off,
                            color: Colors.indigo,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.cameraswitch,
                        color: Colors.indigo,
                      ))
                ],
              ),
            ),
          ),

          // Text
          result != null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                      child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 250,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'link : ',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              result!.code!,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  await launch(result!.code!);
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Go to Link'),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Icon(Icons.link)
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  result = null;
                                  controller!.resumeCamera();
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Retake'),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Icon(Icons.refresh)
                                ],
                              )),
                        ),
                      ],
                    ),
                  )),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
