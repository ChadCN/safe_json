# safe_json

[![pub package](https://img.shields.io/pub/v/safe_json.svg)](https://pub.dev/packages/safe_json)
[![CI](https://img.shields.io/github/actions/workflow/status/ChadCN/safe_json/publish.yml?logo=github-actions&logoColor=white)](https://github.com/ChadCN/safe_json/actions)
[![Code size](https://img.shields.io/github/languages/code-size/ChadCN/safe_json?logo=github&logoColor=white)](https://github.com/ChadCN/safe_json)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ChadCN/safe_json?tab=MIT-1-ov-file#)

Small, easy to use null safety json decoding library. The primary goal of this library is to find out bugs in the early stages of development when parsing JSON values. 

## Features

- Safely parse JSON values to various data types.
- Provide default values when parsing fails.
- Error logging with file location.

## Examples

```dart
final name = json.safeString('name', defaultValue: 'John');

final age = json.safeInt('age');

final articles = json.safeList<String>('articles');

final vehicles = json.safeList<Vehicle>('vehicles', itemParse: (json) => Vehicle.fromJson(json));

//set to true if want to disable error logging (usually in production)
SafeJsonLibrary.skipLog = true; 

//set the stacktrace count showing in console
SafeJsonLibrary.stackTraceCount = 1; 
```

## Console Logs

![](https://github.com/ChadCN/safe_json/blob/main/assets/output.png)
