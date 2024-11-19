
import 'dart:math';

class StackTraceFormatter {

  static final _deviceStackTraceRegex = RegExp(r'#[0-9]+\s+(.+) \((\S+)\)');

  /// Filter out the desired stack trace need to be printed.
  static String? formatStackTrace(StackTrace? stackTrace) {
    const methodCount = 10;
    List<String> lines = stackTrace
        .toString()
        .split('\n').map((line) => _cleanFormatLine(line)).toList()
        .where(
          (line) =>
          _findFileStacktraceLine(line) &&
          line.isNotEmpty,
    )
        .toList();
    List<String> formatted = [];

    int stackTraceLength = min(lines.length, methodCount);
    for (int count = 0; count < stackTraceLength; count++) {
      var line = lines[count];
      formatted.add(line.replaceFirst(RegExp(r'#\d+\s+'), ''));
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      // return formatted.join('\n');
      return formatted[0];
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
    return line.startsWith('file://');
  }
}