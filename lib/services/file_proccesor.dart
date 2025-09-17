import 'dart:io';

class FileProccesor {
  static List<String> readDataFromFile(String dataPath) {
    try {
      final data = File(dataPath);
      return data.readAsLinesSync();
    } catch (e) {
      print(e.toString());
      throw 'Ошибка при чтении файла';
    }
  }
}
