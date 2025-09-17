import 'point_model.dart';

class WeightedPoint extends Point {
  WeightedPoint({
    required super.x,
    required super.y,
    required super.color,
    required this.weight,
  });
  final double weight;

  @override
  String toString() {
    return 'Point(x:$x, y:$y, color:"$color", weight:$weight)';
  }
}
