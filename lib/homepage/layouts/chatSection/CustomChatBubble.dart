import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChatBubble extends CustomPainter {
  CustomChatBubble({this.color, @required this.isOwn});

  final Color color;
  final bool isOwn;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color ?? Colors.blue;

    Path paintBubbleTail() {
      Path path;
      if (!isOwn) {
        path = Path()
          ..moveTo(15, size.height - 3)
          ..quadraticBezierTo(-2, size.height, -5, size.height - 2)
          ..quadraticBezierTo(-2, size.height - 3, 0, size.height - 10);
      }
      if (isOwn) {
        path = Path()
          ..moveTo(size.width - 15, size.height - 3)
          ..quadraticBezierTo(
              size.width + 2, size.height, size.width + 5, size.height - 0)
          ..quadraticBezierTo(
              size.width + 2, size.height - 3, size.width, size.height - 10);
      }
      return path;
    }

    final RRect bubbleBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(10));
    final Path bubbleTail = paintBubbleTail();

    canvas.drawRRect(bubbleBody, paint);
    canvas.drawPath(bubbleTail, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
