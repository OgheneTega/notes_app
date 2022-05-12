extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String uppercaseFirst() {
    List arrStr = split(" ");
    String formatted = "";
    for (var part in arrStr) {
      formatted += part.toString().capitalize() + " ";
    }
    return formatted.trim();
  }
}
