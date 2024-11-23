# safe_json

[![pub package](https://img.shields.io/pub/v/safe_json.svg)](https://pub.dev/packages/safe_json)
[![CI](https://img.shields.io/github/actions/workflow/status/ChadCN/safe_json/publish.yml?logo=github-actions&logoColor=white)](https://github.com/ChadCN/safe_json/actions)
[![Code size](https://img.shields.io/github/languages/code-size/ChadCN/safe_json?logo=github&logoColor=white)](https://github.com/ChadCN/safe_json)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ChadCN/safe_json?tab=MIT-1-ov-file#)

The primary goal of this library is to find out bugs in the early stages of development when get JSON values. 

## Features

- Safely get JSON/Map/Dictionary values without crash.
- Provide default values when fails.
- Log Error with description and file location.

## Examples

```dart
import 'package:safe_json/safe_json.dart';

class User {
  final String name;
  final int age;
  final String school;
  final List<String> articles;
  final List<Vehicle> vehicles;

  User(
      {required this.name,
        required this.age,
        required this.school,
        required this.articles,
        required this.vehicles});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json.safeString('name', defaultValue: 'John'),
      age: json.safeInt('age'),
      school: json.safeString('school', defaultValue: 'MIT'),
      articles: json.safeList<String>('articles'),
      vehicles: json.safeList<Vehicle>('vehicles',
          itemParse: (json) => Vehicle.fromJson(json)),
    );
  }
}

class Vehicle {
  final String make;
  final String model;

  Vehicle({required this.make, required this.model});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      make: json.safeString('make'),
      model: json.safeString('model'),
    );
  }

  @override
  String toString() {
    return '$make $model';
  }
}

void main() {
  Map<String, dynamic> json = {
    'age': '30.0',
    'articles': [
      'article1',
      'article2',
    ],
    'vehicles': [
      {'make': 'Toyota', 'model': 'Camry'},
      {'make': 'Honda', 'model': 'Accord'},
    ],
  };

  User user = User.fromJson(json);

  print(user.name); // John
  print(user.age); // 30
  print(user.school); // MIT
  print(user.articles); // [article1, article2]
  print(user.vehicles); // [Toyota Camry, Honda Accord]
}

//set to true if want to disable error logging (usually in production)
SafeJsonLibrary.skipLog = true; 

//set the stacktrace count showing in console
SafeJsonLibrary.stackTraceCount = 1; 
```

## Console Logs

```console
┌────────────────────────────────────────────────────────────────────────────────────────────────────
│ ⚠️ json['name'] return default value
├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
│ value is null
│ package:your-project-name/models/user_model.dart:22:19
│ package:your-project-name/pages/home_page.dart:75:29
└────────────────────────────────────────────────────────────────────────────────────────────────────
```
