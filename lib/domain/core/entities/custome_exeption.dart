// Custom exception class
class CustomException implements Exception {
  final dynamic message;

  CustomException([this.message]);

  @override
  String toString() {
    if (message == null) return "";
    return "$message"; // Just return the message without the "Exception" prefix
  }
}