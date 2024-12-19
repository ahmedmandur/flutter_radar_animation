# Flutter Radar Animation

A highly customizable Flutter package for creating beautiful radar sweep animations with various styles and effects.

[![pub package](https://img.shields.io/pub/v/flutter_radar_animation.svg)](https://pub.dev/packages/flutter_radar_animation)

## Live Demo

Try out the interactive demo at [https://ahmedmandur.github.io/flutter_radar_animation/](https://ahmedmandur.github.io/flutter_radar_animation/)

## Features

- Multiple sweep styles (line, gradient, dotted, double)
- Different radar shapes (circle, square, octagon)
- Customizable circles with adjustable count and color
- Pulse effect with configurable scale and duration
- Gradient sweep with multiple colors
- Fade edges effect
- Reverse animation option
- Adjustable sweep width and speed
- Center dot customization

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_radar_animation: ^1.0.0
```

## Usage

### Basic Example

```dart
import 'package:flutter_radar_animation/flutter_radar_animation.dart';

RadarAnimation(
  size: 200,
  sweepColor: Colors.green,
  backgroundColor: Colors.black,
)
```

### Advanced Example

```dart
RadarAnimation(
  size: 300,
  sweepColor: Colors.blue,
  backgroundColor: Colors.black,
  sweepStyle: RadarSweepStyle.gradient,
  radarShape: RadarShape.square,
  showCircles: true,
  numberOfCircles: 4,
  circleColor: Colors.blue,
  pulseEffect: true,
  pulseScale: 1.2,
  fadeEdges: true,
  gradientColors: [Colors.blue, Colors.green],
  reverse: true,
  duration: Duration(seconds: 3),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| size | double | 200 | The size of the radar widget |
| sweepColor | Color | Colors.green | The color of the sweep line |
| backgroundColor | Color | Colors.black | The background color of the radar |
| duration | Duration | 2 seconds | The duration of one complete sweep |
| sweepWidth | double | 2 | The width of the sweep line |
| showCircles | bool | true | Whether to show radar circles |
| numberOfCircles | int | 3 | Number of radar circles |
| circleColor | Color | Colors.green | Color of the radar circles |
| sweepStyle | RadarSweepStyle | line | Style of the sweep (line/gradient/dotted/double) |
| radarShape | RadarShape | circle | Shape of the radar (circle/square/octagon) |
| reverse | bool | false | Whether to reverse the animation |
| pulseEffect | bool | false | Whether to show pulse effect |
| pulseScale | double | 1.2 | Scale factor for pulse effect |
| fadeEdges | bool | false | Whether to fade the edges |
| gradientColors | List<Color>? | null | Colors for gradient sweep |

## Contributing

Contributions are welcome! If you find a bug or want a feature, please open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
