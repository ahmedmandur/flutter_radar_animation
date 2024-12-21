library flutter_radar_animation;

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Defines the style of the radar sweep animation
enum RadarSweepStyle {
  /// Standard rotating line
  line,

  /// Gradient sweep
  gradient,

  /// Dotted line
  dotted,

  /// Double line
  double,
}

/// Defines the shape of the radar
enum RadarShape {
  /// Circular radar
  circle,

  /// Square radar
  square,

  /// Octagon radar
  octagon,
}

/// RadarAnimation is a customizable widget that displays various radar sweep animations
class RadarAnimation extends StatefulWidget {
  /// The size of the radar animation.
  final double size;

  /// The color of the sweep in the radar animation.
  final Color sweepColor;

  /// The background color of the radar animation.
  final Color backgroundColor;

  /// The duration of the radar animation.
  final Duration duration;

  /// The width of the sweep in the radar animation.
  final double sweepWidth;

  /// Whether to show circles in the radar animation.
  final bool showCircles;

  /// The number of circles to show in the radar animation.
  final int numberOfCircles;

  /// The color of the circles in the radar animation.
  final Color circleColor;

  /// The style of the sweep in the radar animation.
  final RadarSweepStyle sweepStyle;

  /// The shape of the radar.
  final RadarShape radarShape;

  /// Whether to reverse the direction of the sweep.
  final bool reverse;

  /// The spacing between dots in the dotted sweep style.
  final double dotSpacing;

  /// The size of the dots in the dotted sweep style.
  final double dotSize;

  /// Whether to show a center dot in the radar animation.
  final bool showCenterDot;

  /// The color of the center dot in the radar animation.
  final Color centerDotColor;

  /// The size of the center dot in the radar animation.
  final double centerDotSize;

  /// The colors of the gradient in the gradient sweep style.
  final List<Color>? gradientColors;

  /// Whether to apply a pulse effect to the radar animation.
  final bool pulseEffect;

  /// The duration of the pulse effect.
  final Duration? pulseDuration;

  /// The scale of the pulse effect.
  final double pulseScale;

  /// Whether to fade the edges of the sweep.
  final bool fadeEdges;

  /// The intensity of the fade effect.
  final double fadeIntensity;

  const RadarAnimation({
    super.key,
    this.size = 200,
    this.sweepColor = Colors.green,
    this.backgroundColor = Colors.black,
    this.duration = const Duration(seconds: 2),
    this.sweepWidth = 2,
    this.showCircles = true,
    this.numberOfCircles = 3,
    this.circleColor = Colors.green,
    this.sweepStyle = RadarSweepStyle.line,
    this.radarShape = RadarShape.circle,
    this.reverse = false,
    this.dotSpacing = 15,
    this.dotSize = 4,
    this.showCenterDot = true,
    this.centerDotColor = Colors.green,
    this.centerDotSize = 6,
    this.gradientColors,
    this.pulseEffect = false,
    this.pulseDuration,
    this.pulseScale = 1.2,
    this.fadeEdges = false,
    this.fadeIntensity = 0.5,
  });

  @override
  State<RadarAnimation> createState() => _RadarAnimationState();
}

class _RadarAnimationState extends State<RadarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: widget.reverse);

    if (widget.pulseEffect) {
      _pulseAnimation = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: widget.pulseScale)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: widget.pulseScale, end: 1.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50,
        ),
      ]).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      color: widget.backgroundColor,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return widget.pulseEffect
              ? ScaleTransition(
                  scale: _pulseAnimation!,
                  child: _buildRadar(),
                )
              : _buildRadar();
        },
      ),
    );
  }

  Widget _buildRadar() {
    return CustomPaint(
      painter: RadarPainter(
        progress: _controller.value,
        sweepColor: widget.sweepColor,
        sweepWidth: widget.sweepWidth,
        showCircles: widget.showCircles,
        numberOfCircles: widget.numberOfCircles,
        circleColor: widget.circleColor,
        sweepStyle: widget.sweepStyle,
        radarShape: widget.radarShape,
        dotSpacing: widget.dotSpacing,
        dotSize: widget.dotSize,
        showCenterDot: widget.showCenterDot,
        centerDotColor: widget.centerDotColor,
        centerDotSize: widget.centerDotSize,
        gradientColors: widget.gradientColors ?? [widget.sweepColor],
        fadeEdges: widget.fadeEdges,
        fadeIntensity: widget.fadeIntensity,
      ),
    );
  }
}

class RadarPainter extends CustomPainter {
  final double progress;
  final Color sweepColor;
  final double sweepWidth;
  final bool showCircles;
  final int numberOfCircles;
  final Color circleColor;
  final RadarSweepStyle sweepStyle;
  final RadarShape radarShape;
  final double dotSpacing;
  final double dotSize;
  final bool showCenterDot;
  final Color centerDotColor;
  final double centerDotSize;
  final List<Color> gradientColors;
  final bool fadeEdges;
  final double fadeIntensity;

  RadarPainter({
    required this.progress,
    required this.sweepColor,
    required this.sweepWidth,
    required this.showCircles,
    required this.numberOfCircles,
    required this.circleColor,
    required this.sweepStyle,
    required this.radarShape,
    required this.dotSpacing,
    required this.dotSize,
    required this.showCenterDot,
    required this.centerDotColor,
    required this.centerDotSize,
    required this.gradientColors,
    required this.fadeEdges,
    required this.fadeIntensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw radar shape
    _drawRadarShape(canvas, center, radius);

    // Draw circles
    if (showCircles) {
      _drawCircles(canvas, center, radius);
    }

    // Draw sweep
    _drawSweep(canvas, center, radius);

    // Draw center dot
    if (showCenterDot) {
      final centerDotPaint = Paint()
        ..color = centerDotColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, centerDotSize, centerDotPaint);
    }
  }

  void _drawRadarShape(Canvas canvas, Offset center, double radius) {
    final shapePaint = Paint()
      ..color = Color.fromRGBO(
          circleColor.red, circleColor.green, circleColor.blue, 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    switch (radarShape) {
      case RadarShape.circle:
        canvas.drawCircle(center, radius, shapePaint);
        break;
      case RadarShape.square:
        final rect = Rect.fromCenter(
          center: center,
          width: radius * 2,
          height: radius * 2,
        );
        canvas.drawRect(rect, shapePaint);
        break;
      case RadarShape.octagon:
        final path = Path();
        for (var i = 0; i < 8; i++) {
          final angle = i * math.pi / 4;
          final point = Offset(
            center.dx + radius * math.cos(angle),
            center.dy + radius * math.sin(angle),
          );
          if (i == 0) {
            path.moveTo(point.dx, point.dy);
          } else {
            path.lineTo(point.dx, point.dy);
          }
        }
        path.close();
        canvas.drawPath(path, shapePaint);
        break;
    }
  }

  void _drawCircles(Canvas canvas, Offset center, double radius) {
    final circlePaint = Paint()
      ..color = Color.fromRGBO(
          circleColor.red, circleColor.green, circleColor.blue, 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 1; i <= numberOfCircles; i++) {
      final circleRadius = (radius / numberOfCircles) * i;
      if (radarShape == RadarShape.circle) {
        canvas.drawCircle(center, circleRadius, circlePaint);
      } else {
        final rect = Rect.fromCenter(
          center: center,
          width: circleRadius * 2,
          height: circleRadius * 2,
        );
        if (radarShape == RadarShape.square) {
          canvas.drawRect(rect, circlePaint);
        }
      }
    }
  }

  void _drawSweep(Canvas canvas, Offset center, double radius) {
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    switch (sweepStyle) {
      case RadarSweepStyle.line:
        _drawLineSweep(canvas, center, radius, startAngle, sweepAngle);
        break;
      case RadarSweepStyle.gradient:
        _drawGradientSweep(canvas, center, radius, startAngle, sweepAngle);
        break;
      case RadarSweepStyle.dotted:
        _drawDottedSweep(canvas, center, radius, startAngle, sweepAngle);
        break;
      case RadarSweepStyle.double:
        _drawDoubleSweep(canvas, center, radius, startAngle, sweepAngle);
        break;
    }
  }

  void _drawLineSweep(Canvas canvas, Offset center, double radius,
      double startAngle, double sweepAngle) {
    final sweepPaint = Paint()
      ..color = sweepColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = sweepWidth;

    if (fadeEdges) {
      sweepPaint.shader = RadialGradient(
        colors: [
          Color.fromRGBO(sweepColor.red, sweepColor.green, sweepColor.blue,
              1 - fadeIntensity),
          sweepColor,
          Color.fromRGBO(sweepColor.red, sweepColor.green, sweepColor.blue,
              1 - fadeIntensity),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    }

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle + sweepAngle, 0.1, false, sweepPaint);
  }

  void _drawGradientSweep(Canvas canvas, Offset center, double radius,
      double startAngle, double sweepAngle) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    final colors = gradientColors;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = SweepGradient(
        colors: [
          ...colors.map((c) => Color.fromRGBO(c.red, c.green, c.blue, 0.0)),
          ...colors.map((c) => Color.fromRGBO(c.red, c.green, c.blue, 0.5)),
        ],
        stops: List.generate(
          colors.length * 2,
          (i) => i / (colors.length * 2 - 1),
        ),
        tileMode: TileMode.clamp,
      ).createShader(rect);

    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  void _drawDottedSweep(Canvas canvas, Offset center, double radius,
      double startAngle, double sweepAngle) {
    final angle = startAngle + sweepAngle;
    final dotPaint = Paint()
      ..color = sweepColor
      ..style = PaintingStyle.fill;

    final numberOfDots = (radius / dotSpacing).floor();
    for (var i = 0; i < numberOfDots; i++) {
      final dotRadius = dotSize / 2;
      final distance = i * dotSpacing;
      final x = center.dx + distance * math.cos(angle);
      final y = center.dy + distance * math.sin(angle);
      canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
    }
  }

  void _drawDoubleSweep(Canvas canvas, Offset center, double radius,
      double startAngle, double sweepAngle) {
    final sweepPaint = Paint()
      ..color = sweepColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = sweepWidth;

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle + sweepAngle, 0.1, false, sweepPaint);
    canvas.drawArc(
        rect, startAngle + sweepAngle + math.pi, 0.1, false, sweepPaint);
  }

  @override
  bool shouldRepaint(RadarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
