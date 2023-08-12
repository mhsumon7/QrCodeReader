import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrcode/const/const.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: AppText(
            text: 'Scan Qr Code',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext context) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.67,
                      // color: Colors.blue,
                      child: Center(
                        child: SingleChildScrollView(
                          child: _scanBarcode == 'Unknown'
                              ? Image.asset('assets/qrcode.gif',fit: BoxFit.cover,scale: 1.8,)
                              : _scanBarcode == '-1'
                                  ? Image.asset('assets/qrcode.gif')
                                  : SelectableText(
                                      _scanBarcode,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.robotoMono(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                          /*AppText(
                            text: '$_scanBarcode\n',textAlign: TextAlign.center,
                            fontSize: 20,
                            color: Colors.black,
                          ),*/
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: buildGestureDetector(context),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () => scanBarcodeNormal(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.qr_code_2,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              width: 10,
            ),
            AppText(
              text: 'Scan',
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
