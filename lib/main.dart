import 'services/file_proccesor.dart';
import 'services/point_parser.dart';
import 'utils/distance_calculator.dart';
import 'utils/exceptions.dart';
import 'utils/output_printer.dart';

const String dataPath = 'input_data.txt';

void main() {
  try {
    final lines = FileProccesor.readDataFromFile(dataPath);
    final fileContent = lines.join('\n');
    final points = PointParser().parsePointsFromString(fileContent);

    OutputPrinter.printPointsInfo(points);
    OutputPrinter.printClosestPointInfo(
      DistanceCalculator.findClosestToOrigin(points),
    );
  } on ParseException catch (e) {
    print('Ошибка парсинга из файла: $e');
  } catch (e) {
    print('Ошибка: $e');
  }

  print('\n=== ОБРАБОТКА ИЗ СТРОКИ ===');
  const testData = '''
   colored_point 1.0 2.0 red
   weighted_point 3.0 4.0 green 5.5
   timed_point 5.0 6.0 blue 2023-01-01 12:00:00
   colored_point 0.5 0.5 red
   invalid 10.0 20.0 yellow
   ''';

  try {
    final stringPoints = PointParser().parsePointsFromString(testData);
    OutputPrinter.printPointsInfo(stringPoints);
    OutputPrinter.printClosestPointInfo(
      DistanceCalculator.findClosestToOrigin(stringPoints),
    );
  } on ParseException catch (e) {
    print('Ошибка парсинга из строки: $e');
  }
}
