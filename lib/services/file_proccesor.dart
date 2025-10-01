import 'dart:io';

import 'package:PISprojects/services/point_parser.dart';
import 'package:PISprojects/utils/distance_calculator.dart';
import 'package:PISprojects/utils/output_printer.dart';

import '../utils/exceptions.dart';

class FileProccesor {
  static List<String> readDataFromFile(String dataPath) {
    try {
      final file = File(dataPath);
      if (!file.existsSync()) {
        throw ParseException('Файл "$dataPath" не существует');
      }
      return file.readAsLinesSync();
    } catch (e) {
      throw ParseException('Ошибка при чтении файла "$dataPath": $e');
    }
  }

  static void processFileData(String dataPath) {
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
  }

  static void processStringData() {
    print('\n=== ОБРАБОТКА ИЗ СТРОКИ ===');
    const testData = '''colored_point 1.0 2.0 red 
weighted_point 3.0 4.0 green 5.5
timed_point 5.0 6.0 blue 2023-01-01 12:00:00
colored_point 0.5 0.5 red
colored_point 2.0 3.0 invalid_color
invalid_data
line 4.2 3.2''';

    try {
      final stringPoints = PointParser().parsePointsFromString(testData);
      OutputPrinter.printPointsInfo(stringPoints);
      OutputPrinter.printClosestPointInfo(
        DistanceCalculator.findClosestToOrigin(stringPoints),
      );
    } on ParseException catch (e) {
      print('Ошибка парсинга из строки: $e');
    } catch (e) {
      print(e);
    }
  }
}
