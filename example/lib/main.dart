import 'package:flutter/material.dart';
import 'package:flutter_radar_animation/flutter_radar_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radar Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const RadarConfigPage(),
    );
  }
}

class RadarConfigPage extends StatefulWidget {
  const RadarConfigPage({super.key});

  @override
  State<RadarConfigPage> createState() => _RadarConfigPageState();
}

class _RadarConfigPageState extends State<RadarConfigPage> {
  // Basic settings
  double size = 200;
  Color sweepColor = Colors.green;
  Color backgroundColor = Colors.black;
  Duration duration = const Duration(seconds: 2);
  double sweepWidth = 2;
  bool showCircles = true;
  int numberOfCircles = 3;
  Color circleColor = Colors.green;

  // Advanced settings
  RadarSweepStyle sweepStyle = RadarSweepStyle.line;
  RadarShape radarShape = RadarShape.circle;
  bool reverse = false;
  double dotSpacing = 15;
  double dotSize = 4;
  bool showCenterDot = true;
  Color centerDotColor = Colors.green;
  double centerDotSize = 6;
  List<Color> gradientColors = [Colors.green, Colors.lightGreen];
  bool pulseEffect = false;
  double pulseScale = 1.2;
  bool fadeEdges = false;
  double fadeIntensity = 0.5;

  Widget _buildOptionSection(String title, List<Widget> children) {
    return ExpansionTile(
      title: Text(title),
      initiallyExpanded: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    int? divisions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(1)}'),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildColorPicker(
      String label, Color color, ValueChanged<Color> onChanged) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Pick $label'),
                content: SingleChildScrollView(
                  child: ColorListPicker(
                    selectedColor: color,
                    onColorSelected: (color) {
                      onChanged(color);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radar Animation Configuration'),
      ),
      body: Row(
        children: [
          // Options Panel
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildOptionSection(
                      'Basic Settings',
                      [
                        _buildSlider(
                          label: 'Size',
                          value: size,
                          min: 100,
                          max: 400,
                          divisions: 30,
                          onChanged: (value) => setState(() => size = value),
                        ),
                        _buildColorPicker(
                          'Sweep Color',
                          sweepColor,
                          (color) => setState(() => sweepColor = color),
                        ),
                        const SizedBox(height: 16),
                        _buildColorPicker(
                          'Background Color',
                          backgroundColor,
                          (color) => setState(() => backgroundColor = color),
                        ),
                        const SizedBox(height: 16),
                        _buildSlider(
                          label: 'Duration (seconds)',
                          value: duration.inMilliseconds / 1000,
                          min: 0.5,
                          max: 5,
                          divisions: 45,
                          onChanged: (value) => setState(() => duration =
                              Duration(milliseconds: (value * 1000).round())),
                        ),
                        _buildSlider(
                          label: 'Sweep Width',
                          value: sweepWidth,
                          min: 1,
                          max: 10,
                          divisions: 18,
                          onChanged: (value) =>
                              setState(() => sweepWidth = value),
                        ),
                        SwitchListTile(
                          title: const Text('Show Circles'),
                          value: showCircles,
                          onChanged: (value) =>
                              setState(() => showCircles = value),
                        ),
                        _buildSlider(
                          label: 'Number of Circles',
                          value: numberOfCircles.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          onChanged: (value) =>
                              setState(() => numberOfCircles = value.round()),
                        ),
                        _buildColorPicker(
                          'Circle Color',
                          circleColor,
                          (color) => setState(() => circleColor = color),
                        ),
                      ],
                    ),
                    _buildOptionSection(
                      'Advanced Settings',
                      [
                        DropdownButtonFormField<RadarSweepStyle>(
                          value: sweepStyle,
                          decoration: const InputDecoration(
                            labelText: 'Sweep Style',
                          ),
                          items: RadarSweepStyle.values
                              .map((style) => DropdownMenuItem(
                                    value: style,
                                    child: Text(style.name.toUpperCase()),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => sweepStyle = value!),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<RadarShape>(
                          value: radarShape,
                          decoration: const InputDecoration(
                            labelText: 'Radar Shape',
                          ),
                          items: RadarShape.values
                              .map((shape) => DropdownMenuItem(
                                    value: shape,
                                    child: Text(shape.name.toUpperCase()),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => radarShape = value!),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('Reverse Animation'),
                          value: reverse,
                          onChanged: (value) => setState(() => reverse = value),
                        ),
                        _buildSlider(
                          label: 'Dot Spacing',
                          value: dotSpacing,
                          min: 5,
                          max: 30,
                          divisions: 25,
                          onChanged: (value) =>
                              setState(() => dotSpacing = value),
                        ),
                        _buildSlider(
                          label: 'Dot Size',
                          value: dotSize,
                          min: 1,
                          max: 10,
                          divisions: 18,
                          onChanged: (value) => setState(() => dotSize = value),
                        ),
                        SwitchListTile(
                          title: const Text('Show Center Dot'),
                          value: showCenterDot,
                          onChanged: (value) =>
                              setState(() => showCenterDot = value),
                        ),
                        _buildColorPicker(
                          'Center Dot Color',
                          centerDotColor,
                          (color) => setState(() => centerDotColor = color),
                        ),
                        const SizedBox(height: 16),
                        _buildSlider(
                          label: 'Center Dot Size',
                          value: centerDotSize,
                          min: 2,
                          max: 20,
                          divisions: 18,
                          onChanged: (value) =>
                              setState(() => centerDotSize = value),
                        ),
                        SwitchListTile(
                          title: const Text('Pulse Effect'),
                          value: pulseEffect,
                          onChanged: (value) =>
                              setState(() => pulseEffect = value),
                        ),
                        _buildSlider(
                          label: 'Pulse Scale',
                          value: pulseScale,
                          min: 1.0,
                          max: 2.0,
                          divisions: 20,
                          onChanged: (value) =>
                              setState(() => pulseScale = value),
                        ),
                        SwitchListTile(
                          title: const Text('Fade Edges'),
                          value: fadeEdges,
                          onChanged: (value) =>
                              setState(() => fadeEdges = value),
                        ),
                        _buildSlider(
                          label: 'Fade Intensity',
                          value: fadeIntensity,
                          min: 0.0,
                          max: 1.0,
                          divisions: 20,
                          onChanged: (value) =>
                              setState(() => fadeIntensity = value),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Preview Panel
          Expanded(
            flex: 3,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RadarAnimation(
                        size: size,
                        sweepColor: sweepColor,
                        backgroundColor: backgroundColor,
                        duration: duration,
                        sweepWidth: sweepWidth,
                        showCircles: showCircles,
                        numberOfCircles: numberOfCircles,
                        circleColor: circleColor,
                        sweepStyle: sweepStyle,
                        radarShape: radarShape,
                        reverse: reverse,
                        dotSpacing: dotSpacing,
                        dotSize: dotSize,
                        showCenterDot: showCenterDot,
                        centerDotColor: centerDotColor,
                        centerDotSize: centerDotSize,
                        gradientColors: gradientColors,
                        pulseEffect: pulseEffect,
                        pulseScale: pulseScale,
                        fadeEdges: fadeEdges,
                        fadeIntensity: fadeIntensity,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorListPicker extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorListPicker({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  static const List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: selectedColor == color ? Colors.white : Colors.grey,
                width: selectedColor == color ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }).toList(),
    );
  }
}
