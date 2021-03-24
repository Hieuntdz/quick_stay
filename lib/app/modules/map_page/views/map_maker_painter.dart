import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    Paint paint1 = Paint()
      ..color = Colors.grey.withOpacity(0.8)
      ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
    final paint2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height - 20, Radius.circular(8)),
        paint);

    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height - 20, Radius.circular(8)),
        paint1);

    Path path = Path();

    double startX = size.width / 2 - 15;
    double endX = size.width / 2 + 15;
    double startY = size.height - 20;
    double endY = size.height;

    path.moveTo(startX, startY);
    path.quadraticBezierTo(size.width / 2, endY, endX, startY);

    path.lineTo(startX, startY);

    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint1);

    canvas.drawLine(Offset(startX,startY), Offset(endX,startY),paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return null;
  }
}
