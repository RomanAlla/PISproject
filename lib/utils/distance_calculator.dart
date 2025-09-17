import '../models/point_model.dart';

class DistanceCalculator {
  static double calculateDistance(Point point) {
    return point.x * point.x + point.y * point.y;
  }

  static Point? findClosestToOrigin(List<Point> points) {
    if (points.isEmpty) return null;

    Point closestPoint = points.first;
    double minDistance = DistanceCalculator.calculateDistance(points.first);

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
