class ExceptionWithFields implements Exception {
  final String message;
  final Map<String, String> fieldErrors;

  ExceptionWithFields({
    required this.message,
    required this.fieldErrors,
  });
}
