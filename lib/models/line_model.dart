class LineModel {
  final start;
  final end;
  LineModel({required this.start, required this.end});

  @override
  String toString() {
    return 'Line(x:$start, y:$end, )';
  }
}
