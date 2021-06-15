import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({this.size});

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  Timer timer;

  @override void initState(){
    this.timer=Timer.periodic(Duration(seconds: 1),(timer){
      setState(() {
      });
    }
    );
    super.initState();
  }

  @override void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: Transform.rotate(
          angle: -pi/2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter{

  var dateTime =DateTime.now();




  @override
  void paint(Canvas canvas, Size size){
    var centerX = size.width/2;
    var centerY = size.height/2;
    var center =  Offset(centerX , centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()
      ..color = Colors.deepPurpleAccent;

    var outerFillBrush = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth =16;

    var centerFillBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth =size.width/20;

    var secHandBrush = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth =size.width/60;

    var minHandBrush = Paint()
      ..color = Colors.purpleAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth =size.width/30;

    var hourHandBrush = Paint()
      ..color =  Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/24;


    canvas.drawCircle(center, radius*0.75, fillBrush);
    canvas.drawCircle(center, radius *0.75, outerFillBrush);


    var hourHandX = centerX +radius* 0.4* cos((dateTime.hour *30+dateTime.minute*0.5)*pi/180);
    var hourHandY = centerY +radius* 0.4*sin((dateTime.hour *30+dateTime.minute*0.5)*pi/180);

    canvas.drawLine(center,Offset(hourHandX,hourHandY), hourHandBrush);

    var minHandX = centerX +radius*0.6* cos(dateTime.minute*6*pi/180);
    var minHandY =  centerY +radius*0.6*sin(dateTime.minute*6*pi/180);

    canvas.drawLine(center,Offset(minHandX,minHandY), minHandBrush);

    var secHandX = centerX+radius*0.6*cos(dateTime.second*6*pi/180);
    var secHandY = centerY+radius*0.6*sin(dateTime.second*6*pi/180);

    canvas.drawLine(center,Offset(secHandX,secHandY), secHandBrush);

    canvas.drawCircle(center, radius*0.12, centerFillBrush);

  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}