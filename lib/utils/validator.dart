class Validator {
  static const Set<String> validColors = {'red', 'green', 'blue'};

  static bool isValidColor(String color) =>
      validColors.contains(color.toLowerCase());

  static bool isValidCoordinate(String coordStr) =>
      double.tryParse(coordStr) != null;

  static bool isValidWeight(String weightStr) =>
      double.tryParse(weightStr) != null &&
      (double.tryParse(weightStr) ?? 0) > 0;
}
