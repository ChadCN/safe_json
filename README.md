# safe_json
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
```

## Console Logs

![](https://github.com/ChadCN/safe_json/blob/main/assets/output.png)

## Installation

Add `safe_json` to your `pubspec.yaml` file:

```yaml
dependencies:
  safe_json: ^1.0.0
```