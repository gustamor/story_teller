
import 'package:logger/logger.dart';

abstract class TellLogger {
  final Logger logger = Logger();
  void i(dynamic message);
  void e(dynamic message);
  void d(dynamic message);
}
