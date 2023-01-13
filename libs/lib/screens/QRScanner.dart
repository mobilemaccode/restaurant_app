import 'dart:async';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QRScanner extends StatefulWidget {
  @override
  QRScannerState createState() {
    return new QRScannerState();
  }
}

class QRScannerState extends State<QRScanner> {
  String _result = "Lets start to scan";

  Future _scanQr() async {
    debugPrint("scan touched");
    try {
      String qrResult = (await BarcodeScanner.scan()) as String;
      setState(() {
        _result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          _result = "The permission was denied.";
        });
      } else {
        setState(() {
          _result = "unknown error ocurred $ex";
        });
      }
    } on FormatException {
      setState(() {
        _result = "Scan canceled, try again !";
      });
    } catch (e) {
      _result = "Unknown error $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(_result),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: _scanQr,
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
