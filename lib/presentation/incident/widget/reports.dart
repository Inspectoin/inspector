

class Report {
  final String id;
  final int reportNumber;
  final String title;
  final String facilityName;
  final String description;
  final String status;
  final String lastUpdate;
  final String severity;
  final String location;

  Report({
    required this.id,
    required this.reportNumber,
    required this.title,
    required this.facilityName,
    required this.description,
    required this.status,
    required this.lastUpdate,
    required this.severity,
    required this.location,
  });
}

// Populated at app start-up from assets/json/mewa_mock_data.json
// (see MewaMockData.load). The MEWA dataset has no complaint reports, so
// these lists stay empty; each facility carries its own synthesized report.
List<Report> reports = <Report>[];
List<Report> reportsEn = <Report>[];
