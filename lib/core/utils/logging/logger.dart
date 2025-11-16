import 'dart:convert';

import 'package:logger/logger.dart';

class PLoggerHelper {
  static final Logger _logger =
      Logger(printer: PrettyPrinter(), level: Level.debug);

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error]) {
    _logger.e(message, error: error, stackTrace: StackTrace.current);
  }
}


void pskyLog(
  dynamic msg, {
  String logType = '',
  bool isError = false,
  StackTrace? stackTrace,
}) {
  String formattedMessage;

  // Format the message depending on its type
  if (msg is Map || msg is List) {
    try {
      formattedMessage = const JsonEncoder.withIndent('  ').convert(msg);
    } catch (_) {
      // fallback if serialization fails
      formattedMessage = msg.toString();
    }
  } else {
    formattedMessage = msg.toString();
  }

  final prefix = 'PSKYLOG(${logType.toUpperCase()})';

  if (!isError) {
    PLoggerHelper.info('$prefix : $formattedMessage');
  } else {
    PLoggerHelper.error('$prefix : $formattedMessage',);
  }
}