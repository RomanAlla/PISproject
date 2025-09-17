import '../models/lined_point.dart';
import '../models/point_model.dart';
import '../models/timed_point_model.dart';
import '../models/weighted_point_model.dart';

class PointParser {
  Set<String> validColors = {"red", "green", "blue"};

  ColoredPoint? parseUpdatedPoint(String line) {
    final parts = line.trim().split(RegExp(r'\s+'));

    final cleanedParts = parts.where((part) => part.isNotEmpty).toList();

    if (cleanedParts.length < 4) {
      print('Ошибка: строка "$line" должна содержать минимум 4 свойства');
      return null;
    }

    final type = cleanedParts[0].toLowerCase();
    final x = double.tryParse(cleanedParts[1]);
    final y = double.tryParse(cleanedParts[2]);

    if (x == null || y == null) {
      print('Ошибка: некорректные координаты в строке: $line');
      return null;
    }

    switch (type) {
      case 'colored_point':
        if (cleanedParts.length < 4) {
          print('Ошибка: colored_point требует 4 параметра');
          return null;
        }
        final color = cleanedParts[3].toLowerCase();
        if (!validColors.contains(color)) {
          print('Ошибка: некорректный цвет "$color" в строке: $line');
          return null;
        }
        return ColoredPoint(x: x, y: y, color: color);

      case 'lined_point':
        if (cleanedParts.length == 4) {
          print('Ошибка: lined_point требует 4 параметров');
          return null;
        }
        final z = double.tryParse(cleanedParts[3]);
        final color = cleanedParts[4].toLowerCase();
        if (z == null) {
          print('Ошибка: некорректная координата z в строке: $line');
          return null;
        }
        if (!validColors.contains(color)) {
          print('Ошибка: некорректный цвет "$color" в строке: $line');
          return null;
        }
        return LinedPoint(x: x, y: y, z: z, color: color);

      case 'timed_point':
        if (cleanedParts.length != 6) {
          print('Ошибка: timed_point требует 6 параметров');
          return null;
        }
        final timestamp = cleanedParts[4] + ' ' + cleanedParts[5];
        final color = cleanedParts[3].toLowerCase();
        try {
          final time = DateTime.parse(timestamp);
          if (!validColors.contains(color)) {
            print('Ошибка: некорректный цвет "$color" в строке: $line');
            return null;
          }
          return TimedPoint(x: x, y: y, color: color, timestamp: time);
        } catch (e) {
          print('Ошибка парсинга даты: $timestamp в строке: $line');
          return null;
        }

      case 'weighted_point':
        if (cleanedParts.length != 5) {
          print('Ошибка: weighted_point требует 5 параметров');
          return null;
        }
        final weight = double.tryParse(cleanedParts[4]);
        final color = cleanedParts[3].toLowerCase();
        if (weight == null) {
          print('Ошибка: некорректный вес в строке: $line');
          return null;
        }
        if (!validColors.contains(color)) {
          print('Ошибка: некорректный цвет "$color" в строке: $line');
          return null;
        }
        return WeightedPoint(x: x, y: y, color: color, weight: weight);

      default:
        print('Ошибка: неизвестный тип точки "$type" в строке: $line');
        return null;
    }
  }

  List<ColoredPoint> parsePointsFromString(String inputData) {
    final lines = inputData.split('\n');
    return lines
        .where((line) => line.trim().isNotEmpty)
        .map(parseUpdatedPoint)
        .whereType<ColoredPoint>()
        .toList();
  }
}
