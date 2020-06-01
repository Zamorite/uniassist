import 'package:get_it/get_it.dart';
import 'package:uniassist/services/auth.service.dart';
import 'package:uniassist/services/event.service.dart';
import 'package:uniassist/services/note.service.dart';
import 'package:uniassist/services/session.service.dart';
import 'package:uniassist/services/task.service.dart';

//***** Initialize GetIt for dependency injection
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => EventService());
  locator.registerLazySingleton(() => NoteService());
  locator.registerLazySingleton(() => SessionService());
  locator.registerLazySingleton(() => TaskService());
}