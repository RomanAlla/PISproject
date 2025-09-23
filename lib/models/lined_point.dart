import 'point_model.dart';

class LinedPoint extends ColoredPoint {
  LinedPoint({
    required super.x,
    required super.y,
    required super.color,
    required this.z,
  });
  double z;

  @override
  String toString() {
    return 'LinedPoint(line: x:$x, y:$y, z:$z)';
  }
}
