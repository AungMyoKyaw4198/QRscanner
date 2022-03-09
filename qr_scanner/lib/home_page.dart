import 'package:flutter/material.dart';

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
          const Center(
              child: Text(
            'QR Scanner',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
              "Scan QR Code",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),

          //Second Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GenerateQR()));
            },
            child: const Text(
              "Generate QR Code",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }
}
