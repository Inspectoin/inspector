import 'package:inspector/domain/point/entities/point.dart';
import 'package:inspector/presentation/points/wdiget/available_point_widget.dart';
import 'package:inspector/presentation/points/wdiget/point_widget.dart';
import 'package:flutter/material.dart';

class PointsList extends StatefulWidget {
  final PointsListType pointsListType;
  const PointsList({
    required this.pointsListType,
    super.key});

  @override
  State<PointsList> createState() => _PointsListState();
}

class _PointsListState extends State<PointsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: false,
      itemBuilder: (context,index){

        if(widget.pointsListType==PointsListType.available)
          return AvailablePointWidget(point: Point());

        return PointWidget(point: Point());
      },
      separatorBuilder: (context,index){
        return const SizedBox(height: 15,);
      },
    );
  }
}

enum PointsListType{all,available,used}
