import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_scanner/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          // Background Image
          Image.asset(
            'assets/images/splash_image.jpeg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topCenter,
            fit: BoxFit.fitHeight,
          ),

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
          )
        ]),
      ),
    );
  }
}
