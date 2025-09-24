import 'package:PISprojects/models/lined_point.dart';
import 'package:PISprojects/models/point_model.dart';
import 'package:PISprojects/models/timed_point_model.dart';
import 'package:PISprojects/models/weighted_point_model.dart';
import 'package:PISprojects/utils/exceptions.dart';
import 'package:PISprojects/utils/validator.dart';

class PointParser {
  Set<String> validColors = {"red", "green", "blue"};

  ColoredPoint? parsePointFromString(String line) {
    final parts = line.trim().split(RegExp(r'\s+'));
    final cleanedParts = parts.where((part) => part.isNotEmpty).toList();

    if (cleanedParts.length < 3) {
      throw ParseException(
        'Строка "$line" должна содержать минимум 3 свойства (x, y, color)',
      );
    }

    String type = 'colored_point';
    int startIndex = 0;

    if (double.tryParse(cleanedParts[0]) == null &&
        !Validator.isValidColor(cleanedParts[0])) {
      type = cleanedParts[0].toLowerCase();
      startIndex = 1;
    }

    if (cleanedParts.length < startIndex + 3) {
      throw ParseException('Недостаточно параметров в строке: $line');
    }

    final xStr = cleanedParts[startIndex];
    final yStr = cleanedParts[startIndex + 1];

    if (!Validator.isValidCoordinate(xStr) ||
        !Validator.isValidCoordinate(yStr)) {
      throw ParseException('Некорректные координаты в строке: $line');
    }
    final x = double.parse(xStr);
    final y = double.parse(yStr);

    final color = cleanedParts[startIndex + 2].toLowerCase();
    if (!Validator.isValidColor(color)) {
      throw ParseException('Некорректный цвет "$color" в строке: $line');
    }

    switch (type) {
      case 'colored_point':
        return ColoredPoint(x: x, y: y, color: color);

      case 'lined_point':
        if (cleanedParts.length < startIndex + 4) {
          throw ParseException(
            'LinedPoint требует 4 параметра в строке: $line',
          );
        }
        final zStr = cleanedParts[startIndex + 3];
        if (!Validator.isValidCoordinate(zStr)) {
          throw ParseException('Некорректная координата z в строке: $line');
        }
        final z = double.parse(zStr);
        return LinedPoint(x: x, y: y, z: z, color: color);

      case 'timed_point':
        if (cleanedParts.length < startIndex + 5) {
          throw ParseException(
            'TimedPoint требует 5 параметров в строке: $line',
          );
        }
        final dateStr = cleanedParts[startIndex + 3];
        final timeStr = cleanedParts[startIndex + 4];
        final timestamp = DateTime.parse('$dateStr $timeStr');
        return TimedPoint(x: x, y: y, color: color, timestamp: timestamp);

      case 'weighted_point':
        if (cleanedParts.length < startIndex + 4) {
          throw ParseException(
            'WeightedPoint требует 4 параметра в строке: $line',
          );
        }
        final weightStr = cleanedParts[startIndex + 3];
        if (!Validator.isValidWeight(weightStr)) {
          throw ParseException('Некорректный вес в строке: $line');
        }
        final weight = double.parse(weightStr);
        return WeightedPoint(x: x, y: y, color: color, weight: weight);

      default:
        throw ParseException(
          'Неизвестный тип точки "$type" в строке: $line',
        );
    }
  }

  List<ColoredPoint> parsePointsFromString(String inputData) {
    final lines = inputData.split('\n');
    final results = <ColoredPoint>[];
    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      try {
        final point = parsePointFromString(line);
        if (point != null) results.add(point);
      } catch (e) {
        print('Пропуск строки "$line": $e');
      }
    }
    return results;
  }
}
