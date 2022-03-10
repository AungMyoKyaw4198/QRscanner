import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_scanner/scan_qr_gallery.dart';

import 'generate_qr_page.dart';
import 'scan_qr_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // logo
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.white,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/logo-small.png',
                    width: 50,
                    height: 63,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      'heckSafe',

                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                        fontStyle: FontStyle.normal,
                      ),
                      // style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Center(
              child: Text(
            'QR Scanner',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),

          const SizedBox(
            height: 200,
          ),
          //First Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScanQR()));
            },
            child: const Text(
              "Scan QR Code from Camera",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),

          // Second Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScanQRGalleryPage()));
            },
            child: const Text(
              "Scan QR Code from Gallery",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }
}
