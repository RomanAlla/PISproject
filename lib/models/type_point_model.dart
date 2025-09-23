import 'point_model.dart';

class TypePoint extends ColoredPoint {
  TypePoint({
    required super.x,
    required super.y,
    required super.color,
    required this.type,
  });
  final String type;

  @override
  String toString() {
    return 'TypedPoint(x:$x, y:$y, color:"$color", type:$type)';
  }
}
