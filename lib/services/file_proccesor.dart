import 'dart:io';

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
}
