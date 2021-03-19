import 'package:stack_trace/stack_trace.dart';

class Logger {
  static final isLog = true;
  static final level = Type.DEBUG.index;
  static final tag = 'Reader ConsoleLog';

  static debug(String msg) {
    _log(Type.DEBUG, msg);
  }

  static info(String msg) {
    _log(Type.INFO, msg);
  }

  static warning(String msg) {
    _log(Type.WARNING, msg);
  }

  static error(String msg) {
    _log(Type.ERROR, msg);
  }

  static _log(Type type, String msg) {
    try {
      if (isLog && type.index >= level) {
        final now = DateTime.now();
        String time = '${now.year}/${now.month}/${now.day} ${now.hour}:${now.minute}:${now.second}:${now.millisecond}';
        String screen = Trace.current().frames[2].member.split(".")[0];
        String widget = Trace.current().frames[2].member.split(".")[1];
        print('$tag - ${type.toString()} - $time - $screen - $widget : $msg');
      }
    } catch (error) {
      print(error);
    }
  }
}

enum Type {
  DEBUG,
  INFO,
  WARNING,
  ERROR,
}
