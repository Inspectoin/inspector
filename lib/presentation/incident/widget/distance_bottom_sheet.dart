import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inspector/app.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import '../../core/theme/app_colors.dart';

class DistanceBottomSheet extends StatelessWidget {
  const DistanceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Text('determined_distance'.tr(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          const SizedBox(height: 8),
           Text(
            'here_you_find_the_distance_between_you_and_the_facility'.tr(),

            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.grayTextColor,fontWeight: FontWeight.w500,fontSize: 12),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text('234_km'.tr(),
                    style: TextStyle(
                        color: Color(0xFF004F3B),
                        fontWeight: FontWeight.w600)),
                Icon(Icons.location_on_outlined,
                    color: Color(0xFF009966)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.info_outlined, color: Color(0xFF009966),),
              SizedBox(width: 4,),
               Expanded(
                 child: Text(
                  'you_are_now_in_the_facility_area'.tr(),
                  maxLines: 2,
                  style: TextStyle(
                      color: Color(0xFF009966),
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                               ),
               ),
            ],
          ),
          const SizedBox(height: 10),
          InspectionRangeMap(),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(20),
          //   child: SizedBox(
          //     height: 250,
          //     child: GoogleMap(
          //
          //       initialCameraPosition: const CameraPosition(
          //         target: LatLng(24.7136, 46.6753), // Center of the range
          //         zoom: 14,
          //       ),
          //       zoomControlsEnabled: false,
          //       myLocationButtonEnabled: false,
          //       circles: {
          //         Circle(
          //           circleId: const CircleId('inspection_range'),
          //           center: const LatLng(24.7136, 46.6753),
          //           radius: 500, // radius in meters (you can adjust)
          //           fillColor: const Color(0x3327AE60), // semi-transparent green
          //           strokeColor: const Color(0xFF27AE60),
          //           strokeWidth: 2,
          //         ),
          //       },
          //       markers: {
          //         const Marker(
          //           markerId: MarkerId('inspection_location'),
          //           position: LatLng(24.7136, 46.6753),
          //           infoWindow: InfoWindow(title: 'موقع المنشأة'),
          //         ),
          //       },
          //     )
          //   ),
          // ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  color: const Color(0xFF27AE60),
                  child: Text('start_visit'.tr(),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.router.push(ReportVisitRoute());
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: PrimaryButton(
                  color: AppColors.secondaryColor,
                  child: Text('back'.tr()),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class InspectionRangeMap extends StatefulWidget {
  const InspectionRangeMap({super.key});

  @override
  State<InspectionRangeMap> createState() => _InspectionRangeMapState();
}

class _InspectionRangeMapState extends State<InspectionRangeMap> {
  static const LatLng inspectionCenter = LatLng(24.7136, 46.6753);
  LatLng? userLocation;
  bool isInsideGreenRange = false;

  @override
  void initState() {
    super.initState();
    _simulateUserLocation(); // Replace this with actual location later
  }

  /// Simulates getting the user's location (replace with real GPS location)
  void _simulateUserLocation() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      userLocation = const LatLng(24.7170, 46.6820); // Example outside green zone
      isInsideGreenRange = _calculateDistanceMeters(
        inspectionCenter.latitude,
        inspectionCenter.longitude,
        userLocation!.latitude,
        userLocation!.longitude,
      ) <=
          500; // within 500m = allowed
    });
  }

  /// Simple distance formula using Haversine
  double _calculateDistanceMeters(
      double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371000; // in meters
    final dLat = (lat2 - lat1) * (3.1415926535 / 180);
    final dLon = (lon2 - lon1) * (3.1415926535 / 180);
    final a =
        (sin(dLat / 2) * sin(dLat / 2)) +
            (cos(lat1 * (3.1415926535 / 180)) *
                cos(lat2 * (3.1415926535 / 180)) *
                sin(dLon / 2) *
                sin(dLon / 2));
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 250,
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: inspectionCenter,
            zoom: 14,
          ),
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          circles: {
            // 🟢 Allowed area
            Circle(
              circleId: const CircleId('allowed_area'),
              center: inspectionCenter,
              radius: 500, // meters
              fillColor: const Color(0x3327AE60), // semi-transparent green
              strokeColor: const Color(0xFF27AE60),
              strokeWidth: 2,
            ),
            // 🔴 Restricted area
            Circle(
              circleId: const CircleId('restricted_area'),
              center: inspectionCenter,
              radius: 1000, // meters
              fillColor: const Color(0x33FF0000), // semi-transparent red
              strokeColor: Colors.red,
              strokeWidth: 1,
            ),
          },
          markers: {
             Marker(
              markerId: MarkerId('facility_location'),
              position: inspectionCenter,
              infoWindow: InfoWindow(title: 'facility_location'.tr()),
            ),
            // if (userLocation != null)
            //   Marker(
            //     markerId: const MarkerId('user_location'),
            //     position: userLocation!,
            //     infoWindow: InfoWindow(
            //       title: isInsideGreenRange
            //           ? 'أنت داخل النطاق المسموح ✅'
            //           : 'خارج النطاق المسموح ❌',
            //     ),
            //     icon: BitmapDescriptor.defaultMarkerWithHue(
            //       isInsideGreenRange
            //           ? BitmapDescriptor.hueGreen
            //           : BitmapDescriptor.hueRed,
            //     ),
            //   ),
          },
        ),
      ),
    );
  }
}
