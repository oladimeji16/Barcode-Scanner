import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Home(),
));

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = 'Hey there !';

  Future _scan() async{
    try{
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    }on PlatformException catch(ex){
      if(ex.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
          result = 'Camera perssion was denied';
        });
      }else{
        setState(() {
          result = 'Unkwon error $ex';
        });
      }
    }on FormatException{
      setState(() {
        result = "You pressed the back button before scanning";
      });
    }catch (ex){
      setState(() {
        result = 'Unkwon error $ex';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: SafeArea(
          child: Center(
            child:  Text(result, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
          ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _scan,
          label: Text('Scan'),
        icon: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}



