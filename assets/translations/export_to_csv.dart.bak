import 'dart:convert';
import 'dart:io';

Future<void> exportLocalizationToCsv() async {
  final localizationDir = Directory(Directory.current.path+'/assets/translations'); // Updated to point to assets/translations
  final outputCsvFile = File('localization.csv');

  try {

    final languages = localizationDir
        .listSync()
     //   .where((entity) => entity is Directory)
        .where((entity) => entity.path.split('.').last=='json')
        .map((entity) {
         // print(entity.path);
          //print(Platform.pathSeparator);
          print(entity.path.split(Platform.pathSeparator).last);
          return entity.path.split(Platform.pathSeparator).last;
    })
        .toList();

    print("🚀 ~ exportLocalizationToCsv ~ languages: $languages");

    final Map<String, Map<String, Map<String, String>>> data = {};
    String csvData = 'index,key,en,ar,fr\n'; // CSV header

  //  for (final language in languages) {
      //final languageDir = Directory('${localizationDir.path}/$language');
      //final files = languageDir.listSync().whereType<File>().toList();

     // for (final file in files) {
    //  var file =File(languageDir.path);
      var fileEn =File('/Users/zoualfkarhaydar/development/Into/into-mobile/assets/translations/en.json');
      var fileAr =File('/Users/zoualfkarhaydar/development/Into/into-mobile/assets/translations/ar.json');
        final fileContentEn = await fileEn.readAsString();
        final fileContentAr = await fileAr.readAsString();

        try {
          final jsonDataEn = jsonDecode(fileContentEn) as Map<String, dynamic>;
          final jsonDataAr = jsonDecode(fileContentAr) as Map<String, dynamic>;
          for (final key in jsonDataEn.keys) {
            final localizationKeysEn = getLocalizationValueAndKey(jsonDataEn[key], key);
            //final localizationKeysAr = getLocalizationValueAndKey(jsonDataAr[key], key);
            if (!data.containsKey(fileEn.path)) {
              data[fileEn.path] = {};
            }
           // print('======');
            for (final localizationEn in localizationKeysEn) {
              data[fileEn.path]![localizationEn['key']!] ??= {};
              data[fileEn.path]![localizationEn['key']]!['en.json'] = localizationEn['value']!;
             }
          }


          for (final key in jsonDataAr.keys) {
            final localizationKeysAr = getLocalizationValueAndKey(jsonDataAr[key], key);
              if (!data.containsKey(fileAr.path)) {
                data[fileAr.path] = {};
              }
            // print('======');
            for (final localizationEn in localizationKeysAr) {
              data[fileEn.path]![localizationEn['key']!] ??= {};
              data[fileEn.path]![localizationEn['key']]!['ar.json'] = localizationEn['value']!;
            }
          }

        } catch (error) {
          print('Error parsing JSON in file: ${fileEn.path} - $error');
        }
    //  }
   // }

    for (final fileName in data.keys) {
      final splitFileName = fileName.split('/');
      // final fileNameFixed = splitFileName.last.split('.').first;
      final dataValue = data[fileName]!;

      for (int i=0;i<dataValue.keys.length;i++) {
        var key =dataValue.keys.toList()[i];
        final enLocalization = dataValue[key]?['en.json'] ?? '##NONE##';
        final arLocalization = dataValue[key]?['ar.json'] ?? '##NONE##';
        final frLocalization = dataValue[key]?['fr.json'] ?? '##NONE##';

        csvData += '${i+1},"$key","$enLocalization","$arLocalization","$frLocalization"\n';
      }
    }

    await outputCsvFile.writeAsString(csvData);
    print('Localization data exported to ${outputCsvFile.path}');
  } catch (error) {
    print('Error exporting localization data: $error');
  }
}

List<Map<String, String>> getLocalizationValueAndKey(dynamic json, [String parentKey = '']) {
  if (json is! Map) {
    return [
      {'key': parentKey, 'value': json.toString()}
    ];
  }

  final keys = json.keys.cast<String>();
  return keys.expand((key) {
    final fullKey = parentKey.isEmpty ? key : '$parentKey.$key';
    return getLocalizationValueAndKey(json[key], fullKey);
  }).toList();
}

void main() {
  exportLocalizationToCsv();
}
