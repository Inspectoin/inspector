import 'package:inspector/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {
 await getIt.init( environment: env);
}

Future<void> resetInjection() async {
  await getIt.reset();
}
