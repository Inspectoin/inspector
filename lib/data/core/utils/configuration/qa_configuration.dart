import 'package:inspector/domain/core/utils/app_environment.dart';
import 'package:injectable/injectable.dart';
import 'configuration.dart';

// QA Configuration
@LazySingleton(as: Configuration, env: [AppEnvironment.qa])
class QAConfiguration implements Configuration {
  @override
  String get name => 'qa';

  @override
  String get baseUrl => "pk_test_51NLKIlD7ieb3dBmuTuCI88G5z84d6rHpgKKEZSb3ohqUK9SbqogB5GQvq7JwDNv8pKsIBxoQ6DyXsrxJO2gXGwzD00ljJZTvGi";

  @override
  // TODO: implement tenant
  String get tenant => throw UnimplementedError();

}
