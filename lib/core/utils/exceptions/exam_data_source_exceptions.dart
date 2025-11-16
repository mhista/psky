
// ============================================================================
// EXCEPTIONS
// ============================================================================

class ExamDataSourceException implements Exception {
  final String message;
  ExamDataSourceException(this.message);

  @override
  String toString() => 'ExamDataSourceException: $message';
}
