import 'models/point_model.dart';
import 'services/file_proccesor.dart';
import 'services/point_parser.dart';
import 'utils/distance_calculator.dart';
import 'utils/output_printer.dart';

const String dataPath = 'input_data.txt';

void main() {
  try {
    final lines = FileProccesor.readDataFromFile(dataPath);
    final points = lines
        .where((line) => line.trim().isNotEmpty)
        .map(PointParser().parsePointFromString)
        .whereType<ColoredPoint>()
        .toList();

    OutputPrinter.printPointsInfo(points);
    OutputPrinter.printClosestPointInfo(
      DistanceCalculator.findClosestToOrigin(points),
    );
  } catch (e) {
    print('Ошибка: $e');
  }

  print('\n=== ОБРАБОТКА ИЗ СТРОКИ ===');
  const testData = '''
1.0 2.0 red
3.0 4.0 green 5.5
5.0 6.0 blue 2023-01-01 12:00:00
0.5 0.5 red
''';

  final stringPoints = PointParser().parsePointsFromString(testData);
  OutputPrinter.printPointsInfo(stringPoints);
  OutputPrinter.printClosestPointInfo(
    DistanceCalculator.findClosestToOrigin(stringPoints),
  );
}
