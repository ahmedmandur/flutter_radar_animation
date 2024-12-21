import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_radar_animation/flutter_radar_animation.dart';

void main() {
  group('RadarAnimation Widget Tests', () {
    testWidgets('Basic Rendering Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadarAnimation(),
          ),
        ),
      );

      expect(find.byType(RadarAnimation), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints, BoxConstraints.tight(const Size(200, 200)));
      expect(container.color, Colors.black);
    });

    testWidgets('Custom Basic Properties Test', (WidgetTester tester) async {
      const size = 300.0;
      const color = Colors.blue;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadarAnimation(
              size: size,
              sweepColor: color,
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
              sweepWidth: 3,
              showCircles: true,
              numberOfCircles: 4,
              circleColor: color,
            ),
          ),
        ),
      );

      expect(find.byType(RadarAnimation), findsOneWidget);

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints, BoxConstraints.tight(const Size(300, 300)));
      expect(container.color, Colors.black);
    });

    testWidgets('Advanced Properties Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadarAnimation(
              size: 200,
              sweepColor: Colors.blue,
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
              sweepWidth: 3,
              showCircles: true,
              numberOfCircles: 4,
              circleColor: Colors.blue,
              pulseEffect: true,
              pulseScale: 1.2,
            ),
          ),
        ),
      );

      expect(find.byType(RadarAnimation), findsOneWidget);

      final scaleTransitions = find.byType(ScaleTransition);
      expect(
          scaleTransitions, findsNWidgets(2)); // One for radar, one for pulse
    });

    testWidgets('Sweep Styles Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadarAnimation(
              size: 200,
              sweepColor: Colors.blue,
              backgroundColor: Colors.black,
              sweepStyle: RadarSweepStyle.gradient,
              gradientColors: [Colors.blue, Colors.green],
            ),
          ),
        ),
      );

      expect(find.byType(RadarAnimation), findsOneWidget);

      final customPaints = find.byType(CustomPaint);
      expect(customPaints, findsNWidgets(2)); // One for radar, one for circles
    });

    testWidgets('Radar Shapes Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadarAnimation(
              size: 200,
              sweepColor: Colors.blue,
              backgroundColor: Colors.black,
              radarShape: RadarShape.square,
            ),
          ),
        ),
      );

      expect(find.byType(RadarAnimation), findsOneWidget);

      final customPaints = find.byType(CustomPaint);
      expect(customPaints, findsNWidgets(2)); // One for radar, one for circles
    });

    testWidgets('Pulse Effect Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadarAnimation(
              size: 200,
              sweepColor: Colors.blue,
              backgroundColor: Colors.black,
              pulseEffect: true,
              pulseScale: 1.5,
            ),
          ),
        ),
      );

      expect(find.byType(RadarAnimation), findsOneWidget);

      final scaleTransitions = find.byType(ScaleTransition);
      expect(
          scaleTransitions, findsNWidgets(2)); // One for radar, one for pulse
    });

    testWidgets('Animation Controller Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RadarAnimation(
              size: 200,
              sweepColor: Colors.blue,
              backgroundColor: Colors.black,
              pulseEffect: true, // Enable pulse effect
            ),
          ),
        ),
      );

      expect(find.byType(RadarAnimation), findsOneWidget);

      // Find the RadarAnimation widget
      final radarAnimation = find.byType(RadarAnimation);

      // Find AnimatedBuilder widgets that are descendants of RadarAnimation
      final animatedBuilders = find.descendant(
        of: radarAnimation,
        matching: find.byType(AnimatedBuilder),
      );

      // Find ScaleTransition widgets that are descendants of RadarAnimation
      final scaleTransitions = find.descendant(
        of: radarAnimation,
        matching: find.byType(ScaleTransition),
      );

      // Expect one AnimatedBuilder for the radar animation
      expect(animatedBuilders, findsOneWidget);

      // Expect one ScaleTransition for the pulse effect
      expect(scaleTransitions, findsOneWidget);
    });
  });

  group('RadarPainter Tests', () {
    test('ShouldRepaint Test - Progress Change', () {
      final painter1 = RadarPainter(
        progress: 0.5,
        sweepColor: Colors.green,
        sweepWidth: 2,
        showCircles: true,
        numberOfCircles: 3,
        circleColor: Colors.green,
        sweepStyle: RadarSweepStyle.line,
        radarShape: RadarShape.circle,
        dotSpacing: 15,
        dotSize: 4,
        showCenterDot: true,
        centerDotColor: Colors.green,
        centerDotSize: 6,
        gradientColors: [Colors.green],
        fadeEdges: false,
        fadeIntensity: 0.5,
      );

      final painter2 = RadarPainter(
        progress: 0.7,
        sweepColor: Colors.green,
        sweepWidth: 2,
        showCircles: true,
        numberOfCircles: 3,
        circleColor: Colors.green,
        sweepStyle: RadarSweepStyle.line,
        radarShape: RadarShape.circle,
        dotSpacing: 15,
        dotSize: 4,
        showCenterDot: true,
        centerDotColor: Colors.green,
        centerDotSize: 6,
        gradientColors: [Colors.green],
        fadeEdges: false,
        fadeIntensity: 0.5,
      );

      expect(painter1.shouldRepaint(painter2), true);
    });

    test('ShouldRepaint Test - Same Properties', () {
      final painter1 = RadarPainter(
        progress: 0.5,
        sweepColor: Colors.green,
        sweepWidth: 2,
        showCircles: true,
        numberOfCircles: 3,
        circleColor: Colors.green,
        sweepStyle: RadarSweepStyle.line,
        radarShape: RadarShape.circle,
        dotSpacing: 15,
        dotSize: 4,
        showCenterDot: true,
        centerDotColor: Colors.green,
        centerDotSize: 6,
        gradientColors: [Colors.green],
        fadeEdges: false,
        fadeIntensity: 0.5,
      );

      final painter2 = RadarPainter(
        progress: 0.5,
        sweepColor: Colors.green,
        sweepWidth: 2,
        showCircles: true,
        numberOfCircles: 3,
        circleColor: Colors.green,
        sweepStyle: RadarSweepStyle.line,
        radarShape: RadarShape.circle,
        dotSpacing: 15,
        dotSize: 4,
        showCenterDot: true,
        centerDotColor: Colors.green,
        centerDotSize: 6,
        gradientColors: [Colors.green],
        fadeEdges: false,
        fadeIntensity: 0.5,
      );

      expect(painter1.shouldRepaint(painter2), false);
    });
  });
}
