import 'models/user.dart';

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
