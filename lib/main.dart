import 'services/file_proccesor.dart';

const String dataPath = 'input_data.txt';

void main() {
  FileProccesor.processFileData(dataPath);
  FileProccesor.processStringData();
}
