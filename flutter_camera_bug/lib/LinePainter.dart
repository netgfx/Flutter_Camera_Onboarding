import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 2;
    canvas.drawLine(
      Offset(0, size.height / 4),
      Offset(size.width, size.height / 4),
      paint,
    );

    paint.color = Colors.green;

    paint.style = PaintingStyle.fill;
    //
    var paint2 = Paint();
    paint2.color = Colors.white;
    paint2.strokeWidth = 2;
    canvas.drawLine(
      Offset(0, size.height - size.height / 4),
      Offset(size.width, size.height - size.height / 4),
      paint2,
    );

    paint2.color = Colors.green;

    paint2.style = PaintingStyle.fill;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
