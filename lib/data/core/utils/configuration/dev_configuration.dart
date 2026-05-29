import 'package:inspector/domain/core/utils/app_environment.dart';
import 'package:injectable/injectable.dart';

import 'configuration.dart';


// Development Configuration
@LazySingleton(as: Configuration, env: [AppEnvironment.dev])
class DevConfiguration implements Configuration {
  @override
  String get name => 'dev';

  @override
  String get baseUrl => "http://174.138.70.82:5000";

  @override
  String get tenant => "B5CB8EC8F9C56E2BA75EA0E18DFEFFB9B4A95994B14B07B8E03A0F2B91A6ACD6";

}
