import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';
  List<String> tickets = [];

  // Metodo QRCode
  readQRCode() async {
    Stream<dynamic>? reader = await FlutterBarcodeScanner.getBarcodeStreamReceiver(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.BARCODE,
    );
    if(reader != null)
      reader.listen((code) {
        setState(() {
          if(! tickets.contains(code.toString()) && code != '-1')
            tickets.add(code.toString());
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // if (ticket != '')
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: 24.0),
                child: Text(
                  'Ticket: ${tickets.length}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ElevatedButton.icon(
              onPressed: readQRCode,
              icon: Icon(Icons.qr_code),
              label: Text('Validar'),
            )
          ],
        ),
      ),
    );
  }
}
