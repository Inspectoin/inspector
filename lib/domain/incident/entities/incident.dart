class Incident {
  final String id;
  final String? userId;
  final String description;
  final String location;
  final String? incidentTypeId;
  final String categoryId;
  final List<String> files;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? tenantId;
  final String? status;

  Incident({
    required this.id,
    required this.userId,
    required this.description,
    required this.location,
    required this.incidentTypeId,
    required this.categoryId,
    required this.files,
    required this.createdAt,
    this.updatedAt,
    required this.tenantId,
    this.status,
  });
}
