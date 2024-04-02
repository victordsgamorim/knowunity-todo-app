import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;

  const User({required this.id, required this.name});

  factory User.defaultName(int id) => User(id: id, name: 'User $id');

  factory User.fromMap(Map<String, dynamic> map) {
    final userId = map['id'];
    return User(id: map['id'], name: 'User $userId');
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
