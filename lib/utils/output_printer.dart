import '../models/point_model.dart';
import '../models/timed_point_model.dart';
import '../models/weighted_point_model.dart';

class OutputPrinter {
  static void printPointsInfo(List<ColoredPoint> points) {
    if (points.isEmpty) {
      print('Нет валидных точек для обработки');
      return;
    }

    print('=== ОБРАБОТАННЫЕ ТОЧКИ ===');
    for (final point in points) {
      print(point);
    }
    print('===========================');
  }

  static void printClosestPointInfo(ColoredPoint? closestPoint) {
    if (closestPoint == null) {
      print('Не удалось найти ближайшую точку');
      return;
    }

    print('Ближайшая точка к началу координат:');
    print('  Координаты: (${closestPoint.x}, ${closestPoint.y})');
    print('  Цвет: ${closestPoint.color}');
    print('  Тип: ${closestPoint.runtimeType}');

    if (closestPoint is WeightedPoint) {
      print('  Вес: ${closestPoint.weight}');
    } else if (closestPoint is TimedPoint) {
      print('  Время: ${closestPoint.timestamp}');
    }
  }
}
