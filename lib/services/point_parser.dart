import '../models/point_model.dart';
import '../models/timed_point_model.dart';
import '../models/weighted_point_model.dart';

class PointParser {
  Set<String> validColors = {"red", "green", "blue"};
  Point? parsePointFromString(String line) {
    final parts = line.trim().split(RegExp(r'\s+'));
    if (parts.length < 3) {
      print('Ошибка: строка должна содержать минимум 3 свойства');
      return null;
    }

    final x = double.tryParse(parts[0]);
    final y = double.tryParse(parts[1]);
    final rawColor = parts[2].toLowerCase();
    final color = rawColor.replaceAll(RegExp(r'"'), '');
    if (x == null || y == null) {
      print('Ошибка: некорректные координаты в строке: $line');
      return null;
    }

    if (!validColors.contains(rawColor)) {
      print('Ошибка: некорректный цвет "$rawColor" в строке: $line');
      return null;
    }
    if (parts.length == 4) {
      final pointWeight = double.tryParse(parts[3]);
      if (pointWeight != null) {
        return WeightedPoint(x: x, y: y, color: rawColor, weight: pointWeight);
      }
    } else if (parts.length == 5) {
      final timestampStr = parts[3] + ' ' + parts[4];
      try {
        final pointTime = DateTime.parse(timestampStr);
        return TimedPoint(x: x, y: y, color: color, timestamp: pointTime);
      } catch (e) {
        print(e.toString());
      }
    }

    return Point(x: x, y: y, color: color);
  }

  List<Point> parsePointsFromString(String inputData) {
    final lines = inputData.split('\n');
    return lines
        .where((line) => line.trim().isNotEmpty)
        .map(parsePointFromString)
        .whereType<Point>()
        .toList();
  }
}
