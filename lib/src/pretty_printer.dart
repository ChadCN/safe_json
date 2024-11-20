class PrettyPrinter {
  static String get _topBorder {
    var doubleDividerLine = StringBuffer();
    for (var i = 0; i < 100; i++) {
      doubleDividerLine.write('─');
    }
    return '┌$doubleDividerLine';
  }

  static String get _middleBorder {
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < 100; i++) {
      singleDividerLine.write('┄');
    }
    return '├$singleDividerLine';
  }

  static String get _bottomBorder {
    var doubleDividerLine = StringBuffer();
    for (var i = 0; i < 100; i++) {
      doubleDividerLine.write('─');
    }
    return '└$doubleDividerLine';
  }

  /// Pretty print a log message.
  static String prettyPrintLog(String title, String desc, String? line) {
    var buffer = StringBuffer();

    buffer.writeln(_topBorder);

    buffer.writeln('│ $title');

    buffer.writeln(_middleBorder);

    for (var row in desc.split('\n')) {
      buffer.writeln('│ $row');
    }

    for (var row in (line ?? '').split('\n')) {
      buffer.writeln('│ $row');
    }

    buffer.writeln(_bottomBorder);

    return buffer.toString();
  }
}
