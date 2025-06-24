import 'package:flutter/material.dart';

class NextButton extends StatefulWidget {
  final double progress;
  final VoidCallback onPressed;

  const NextButton({
    super.key,
    required this.progress,
    required this.onPressed,
  });

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  double animatedProgress = 0.0;

  @override
  void didUpdateWidget(covariant NextButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      animateProgress(widget.progress);
    }
  }

  void animateProgress(double targetProgress) {
    setState(() {
      animatedProgress = targetProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: animatedProgress),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(65, 65),
                painter: ProgressPainter(value, colorScheme),
              ),
              ElevatedButton(
                onPressed: widget.onPressed,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: colorScheme.primary,
                  elevation: 4,
                ),
                child: Icon(Icons.arrow_forward, color: colorScheme.onPrimary),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  final ColorScheme colorScheme;

  ProgressPainter(this.progress, this.colorScheme);

  @override
  void paint(Canvas canvas, Size size) {
    Paint trackPaint =
        Paint()
          ..color = colorScheme.primary.withValues(alpha: 0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round;

    Paint progressPaint =
        Paint()
          ..color = colorScheme.primary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - 5;

    // Draw background track
    canvas.drawCircle(center, radius, trackPaint);

    // Animate progress arc
    double startAngle = -90 * (3.1416 / 180);
    double sweepAngle = progress * 360 * (3.1416 / 180);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
