import 'incident_category.dart';

class IncidentType {
  final String id;
  final String key;
  final String name;
  final String description;
  final List<IncidentCategory> categories;

  IncidentType({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
    required this.categories,
  });
}
