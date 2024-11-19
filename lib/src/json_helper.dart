import 'package:safe_json/src/ansi_color.dart';
import 'package:safe_json/src/pretty_printer.dart';
import 'package:safe_json/src/safe_json_library.dart';
import 'package:safe_json/src/stack_trace_formatter.dart';

/// JsonHelper is an extension on Map<dynamic, dynamic> that provides safe methods to parse json values.
extension JsonHelper on Map<dynamic, dynamic> {

  /// Safely parse a json value to an integer.
  int safeInt(String key, {int defaultValue = 0}) {
    try {
      final result = this[key];
      if (result is String) {
        return double.parse(result).toInt();
      }
      if (result is double) {
        return result.toInt();
      }
      return result;
    } catch (error, stackTrace) {
      _safeJsonPrint(key, error, stackTrace, defaultValue);
      return defaultValue;
    }
  }

  /// Safely parse a json value to a boolean.
  bool safeBool(String key, {bool defaultValue = false}) {
    try {
      final result = this[key];
      if (result is bool) {
        return result;
      }
      if (result is String) {
        return result.toLowerCase() == 'true' || result == '1';
      }
      if (result is int) {
        return result == 1;
      }
      return defaultValue;
    } catch (error, stackTrace) {
      _safeJsonPrint(key, error, stackTrace, defaultValue);
      return defaultValue;
    }
  }

  /// Safely parse a json value to a string.
  String safeString(String key, {String defaultValue = ''}) {
    try {
      if (this[key] == null) {
        throw 'value is null';
      }
      return this[key].toString();
    } catch (error, stackTrace) {
      _safeJsonPrint(key, error, stackTrace, defaultValue);
      return defaultValue;
    }
  }

  /// Safely parse a json value to a double.
  double safeDouble(String key, {double defaultValue = 0}) {
    try {
      final result = this[key];
      if (result is String) {
        return double.parse(result);
      }
      if (result is int) {
        return result.toDouble();
      }
      return result;
    } catch (error, stackTrace) {
      _safeJsonPrint(key, error, stackTrace, defaultValue);
      return defaultValue;
    }
  }

  /// Safely parse a json value to a DateTime.
  DateTime? safeDate(String key, {bool toLocal = true}) {
    try {
      if (this[key] == '') {
        return null;
      }
      final date = DateTime.parse(this[key]);
      if (toLocal) {
        return date.toLocal();
      }
      return date;
    } catch (error, stackTrace) {
      _safeJsonPrint(key, error, stackTrace, null);
      return null;
    }
  }

  /// Safely parse a json value to a List.
  List<T> safeList<T>(String key,
      {T Function(Map<String, dynamic>)? itemParse,
      List<T> defaultValue = const []}) {
    try {
      final list = (this[key] as List).map((e) {
        if (itemParse != null) {
          return itemParse(e);
        }
        return e as T;
      }).toList();
      return list;
    } catch (error, stackTrace) {
      _safeJsonPrint(key, error, stackTrace, defaultValue);
      return defaultValue;
    }
  }

  /// Safely parse a json value to a Map<String, dynamic>.
  Map<String, dynamic> safeMap(
    String key, {
    Map<String, dynamic> defaultValue = const {},
  }) {
    try {
      return this[key];
    } catch (error, stackTrace) {
      _safeJsonPrint(key, error, stackTrace, defaultValue);
      return defaultValue;
    }
  }

  /// Safely parse a json value to a Map<String, dynamic>.
  Map<String, dynamic> safeJson(
    String key, {
    Map<String, dynamic> defaultValue = const {},
  }) {
    return safeMap(key, defaultValue: defaultValue);
  }

  /// Check if a key exists in the json.
  bool exist(String key) {
    try {
      if (this[key] == null) {
        return false;
      }
      // if (this[key] == {}) {
      //   return false;
      // }
      if (this[key] == '') {
        return false;
      }
      return true;
    } catch (error, stackTrace) {
      _safeJsonPrint(key, error, stackTrace, null);
      return false;
    }
  }

  _safeJsonPrint(String key, Object error, StackTrace stackTrace, dynamic defaultValue) {
    if (SafeJsonLibrary.skipLog) return;
    print(
      PrettyPrinter.prettyPrintLog(
        '⚠️ json[${AnsiColor.green('\'$key\'')}] return default value $defaultValue',
        error.toString().trim(),
        StackTraceFormatter.formatStackTrace(stackTrace),
      ),
    );
  }
}
