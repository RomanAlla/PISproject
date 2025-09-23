class ColoredPoint {
  ColoredPoint({required this.x, required this.y, required this.color});
  final double x;
  final double y;
  final String color;

  @override
  String toString() {
    return 'ColoredPoint(x:$x, y:$y, color:"$color")';
  }
}
