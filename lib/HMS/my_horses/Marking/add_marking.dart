import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/HMS/All_Horses_data/services/marking_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class addMarking extends StatefulWidget {
  var horseData;
  addMarking(this.horseData);
  @override
  State<StatefulWidget> createState() {
    return MarkingState(horseData);
  }
}

class MarkingState extends State<addMarking> {
  GlobalKey<SignatureState> signatureKey = GlobalKey();
  var image;
  var horseData;
  MarkingState(this.horseData);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: Text("Add Marking"),),
      body: Signature(key: signatureKey),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Back'),
          onPressed: () {
            Navigator.pop(context,"close");
          },
        ),
        FlatButton(
          child: Text('Clear'),
          onPressed: () {
            signatureKey.currentState.clearPoints();
          },
        ),
        FlatButton(
          child: Text('Save'),
          onPressed: () {
            setRenderedImage(context);
            sleep(Duration(seconds: 3));
            Navigator.pop(context,"close");
          },
        )
      ],
    );
  }

  setRenderedImage(BuildContext context) async {
    ui.Image renderedImage = await signatureKey.currentState.rendered;

    setState(() {
      image = renderedImage;
    });

    showImage(context);
  }

  Future<Null> showImage(BuildContext context) async {
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    String bs64 = base64Encode(pngBytes);
    print("Horse Id"+horseData['horseId'].toString());
    SharedPreferences.getInstance().then((prefs){
      ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
      pd.show();
      MarkingService.markingSave(prefs.getString('token'),horseData['horseId'], bs64).then((response){
        pd.dismiss();
        if(response !=null) {
          var decode= jsonDecode(response);
          if(decode['isSuccess'] == true){
            Flushbar(message: "Added Successfully",
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,)
              ..show(context);}
          else{
            Flushbar(message: "Not Added",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
        }else{
          Flushbar(message: "Not Added",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
      });
    });

//    return showDialog<Null>(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: Text(
//              'Please check your device\'s Signature folder',
//              style: TextStyle(
//                  fontWeight: FontWeight.w300,
//                  letterSpacing: 1.1
//              ),
//            ),
//            content: Image.memory(base64Decode(bs64)),
//          );
//        }
//    );
  }
}

class Signature extends StatefulWidget {
  Signature({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignatureState();
  }
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];
  var image;
  Future<ui.Image> get rendered {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    canvas.drawImage(image, Offset(0,250), Paint());
    SignaturePainter painter = SignaturePainter(points: _points,image: image);
    var size = context.size;
    painter.paint(canvas, size);
    return recorder.endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }
  @override
  void initState() {
    rootBundle.load('assets/HorseMarking.png').then((bd){
      Uint8List lst = new Uint8List.view(bd.buffer);
      ui.instantiateImageCodec(lst).then((codec){
        codec.getNextFrame().then((frameInfo){
          setState(() {
            image=frameInfo.image;
          });
        });
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox _object = context.findRenderObject();
              Offset _locationPoints = _object.localToGlobal(details.globalPosition);
              _points = new List.from(_points)..add(_locationPoints);
            });
          },
          onPanEnd: (DragEndDetails details) {
            setState(() {
              _points.add(null);
            });
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: SignaturePainter(points: _points,image: image),
          ),
        ),
      ),
    );
  }

  // clearPoints method used to reset the canvas
  // method can be called using
  //   key.currentState.clearPoints();
  void clearPoints() {
    setState(() {
      _points.clear();
    });
  }
}


class SignaturePainter extends CustomPainter {
  var image;
  List<Offset> points = <Offset>[];
  SignaturePainter({this.points,this.image});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 5.0;
    canvas.drawImage(image, Offset(0,250), Paint());
    for(int i=0; i < points.length - 1; i++) {
      if(points[i] != null && points[i+1] != null) {
        canvas.drawLine(points[i], points[i+1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }

}