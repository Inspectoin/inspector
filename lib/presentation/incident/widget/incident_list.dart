import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/core/blocs/core/base_paginated_list_state.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/widget/error_widget.dart';
import 'package:inspector/presentation/incident/blocs/get_incidents_bloc/get_incidents_bloc.dart';
import 'package:inspector/presentation/incident/blocs/hilight_item_bloc/highlight_item_bloc.dart';
import 'package:inspector/presentation/incident/widget/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncidentList extends StatefulWidget {
  const IncidentList({super.key});

  @override
  State<IncidentList> createState() => _IncidentListState();
}

class _IncidentListState extends State<IncidentList> {
  GetIncidentsBloc getIncidentsBloc=getIt<GetIncidentsBloc>();

  int? highlightedIndex;

  ScrollController scrollController =ScrollController();


  @override
  void initState() {
   // getIncidentsBloc.add(GetIncidentsRequested(page: 1, limit: 10));
    super.initState();

    //addPostFrameCallBack
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
  }
  @override
  Widget build(BuildContext context) {

    var incidents=[
    Incident(id: 'id', userId: 'userId', description: 'description', location: 'location', incidentTypeId: 'incidentTypeId', categoryId: 'categoryId', createdAt: DateTime.now(), updatedAt: DateTime.now(), tenantId: 'tenantId',files: [],status: 'done'),
    Incident(id: 'id', userId: 'userId', description: 'description', location: 'location', incidentTypeId: 'incidentTypeId', categoryId: 'categoryId', createdAt: DateTime.now(), updatedAt: DateTime.now(), tenantId: 'tenantId',files: [],status: 'review'),
    Incident(id: 'id', userId: 'userId', description: 'description', location: 'location', incidentTypeId: 'incidentTypeId', categoryId: 'categoryId', createdAt: DateTime.now(), updatedAt: DateTime.now(), tenantId: 'tenantId',files: [],status: 'done'),
    Incident(id: 'id', userId: 'userId', description: 'description', location: 'location', incidentTypeId: 'incidentTypeId', categoryId: 'categoryId', createdAt: DateTime.now(), updatedAt: DateTime.now(), tenantId: 'tenantId',files: [],status: 'review'),
    Incident(id: 'id', userId: 'userId', description: 'description', location: 'location', incidentTypeId: 'incidentTypeId', categoryId: 'categoryId', createdAt: DateTime.now(), updatedAt: DateTime.now(), tenantId: 'tenantId',files: [],status: 'done'),
    ];

    return ListView.separated(
      itemCount:5,
      shrinkWrap: false,
      controller: scrollController,
      itemBuilder: (context,index){

        final isHighlighted = highlightedIndex == index;



        return BlocProvider.value(
          value: getIt<HighlightItemBloc>(),
          child: BlocListener<HighlightItemBloc,HighlightItemSate>(


            listener: (context,state){

              if(state is HighlightItemRefresh && state.type==HighlightItemType.incident){
                _addItem();
              }

          },
          child:  AnimatedContainer(
            duration: Duration(milliseconds: 800),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isHighlighted ? AppColors.primaryColor.withOpacity(0.5) : Colors.white,
            ),
            child: ReportWidget(report:
            incidents[index]
            ),
          ),),
        );
      },
      separatorBuilder: (context,index){
        return const SizedBox(height: 15,);
      },
    );


  }

  void _addItem() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }

    setState(() {

      highlightedIndex = 0;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => highlightedIndex = null);
    });
  }
}
