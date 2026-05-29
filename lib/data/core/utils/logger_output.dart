import 'package:logger/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsLogOutput extends LogOutput {

  final ConsoleOutput consoleOutput;

  CrashlyticsLogOutput()
      : consoleOutput = ConsoleOutput();


  @override
  void output(OutputEvent event) {
    consoleOutput.output(event);

    // for (var line in event.lines) {
    //   FirebaseCrashlytics.instance.log(line);
    // }
  }
}
