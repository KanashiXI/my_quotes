import 'package:get_it/get_it.dart';
import 'package:my_quotes/db/dao.dart';
import 'package:my_quotes/db/app_database.dart';
import 'package:my_quotes/home/authors_bloc.dart';

GetIt sl = GetIt();

Future<void> setupServiceLocator() async {
  await _setupDatabase();
  _setupBlocs();
}

Future<void> _setupDatabase() async {
  final database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);

  final client = await database.client;
  final dao = Dao(client);
  sl.registerFactory<Dao>(() => dao);
}

void _setupBlocs() {
  sl.registerFactory<AuthorsBloc>(() {
    return AuthorsBloc(dao: sl.get<Dao>());
  });
}
