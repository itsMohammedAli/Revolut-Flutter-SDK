/// Exception class for Revolut SDK errors
class RevolutSdkException implements Exception {
  final String code;
  final String message;
  final dynamic details;

  const RevolutSdkException({
    required this.code,
    required this.message,
    this.details,
  });

  @override
  String toString() => 'RevolutSdkException($code, $message, $details)';
}
