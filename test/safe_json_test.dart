import 'package:safe_json/safe_json.dart';
import 'package:test/test.dart';

void main() {
  SafeJsonLibrary.stacktraceCount = 5;
  group('Test safeInt function', () {
    test('int number should be safely decoded', () {
      final json = <String, dynamic>{'key': 1};
      expect(json.safeInt('key'), 1);
    });

    test('double number should be safely decoded', () {
      final json = <String, dynamic>{'key': 1.0};
      expect(json.safeInt('key'), 1);
    });

    test('String number should be safely decoded', () {
      final json = <String, dynamic>{'key': '1'};
      expect(json.safeInt('key'), 1);
    });

    test('text should be safely decoded as default', () {
      final json = <String, dynamic>{'key': 'a string'};
      expect(json.safeInt('key'), 0);
    });

    test('null should be safely decoded as default', () {
      final json = <String, dynamic>{'key': null};
      expect(json.safeInt('key'), 0);
    });

    test('missing key should be safely decoded as default', () {
      final json = <String, dynamic>{};
      expect(json.safeInt('key'), 0);
    });
  });

  group('Test safeBool function', () {
    test('true should be safely decoded', () {
      final json = <String, dynamic>{'key': true};
      expect(json.safeBool('key'), true);
    });

    test('false should be safely decoded', () {
      final json = <String, dynamic>{'key': false};
      expect(json.safeBool('key'), false);
    });

    test('String true should be safely decoded', () {
      final json = <String, dynamic>{'key': 'true'};
      expect(json.safeBool('key'), true);
    });

    test('String false should be safely decoded', () {
      final json = <String, dynamic>{'key': 'false'};
      expect(json.safeBool('key'), false);
    });

    test('String 1 should be safely decoded', () {
      final json = <String, dynamic>{'key': '1'};
      expect(json.safeBool('key'), true);
    });

    test('String 0 should be safely decoded', () {
      final json = <String, dynamic>{'key': '0'};
      expect(json.safeBool('key'), false);
    });

    test('int 1 should be safely decoded', () {
      final json = <String, dynamic>{'key': 1};
      expect(json.safeBool('key'), true);
    });

    test('int 0 should be safely decoded', () {
      final json = <String, dynamic>{'key': 0};
      expect(json.safeBool('key'), false);
    });

    test('text should be safely decoded as default', () {
      final json = <String, dynamic>{'key': 'a string'};
      expect(json.safeBool('key'), false);
    });

    test('null should be safely decoded as default', () {
      final json = <String, dynamic>{'key': null};
      expect(json.safeBool('key'), false);
    });

    test('missing key should be safely decoded as default', () {
      final json = <String, dynamic>{};
      expect(json.safeBool('key'), false);
    });
  });

  group('Test safeDouble function', () {
    test('int number should be safely decoded', () {
      final json = <String, dynamic>{'key': 1};
      expect(json.safeDouble('key'), 1.0);
    });

    test('double number should be safely decoded', () {
      final json = <String, dynamic>{'key': 1.0};
      expect(json.safeDouble('key'), 1.0);
    });

    test('String number should be safely decoded', () {
      final json = <String, dynamic>{'key': '1'};
      expect(json.safeDouble('key'), 1.0);
    });

    test('text should be safely decoded as default', () {
      final json = <String, dynamic>{'key': 'a string'};
      expect(json.safeDouble('key'), 0.0);
    });

    test('null should be safely decoded as default', () {
      final json = <String, dynamic>{'key': null};
      expect(json.safeDouble('key'), 0.0);
    });

    test('missing key should be safely decoded as default', () {
      final json = <String, dynamic>{};
      expect(json.safeDouble('key'), 0.0);
    });
  });

  group('Test safeString function', () {
    test('String should be safely decoded', () {
      final json = <String, dynamic>{'key': 'a string'};
      expect(json.safeString('key'), 'a string');
    });

    test('int should be safely decoded as string', () {
      final json = <String, dynamic>{'key': 1};
      expect(json.safeString('key'), '1');
    });

    test('double should be safely decoded as string', () {
      final json = <String, dynamic>{'key': 1.0};
      expect(json.safeString('key'), '1.0');
    });

    test('null should be safely decoded as default', () {
      final json = <String, dynamic>{'key': null};
      expect(json.safeString('key'), '');
    });

    test('missing key should be safely decoded as default', () {
      final json = <String, dynamic>{};
      expect(json.safeString('key'), '');
    });
  });

  group('Test safeDate function', () {
    test('Date should be safely decoded', () {
      final json = <String, dynamic>{'key': '2021-01-01'};
      expect(json.safeDate('key'), DateTime(2021, 1, 1));
    });

    test('random String should be safely decoded with null', () {
      final json = <String, dynamic>{'key': 'random'};
      expect(json.safeDate('key'), null);
    });

    test('empty string should be safely decoded as null', () {
      final json = <String, dynamic>{'key': ''};
      expect(json.safeDate('key'), null);
    });

    test('null should be safely decoded as null', () {
      final json = <String, dynamic>{'key': null};
      expect(json.safeDate('key'), null);
    });

    test('missing key should be safely decoded as null', () {
      final json = <String, dynamic>{};
      expect(json.safeDate('key'), null);
    });
  });

  group('Test safeList function', () {
    test('List should be safely decoded', () {
      final json = <String, dynamic>{
        'key': [1, 2, 3]
      };
      expect(json.safeList('key'), [1, 2, 3]);
    });

    test('List should be safely decoded with itemParse', () {
      final json = <String, dynamic>{
        'key': [
          {'id': 1},
          {'id': 2},
          {'id': 3}
        ]
      };
      expect(json.safeList('key', itemParse: (json) => json['id']), [1, 2, 3]);
    });

    test('String should be safely decoded as default', () {
      final json = <String, dynamic>{'key': 'a string'};
      expect(json.safeList('key'), []);
    });

    test('null should be safely decoded as default', () {
      final json = <String, dynamic>{'key': null};
      expect(json.safeList('key'), []);
    });

    test('missing key should be safely decoded as default', () {
      final json = <String, dynamic>{};
      expect(json.safeList('key'), []);
    });
  });

  group('Test safeMap function', () {
    test('Map should be safely decoded', () {
      final json = <String, dynamic>{
        'key': {'id': 1}
      };
      expect(json.safeMap('key'), {'id': 1});
    });

    test('String should be safely decoded as default', () {
      final json = <String, dynamic>{'key': 'a string'};
      expect(json.safeMap('key'), {});
    });

    test('null should be safely decoded as default', () {
      final json = <String, dynamic>{'key': null};
      expect(json.safeMap('key'), {});
    });

    test('missing key should be safely decoded as default', () {
      final json = <String, dynamic>{};
      expect(json.safeMap('key'), {});
    });
  });

  group('Test exist function', () {
    test('key should exist', () {
      final json = <String, dynamic>{'key': 'value'};
      expect(json.exist('key'), true);
    });

    test('key should not exist with empty string value', () {
      final json = <String, dynamic>{'key': ''};
      expect(json.exist('key'), false);
    });

    test('key should not exist with null value', () {
      final json = <String, dynamic>{'key': null};
      expect(json.exist('key'), false);
    });

    test('key should not exist', () {
      final json = <String, dynamic>{};
      expect(json.exist('key'), false);
    });
  });
}
