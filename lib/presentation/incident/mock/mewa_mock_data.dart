import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:inspector/domain/incident/entities/visites.dart' as ve;
import 'package:inspector/presentation/incident/pages/facilities_page.dart';
import 'package:inspector/presentation/incident/widget/reports.dart';

/// Loads the MEWA (وزارة البيئة والمياه والزراعة) mock dataset bundled at
/// [MewaMockData.assetPath] and adapts it into the legacy in-memory
/// collections the UI already consumes ([facilities], [ve.visits],
/// [reports], ...).
///
/// Call [MewaMockData.instance.load] once during app start-up (before
/// `runApp`) so the collections are populated before any screen builds.
///
/// NOTE: replace this whole mock layer with a real backend data source once
/// the API is available — see the `_meta.usage` note inside the JSON file.

/// ---------------------------------------------------------------------------
/// MEWA models (mirror the JSON structure)
/// ---------------------------------------------------------------------------

class MewaGps {
  final double lat;
  final double lng;

  const MewaGps({required this.lat, required this.lng});

  factory MewaGps.fromJson(Map<String, dynamic> json) => MewaGps(
        lat: (json['lat'] as num?)?.toDouble() ?? 0,
        lng: (json['lng'] as num?)?.toDouble() ?? 0,
      );
}

class MewaInspector {
  final String id;
  final String name;
  final String nameEn;
  final String employeeNumber;
  final String phone;
  final String email;
  final String roleLabelAr;
  final int totalVisits;
  final int resolvedComplaints;
  final double averageRating;
  final List<String> assignedRegions;

  const MewaInspector({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.employeeNumber,
    required this.phone,
    required this.email,
    required this.roleLabelAr,
    required this.totalVisits,
    required this.resolvedComplaints,
    required this.averageRating,
    required this.assignedRegions,
  });

  factory MewaInspector.fromJson(Map<String, dynamic> json) => MewaInspector(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        nameEn: json['nameEn'] as String? ?? '',
        employeeNumber: json['employeeNumber'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String? ?? '',
        roleLabelAr: json['roleLabelAr'] as String? ?? '',
        totalVisits: (json['totalVisits'] as num?)?.toInt() ?? 0,
        resolvedComplaints:
            (json['resolvedComplaints'] as num?)?.toInt() ?? 0,
        averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
        assignedRegions:
            (json['assignedRegions'] as List?)?.cast<String>() ?? const [],
      );
}

class MewaFacility {
  final String id;
  final String facilityCode;
  final String licenseNumber;
  final String facilityType;
  final String facilityTypeLabelAr;
  final String nameAr;
  final String region;
  final String city;
  final String district;
  final String address;
  final MewaGps? gps;
  final double distanceKm;
  final String responsiblePersonName;
  final String phone;
  final String? email;
  final String lastInspectionDate;
  final int openViolations;
  final int riskScore;
  final String riskLevel;
  final String status;

  const MewaFacility({
    required this.id,
    required this.facilityCode,
    required this.licenseNumber,
    required this.facilityType,
    required this.facilityTypeLabelAr,
    required this.nameAr,
    required this.region,
    required this.city,
    required this.district,
    required this.address,
    required this.gps,
    required this.distanceKm,
    required this.responsiblePersonName,
    required this.phone,
    required this.email,
    required this.lastInspectionDate,
    required this.openViolations,
    required this.riskScore,
    required this.riskLevel,
    required this.status,
  });

  factory MewaFacility.fromJson(Map<String, dynamic> json) => MewaFacility(
        id: json['id'] as String? ?? '',
        facilityCode: json['facilityCode'] as String? ?? '',
        licenseNumber: json['licenseNumber'] as String? ?? '',
        facilityType: json['facilityType'] as String? ?? '',
        facilityTypeLabelAr: json['facilityTypeLabelAr'] as String? ?? '',
        nameAr: json['nameAr'] as String? ?? '',
        region: json['region'] as String? ?? '',
        city: json['city'] as String? ?? '',
        district: json['district'] as String? ?? '',
        address: json['address'] as String? ?? '',
        gps: json['gps'] is Map<String, dynamic>
            ? MewaGps.fromJson(json['gps'] as Map<String, dynamic>)
            : null,
        distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0,
        responsiblePersonName: json['responsiblePersonName'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String?,
        lastInspectionDate: json['lastInspectionDate'] as String? ?? '',
        openViolations: (json['openViolations'] as num?)?.toInt() ?? 0,
        riskScore: (json['riskScore'] as num?)?.toInt() ?? 0,
        riskLevel: json['riskLevel'] as String? ?? '',
        status: json['status'] as String? ?? '',
      );
}

class MewaVisit {
  final String id;
  final String visitNumber;
  final String visitType;
  final String visitTypeLabelAr;
  final String status;
  final String statusLabelAr;
  final String facilityId;
  final String facilityCode;
  final String facilityNameAr;
  final String facilityTypeLabelAr;
  final String facilityAddress;
  final MewaGps? gps;
  final double distanceKm;
  final String scheduledDate;
  final String scheduledDateDisplay;
  final String scheduledTime;
  final String taskDescription;
  final bool isFollowUp;
  final List<String> violationCategories;
  final String responsiblePersonName;
  final String phone;

  const MewaVisit({
    required this.id,
    required this.visitNumber,
    required this.visitType,
    required this.visitTypeLabelAr,
    required this.status,
    required this.statusLabelAr,
    required this.facilityId,
    required this.facilityCode,
    required this.facilityNameAr,
    required this.facilityTypeLabelAr,
    required this.facilityAddress,
    required this.gps,
    required this.distanceKm,
    required this.scheduledDate,
    required this.scheduledDateDisplay,
    required this.scheduledTime,
    required this.taskDescription,
    required this.isFollowUp,
    required this.violationCategories,
    required this.responsiblePersonName,
    required this.phone,
  });

  factory MewaVisit.fromJson(Map<String, dynamic> json) => MewaVisit(
        id: json['id'] as String? ?? '',
        visitNumber: json['visitNumber'] as String? ?? '',
        visitType: json['visitType'] as String? ?? '',
        visitTypeLabelAr: json['visitTypeLabelAr'] as String? ?? '',
        status: json['status'] as String? ?? '',
        statusLabelAr: json['statusLabelAr'] as String? ?? '',
        facilityId: json['facilityId'] as String? ?? '',
        facilityCode: json['facilityCode'] as String? ?? '',
        facilityNameAr: json['facilityNameAr'] as String? ?? '',
        facilityTypeLabelAr: json['facilityTypeLabelAr'] as String? ?? '',
        facilityAddress: json['facilityAddress'] as String? ?? '',
        gps: json['gps'] is Map<String, dynamic>
            ? MewaGps.fromJson(json['gps'] as Map<String, dynamic>)
            : null,
        distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0,
        scheduledDate: json['scheduledDate'] as String? ?? '',
        scheduledDateDisplay: json['scheduledDateDisplay'] as String? ?? '',
        scheduledTime: json['scheduledTime'] as String? ?? '',
        taskDescription: json['taskDescription'] as String? ?? '',
        isFollowUp: json['isFollowUp'] as bool? ?? false,
        violationCategories:
            (json['violationCategories'] as List?)?.cast<String>() ??
                const [],
        responsiblePersonName: json['responsiblePersonName'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
      );
}

/// ---------------------------------------------------------------------------
/// Loader + adapter
/// ---------------------------------------------------------------------------

class MewaMockData {
  MewaMockData._();

  static final MewaMockData instance = MewaMockData._();

  static const String assetPath = 'assets/json/mewa_mock_data.json';

  bool _loaded = false;

  late Map<String, dynamic> raw;
  late MewaInspector inspector;
  late List<MewaFacility> mewaFacilities;
  late List<MewaVisit> mewaVisits;

  /// The four mobile home quadrants the legacy UI filters by.
  static const List<String> _quadrantFallback = [
    'scheduled',
    'active',
    'needs_modification',
    'finished',
  ];

  Future<void> load() async {
    if (_loaded) return;

    final jsonStr = await rootBundle.loadString(assetPath);
    raw = json.decode(jsonStr) as Map<String, dynamic>;

    inspector =
        MewaInspector.fromJson(raw['inspector'] as Map<String, dynamic>);

    mewaFacilities = (raw['facilities'] as List? ?? [])
        .map((e) => MewaFacility.fromJson(e as Map<String, dynamic>))
        .toList();

    final visitsJson = raw['visits'] as Map<String, dynamic>? ?? const {};
    mewaVisits = [
      ...(visitsJson['fieldRegulatory'] as List? ?? const []),
      ...(visitsJson['followUp'] as List? ?? const []),
    ].map((e) => MewaVisit.fromJson(e as Map<String, dynamic>)).toList();

    _populateLegacyCollections();
    _loaded = true;
  }

  /// Maps a MEWA visit status onto the legacy home-screen quadrant value the
  /// UI filters on (`active` / `scheduled` / `needs_modification` /
  /// `finished`).
  String _statusToQuadrant(String status) {
    switch (status) {
      case 'active':
        return 'active';
      case 'scheduled':
        return 'scheduled';
      case 'needs_revision':
        return 'needs_modification';
      case 'under_review':
      case 'pending_approval':
      case 'approved':
      case 'closed':
        return 'finished';
      default:
        return 'scheduled';
    }
  }

  void _populateLegacyCollections() {
    // Unique visit-type labels, in first-seen order. These become the filter
    // tabs on the tasks screen, so every facility's `type` must be one of them.
    final visitTypeLabels = <String>[];
    for (final v in mewaVisits) {
      if (!visitTypeLabels.contains(v.visitTypeLabelAr)) {
        visitTypeLabels.add(v.visitTypeLabelAr);
      }
    }
    if (visitTypeLabels.isEmpty) {
      visitTypeLabels.add('زيارة رقابية ميدانية');
    }

    // ----- visits -----
    final legacyVisits = mewaVisits
        .map(
          (v) => ve.Visit(
            id: v.id,
            visitNumber: v.visitNumber,
            visitType: v.visitTypeLabelAr,
            establishmentClassification: '',
            visitStatus: v.statusLabelAr,
            establishmentName: v.facilityNameAr,
            sector: v.facilityTypeLabelAr,
            recordNumber: v.facilityCode,
            distinguishingNumber: '',
            responsiblePerson: v.responsiblePersonName,
            responsiblePersonPhone: v.phone,
            inspectionDepartment: '',
            branch: '',
            region: '',
            city: '',
            district: '',
            street: '',
            creator: inspector.name,
            inspector: inspector.name,
            inspectorId: inspector.id,
            supervisor: '',
            workflow: '',
            creationDate: v.scheduledDate,
            visitDate: v.scheduledDate,
            hasViolations: v.violationCategories.isNotEmpty,
            location: v.facilityAddress,
            contactInfo: ve.ContactInfo(
              contactPerson: v.responsiblePersonName,
              phone: v.phone,
            ),
            lastUpdate: v.scheduledDate,
            compliance: 0,
            fine: 0,
            violations: v.violationCategories.length,
            notes: v.taskDescription,
            status: _statusToQuadrant(v.status),
          ),
        )
        .toList();

    // ----- facilities (+ a synthesized report per facility) -----
    final legacyFacilities = <Facility>[];
    for (var i = 0; i < mewaFacilities.length; i++) {
      final f = mewaFacilities[i];

      MewaVisit? relatedVisit;
      for (final v in mewaVisits) {
        if (v.facilityId == f.id) {
          relatedVisit = v;
          break;
        }
      }

      final type = relatedVisit?.visitTypeLabelAr ??
          visitTypeLabels[i % visitTypeLabels.length];
      final status = relatedVisit != null
          ? _statusToQuadrant(relatedVisit.status)
          : _quadrantFallback[i % _quadrantFallback.length];
      final description = relatedVisit?.taskDescription ??
          'منشأة ${f.facilityTypeLabelAr} ضمن نطاق إشراف الوزارة — '
              'عدد المخالفات المفتوحة: ${f.openViolations}، '
              'مستوى الخطورة: ${f.riskLevel}.';

      legacyFacilities.add(
        Facility(
          id: f.id,
          name: f.nameAr,
          type: type,
          location: f.address,
          licenseNumber: f.licenseNumber,
          status: status,
          color: 'var(--secondary-color)',
          contactInfo: ContactInfo(
            phone: f.phone,
            contactPerson: f.responsiblePersonName,
          ),
          lastUpdate: f.lastInspectionDate,
          distance: f.distanceKm,
          report: Report(
            id: f.id,
            reportNumber: 20001 + i,
            title: f.facilityTypeLabelAr,
            facilityName: f.nameAr,
            description: description,
            status: status,
            lastUpdate: f.lastInspectionDate,
            severity: f.riskLevel,
            location: f.address,
          ),
        ),
      );
    }

    // Assign the legacy globals. The dataset is Arabic-only, so the English
    // collections currently reuse the same Arabic content (mock limitation).
    facilities = legacyFacilities;
    facilitiesEn = legacyFacilities;
    ve.visits = legacyVisits;
    ve.visitsEn = legacyVisits;

    // The MEWA dataset has no citizen-complaint "reports" section; the legacy
    // `reports` list is therefore left empty (each facility still carries its
    // own synthesized report above).
    reports = <Report>[];
    reportsEn = <Report>[];
  }
}
