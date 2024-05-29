import 'package:logger/logger.dart';

class GonLog {
  late Logger logger;

  static final GonLog _instance = GonLog._internal();

  factory GonLog() {
    return _instance;
  }

  d(String message) {
    logger.d(message);
  }

  i(String message) {
    logger.i(message);
  }

  e(String message) {
    logger.e(message);
  }

  changeLoggingEnable() {
    logger = Logger(filter: LogEnableFilter());
  }

  GonLog._internal() {
    logger = Logger(printer: PrettyPrinter(methodCount: 0));
  }
}

class LogEnableFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
