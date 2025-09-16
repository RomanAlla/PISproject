import 'dart:io';

final inputDataFile = File('input_data.txt');
final validColors = {"red", "green", "blue"};

class Point {
  Point({required this.x, required this.y, required this.color});
  double? x;
  double? y;
  String? color;

  @override
  String toString() {
    return 'Point(x:$x, y:$y, color:"$color")';
  }
}

void findClosestToOrigin(List<String> lines) {
  double? closestX;
  double? closestY;
  double? minDistance;

  for (final line in lines) {
    final parts = line.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) continue;

    final x = double.tryParse(parts[0]);
    final y = double.tryParse(parts[1]);

    if (x != null && y != null) {
      final distance = x * x + y * y;
      if (minDistance == null || distance < minDistance) {
        minDistance = distance;
        closestX = x;
        closestY = y;
      }
    }
  }

  if (closestX != null && closestY != null) {
    print('наиближайшие точки к началу координат: $closestX, $closestY');
  }
}

void main() {
  final lines = inputDataFile.readAsLinesSync();

  findClosestToOrigin(lines);

  final points = lines.map((line) {
    final parts = line.trim().split(RegExp(r'\s+'));
    if (parts.length < 3) {
      print('должно быть 3 свойства');
      return null;
    }

    final x = double.tryParse(parts[0]);
    final y = double.tryParse(parts[1]);
    final rawColor = parts[2].toLowerCase();
    final color = rawColor.replaceAll(RegExp(r'"'), '');
    if (x == null || y == null) {
      print('Некорректные данные');
    }
    if (!validColors.contains(color)) {
      print('Некорректный цвет $color');
    }
    return Point(x: x, y: y, color: color);
  }).toList();

  for (final point in points) {
    print(point);
  }
}
