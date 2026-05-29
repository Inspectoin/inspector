import 'package:auto_route/annotations.dart';
import 'package:inspector/domain/incident/entities/incident_category.dart';
import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/incident/blocs/create_incident_bloc/create_incident_bloc.dart';
import 'package:inspector/presentation/incident/blocs/get_incident_types_bloc/get_incident_types_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ReportDetailsPage extends StatefulWidget {
  const ReportDetailsPage({super.key});

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
