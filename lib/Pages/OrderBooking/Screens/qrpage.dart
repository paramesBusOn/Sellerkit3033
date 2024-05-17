import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';

class qrscanner extends StatefulWidget {
   qrscanner({Key? key}) : super(key: key);

  @override
  State<qrscanner> createState() => _qrscannerState();
}

class _qrscannerState extends State<qrscanner> {
  MobileScannerController cameraController =MobileScannerController();
  OrderNewController? orderNewController;
  List<Barcode> barcodes=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      barcodes.clear(); 
    });
   
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Mobile Scanner") 
        ),
        body: MobileScanner(

          controller: cameraController,
         onDetect: (capture){
 barcodes=capture.barcodes;
for(var barcode in barcodes){

context.read<OrderNewController>().scanneddataget(barcode.rawValue ??'',context);
}

         }, 
        ),

    );
  }
}