import 'point_model.dart';

class WeightedPoint extends ColoredPoint {
  WeightedPoint({
    required super.x,
    required super.y,
    required super.color,
    required this.weight,
  });
  final double weight;

  @override
  String toString() {
    return 'WeightedPoint(x:$x, y:$y, color:"$color", weight:$weight)';
  }
}
