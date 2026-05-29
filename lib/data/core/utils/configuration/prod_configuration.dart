import 'package:inspector/domain/core/utils/app_environment.dart';
import 'package:injectable/injectable.dart';
import 'configuration.dart';

// Production Configuration
@LazySingleton(as: Configuration, env: [AppEnvironment.prod])
class ProductionConfiguration implements Configuration {
  @override
  String get name => 'prod';

  @override
  String get baseUrl => "pk_live_51NLKIlD7ieb3dBmuh6qRRpPUxsRGJVLKIKPUSZ69EJka3sQI5rQy6jOPLoIVtcOuQxhiqmTPfMzB1YmGQdJ9pDUh005B0Grg2M";

  @override
  String get tenant => throw UnimplementedError();

}
