import 'package:flutter/material.dart';

class BackgroundLogin extends StatelessWidget {
  const BackgroundLogin({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: TopCurvePainter(),
          ),
        ),

        child
      ],
    );
  }
}

class TopCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //Primera curva
    Paint paint1 = Paint()..color = const Color(0xFFFFBDC4).withOpacity(0.5);
    paint1.style = PaintingStyle.fill;

    final path1 = new Path()
      ..lineTo(0, size.height * 0.02)
      ..lineTo(size.width * 0.1, size.height * 0.02)
      ..cubicTo(
          size.width * 1.1, size.height * 0.001,
          size.width * 0.4, size.height * 0.2,
          size.width, size.height * 0.25)
      ..lineTo(size.width, 0)

      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path1, paint1);

    //Segunda curva
    Paint paint2 = Paint()..color = const Color(0xFFFFBDC4).withOpacity(0.5);
    paint2.style = PaintingStyle.fill;

    final path2 = new Path()
      ..cubicTo(
          size.width * 0.8, size.height * 0.1,
          size.width * 0.3, size.height * 0.2,
          size.width, size.height * 0.2)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path2, paint2);

    //Tercera curva

    Paint paint3 = Paint()..color = const Color(0xFFFFBDC4).withOpacity(0.5);
    paint3.style = PaintingStyle.fill;

    final path3 = new Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.7)
    //..lineTo(size.width, size.height * 0.98)
      ..cubicTo(
          size.width * 0.4, size.height * 0.75,
          size.width * 0.3, size.height,
          size.width, size.height * 0.98)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path3, paint3);


    //Cuarta curva
    Paint paint4 = Paint()..color = const Color(0xFFFFBDC4).withOpacity(0.5);
    paint4.style = PaintingStyle.fill;

    final path4 = new Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.85)
      ..quadraticBezierTo(
          size.width * 0.25, size.height * 0.99,
          size.width, size.height * 0.88)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path4, paint4);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}