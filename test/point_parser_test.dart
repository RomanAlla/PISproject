import 'package:PISprojects/models/lined_point.dart';
import 'package:PISprojects/models/point_model.dart';
import 'package:PISprojects/models/timed_point_model.dart';
import 'package:PISprojects/models/weighted_point_model.dart'
    show WeightedPoint;
import 'package:PISprojects/services/point_parser.dart';
import 'package:PISprojects/utils/distance_calculator.dart';
import 'package:PISprojects/utils/exceptions.dart';
import 'package:PISprojects/utils/validator.dart';
import 'package:test/test.dart';

void main() {
  group('Validator Tests', () {
    test('isValidColor should return true for valid colors', () {
      expect(Validator.isValidColor('red'), isTrue);
      expect(Validator.isValidColor('green'), isTrue);
      expect(Validator.isValidColor('blue'), isTrue);
      expect(Validator.isValidColor('RED'), isTrue);
    });

    test('isValidColor should return false for invalid colors', () {
      expect(Validator.isValidColor('yellow'), isFalse);
      expect(Validator.isValidColor(''), isFalse);
      expect(Validator.isValidColor('123'), isFalse);
    });

    test('isValidCoordinate should validate double strings', () {
      expect(Validator.isValidCoordinate('1.0'), isTrue);
      expect(Validator.isValidCoordinate('-5.5'), isTrue);
      expect(Validator.isValidCoordinate('abc'), isFalse);
      expect(Validator.isValidCoordinate(''), isFalse);
    });

    test('isValidWeight should validate positive doubles', () {
      expect(Validator.isValidWeight('1.0'), isTrue);
      expect(Validator.isValidWeight('0.5'), isTrue);
      expect(Validator.isValidWeight('-1.0'), isFalse);
      expect(Validator.isValidWeight('0'), isFalse);
      expect(Validator.isValidWeight('abc'), isFalse);
    });
  });

  group('PointParser Tests', () {
    final parser = PointParser();

    test('should parse basic ColoredPoint', () {
      final point = parser.parsePointFromString('1.0 2.0 red');
      expect(point, isA<ColoredPoint>());
      expect(point!.x, 1.0);
      expect(point.y, 2.0);
      expect(point.color, 'red');
    });

    test('should parse ColoredPoint with type prefix', () {
      final point = parser.parsePointFromString('colored_point 1.0 2.0 red');
      expect(point, isA<ColoredPoint>());
      expect(point!.x, 1.0);
      expect(point.y, 2.0);
      expect(point.color, 'red');
    });

    test('should parse WeightedPoint', () {
      final point =
          parser.parsePointFromString('weighted_point 1.0 2.0 red 5.5');
      expect(point, isA<WeightedPoint>());
      expect(point!.x, 1.0);
      expect(point.y, 2.0);
      expect(point.color, 'red');
      expect((point as WeightedPoint).weight, 5.5);
    });

    test('should parse LinedPoint', () {
      final point = parser.parsePointFromString('lined_point 1.0 2.0 red 3.0');
      expect(point, isA<LinedPoint>());
      expect(point!.x, 1.0);
      expect(point.y, 2.0);
      expect(point.color, 'red');
      expect((point as LinedPoint).z, 3.0);
    });

    test('should parse TimedPoint', () {
      final point = parser
          .parsePointFromString('timed_point 1.0 2.0 red 2023-01-01 12:00:00');
      expect(point, isA<TimedPoint>());
      expect(point!.x, 1.0);
      expect(point.y, 2.0);
      expect(point.color, 'red');
      expect((point as TimedPoint).timestamp, DateTime(2023, 1, 1, 12, 0, 0));
    });

    test('should throw ParseException for invalid color', () {
      expect(
        () => parser.parsePointFromString('1.0 2.0 yellow'),
        throwsA(isA<ParseException>()),
      );
    });

    test('should throw ParseException for invalid coordinates', () {
      expect(
        () => parser.parsePointFromString('abc 2.0 red'),
        throwsA(isA<ParseException>()),
      );
    });

    test('should throw ParseException for insufficient parameters', () {
      expect(
        () => parser.parsePointFromString('1.0 red'),
        throwsA(isA<ParseException>()),
      );
    });

    test('should throw ParseException for unknown point type', () {
      expect(
        () => parser.parsePointFromString('unknown_type 1.0 2.0 red'),
        throwsA(isA<ParseException>()),
      );
    });

    test('should parse multiple points from string', () {
      const testData = '''
        1.0 2.0 red
        weighted_point 3.0 4.0 green 5.5
        lined_point 5.0 6.0 blue 7.0
      ''';

      final points = parser.parsePointsFromString(testData);
      expect(points.length, 3);
      expect(points[0], isA<ColoredPoint>());
      expect(points[1], isA<WeightedPoint>());
      expect(points[2], isA<LinedPoint>());
    });

    test('should skip invalid lines when parsing multiple points', () {
      const testData = '''
        1.0 2.0 red
        invalid line
        3.0 4.0 green
      ''';

      final points = parser.parsePointsFromString(testData);
      expect(points.length, 2);
    });
  });

  group('DistanceCalculator Tests', () {
    test('should calculate 2D distance correctly', () {
      final point = ColoredPoint(x: 3.0, y: 4.0, color: 'red');
      expect(DistanceCalculator.calculateDistance(point), 5.0);
    });

    test('should calculate 3D distance correctly', () {
      final point = LinedPoint(x: 2.0, y: 3.0, z: 6.0, color: 'red');
      expect(DistanceCalculator.calculateDistance(point), 7.0);
    });

    test('should find closest point to origin', () {
      final points = [
        ColoredPoint(x: 5.0, y: 5.0, color: 'red'),
        ColoredPoint(x: 1.0, y: 1.0, color: 'green'),
        ColoredPoint(x: 3.0, y: 4.0, color: 'blue'),
      ];

      final closest = DistanceCalculator.findClosestToOrigin(points);
      expect(closest?.x, 1.0);
      expect(closest?.y, 1.0);
      expect(closest?.color, 'green');
    });

    test('should return null for empty list', () {
      final closest = DistanceCalculator.findClosestToOrigin([]);
      expect(closest, isNull);
    });
  });
}
