import 'dart:math';
import 'package:safe_json/safe_json.dart';

class StackTraceFormatter {
  static final _deviceStackTraceRegex = RegExp(r'#[0-9]+\s+(.+) \((\S+)\)');

  /// Filter out the desired stack trace need to be printed.
  static String? formatStackTrace(StackTrace? stackTrace) {
    List<String> lines = stackTrace
        .toString()
        .split('\n')
        .map((line) => _cleanFormatLine(line))
        .toList()
        .where((line) => line.isNotEmpty)
        .toList();

    List<String> formatted = [];

    int stackTraceLength = min(lines.length, 20);
    for (int count = 0; count < stackTraceLength; count++) {
      var line = lines[count];
      formatted.add(line.replaceFirst(RegExp(r'#\d+\s+'), ''));
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return _matchStacktraceCount(formatted);
    }
  }

  static String _cleanFormatLine(String line) {
    var match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return '';
    }
    final segment = match.group(2)!;
    return segment;
  }

  static bool _findFileStacktraceLine(String line) {
    return line.contains('json_helper.dart');
  }

  static String _matchStacktraceCount(List<String> lines) {
    int count = SafeJsonLibrary.stacktraceCount;
    bool found = false;
    String result = '';
    for (var line in lines) {
      if (found && count > 0) {
        if (result == '') {
          result = line;
        } else {
          result += '\n$line';
        }
        count--;
      }
      if (found && count == 0) {
        break;
      }
      found = _findFileStacktraceLine(line);
    }
    return result;
  }
}
