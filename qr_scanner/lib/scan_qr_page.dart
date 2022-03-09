import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
    // final expectedCodes = recognisedCodes.map((e) => e.type);
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      print(scanData.code);
      setState(() {
        result = scanData;
      });
      // if (expectedCodes.any((element) => scanData.code == element)) {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => OrderPage(
      //         item: recognisedCodes.firstWhere((element) => element.type == scanData.code),
      //       ),
      //     ),
      //   );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              // overlay: QrScannerOverlayShape(
              //   borderRadius: 10,
              //   borderWidth: 5,
              //   borderColor: Colors.white,
              // ),
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  icon: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Text('Flash: ${snapshot.data}');
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
                    icon: const Icon(Icons.cameraswitch))
              ],
            ),
          ),

          // Text
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: double.maxFinite,
              color: Colors.cyan.withOpacity(0.2),
              child: Center(
                child: Text(
                  'Place the camera to the QR code to scan.',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
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
