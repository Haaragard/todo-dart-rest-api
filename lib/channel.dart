import 'controllers.dart';
import 'todo_dart_rest_api.dart';

class TodoDartRestApiChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    // context = contextWithConnectionInfo(options.configurationFilePath);

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      'dart_app', 'dart_app', 'localhost', 5432, 'dart_app');

      context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
    .route("/users/[:id]")
    .link(() => UserController(context));

    return router;
  }

  ManagedContext contextWithConnectionInfo(DatabaseConfiguration connectionInfo) {
    final ManagedDataModel dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final PostgreSQLPersistentStore psc = PostgreSQLPersistentStore(
      connectionInfo.username,
      connectionInfo.password,
      connectionInfo.host,
      connectionInfo.port,
      connectionInfo.databaseName
    );

    return ManagedContext(dataModel, psc);
  }
}

class MyAppConfiguration extends Configuration {
  MyAppConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConfiguration database;
}