import 'package:safe_json/safe_json.dart';
import 'vehicle.dart';

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
