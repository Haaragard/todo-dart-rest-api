import 'package:todo_dart_rest_api/todo_dart_rest_api.dart';

class User extends ManagedObject<_User> implements _User {}

class _User {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column(unique: true)
  String email;

  @Column()
  String password;
}