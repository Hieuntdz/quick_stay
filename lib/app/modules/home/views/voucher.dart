import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoucherView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VoucherViewState();
  }
}

class VoucherViewState extends State<VoucherView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: CustomPaint(
        painter: VoucherBackGround(),
      ),
    );
  }
}

class VoucherBackGround extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(8)),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
