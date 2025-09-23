import 'point_model.dart';

class TimedPoint extends ColoredPoint {
  TimedPoint({
    required super.x,
    required super.y,
    required super.color,
    required this.timestamp,
  });
  final DateTime timestamp;

  @override
  String toString() {
    return 'TimedPoint(x:$x, y:$y, color:"$color", timestamp:$timestamp)';
  }
}
