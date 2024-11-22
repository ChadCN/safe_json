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
