class ContactInfo {
  final String contactPerson;
  final String phone;

  ContactInfo({required this.contactPerson, required this.phone});
}

class Visit {
  final String id;
  final String visitNumber;
  final String visitType;
  final String establishmentClassification;
  final String visitStatus;
  final String establishmentName;
  final String sector;
  final String recordNumber;
  final String distinguishingNumber;
  final String responsiblePerson;
  final String responsiblePersonPhone;
  final String inspectionDepartment;
  final String branch;
  final String region;
  final String city;
  final String district;
  final String street;
  final String creator;
  final String inspector;
  final String inspectorId;
  final String supervisor;
  final String workflow;
  final String creationDate;
  final String visitDate;
  final bool hasViolations;
  final String location;
  final ContactInfo contactInfo;
  final String lastUpdate;
  final int compliance;
  final int fine;
  final int violations;
  final String notes;
  final String status;

  Visit({
    required this.id,
    required this.visitNumber,
    required this.visitType,
    required this.establishmentClassification,
    required this.visitStatus,
    required this.establishmentName,
    required this.sector,
    required this.recordNumber,
    required this.distinguishingNumber,
    required this.responsiblePerson,
    required this.responsiblePersonPhone,
    required this.inspectionDepartment,
    required this.branch,
    required this.region,
    required this.city,
    required this.district,
    required this.street,
    required this.creator,
    required this.inspector,
    required this.inspectorId,
    required this.supervisor,
    required this.workflow,
    required this.creationDate,
    required this.visitDate,
    required this.hasViolations,
    required this.location,
    required this.contactInfo,
    required this.lastUpdate,
    required this.compliance,
    required this.fine,
    required this.violations,
    required this.notes,
    required this.status,
  });
}



// Populated at app start-up from assets/json/mewa_mock_data.json
// (see MewaMockData.load). Arabic + English reuse the same MEWA content.
List<Visit> visits = <Visit>[];
List<Visit> visitsEn = <Visit>[];
