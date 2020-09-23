import 'package:todo_dart_rest_api/todo_dart_rest_api.dart';
import 'package:todo_dart_rest_api/model/user.dart';

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  final _users = [
    {'id': 1, 'name': 'Haaragard'},
    {'id': 2, 'name': 'Yumy'},
    {'id': 3, 'name': 'Diogo'},
    {'id': 4, 'name': 'Amanda'},
    {'id': 5, 'name': 'Borges'},
    {'id': 6, 'name': 'Rodrigues'},
  ];

  @Operation.get()
  Future<Response> getUsers() async {
    final userQuery = Query<User>(context);
    final users = await userQuery.fetch();

    return Response.ok(users);
  }

  @Operation.get('id')
  Future<Response> getUserById(@Bind.path('id') int id) async {
    if (id < 0 || id >= _users.length) {
      return Response.notFound();
    }
    return Response.ok(_users[id]);
  }
}