import 'package:safe_json/safe_json.dart';

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