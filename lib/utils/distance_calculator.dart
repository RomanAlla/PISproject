import 'dart:math';

import '../models/lined_point.dart';
import '../models/point_model.dart';

class DistanceCalculator {
  static double calculateDistance(ColoredPoint point) {
    if (point is LinedPoint) {
      return sqrt(point.x * point.x + point.y * point.y + point.z * point.z);
    }
    return sqrt(point.x * point.x + point.y * point.y);
  }

  static ColoredPoint? findClosestToOrigin(List<ColoredPoint> points) {
    if (points.isEmpty) return null;

    ColoredPoint closestPoint = points.first;
    double minDistance = calculateDistance(points.first);

    for (final point in points.skip(1)) {
      final distance = DistanceCalculator.calculateDistance(point);
      if (distance < minDistance) {
        minDistance = distance;
        closestPoint = point;
      }
    }

    return closestPoint;
  }
}
