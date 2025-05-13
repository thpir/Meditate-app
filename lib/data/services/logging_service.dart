import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggingService {
  final Logger _logger = Logger(filter: ProductionFilter());

  void t(String message) {
    _logger.t(message);
  }

  void d(String message) {
    _logger.d(message);
  }

  void i(String message) {
    _logger.i(message);
  }

  void w(String message) {
    _logger.w(message);
  }

  void e(String message) {
    _logger.e(message);
  }

  void f(String message) {
    _logger.f(message);
  }
}

class ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    //kReleaseMode is true in release builds
    return !kReleaseMode;
  }
}