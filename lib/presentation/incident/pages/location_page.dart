import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:inspector/presentation/incident/widget/location_info_bottom_sheet.dart';


@RoutePage()
class LocationPage extends StatefulWidget {
  final IncidentTypeStatic incidentTypeStatic;
  final bool isWidget;
  const LocationPage({
    required this.incidentTypeStatic,
    this.isWidget=false,
    super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}




class _LocationPageState extends State<LocationPage> with WidgetsBindingObserver {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  Marker? _marker;

  int id =1;

  final TextEditingController _controller = TextEditingController();

  // قائمة المدن في السعودية
  final List<String> saudiCities = const [
    'الرياض / Riyadh',
    'جدة / Jeddah',
    'مكة المكرمة / Mecca',
    'المدينة المنورة / Medina',
    'الدمام / Dammam',
    'الخبر / Khobar',
    'الطائف / Taif',
    'أبها / Abha',
    'تبوك / Tabuk',
    'جازان / Jazan',
    'حائل / Hail',
    'ينبع / Yanbu',
    'نجران / Najran',
    'القصيم / Al Qassim',
    'الاحساء / Al Ahsa',
    'بيشة / Bisha',
    'عرعر / Arar',
    'سكاكا / Sakaka',
    'القنفذة / Al Qunfudhah',
    'بريدة / Buraidah',
    'الجبيل / Jubail',
    'الخفجي / Khafji',
    'النعيرية / An Nairyah',
    'الرس / Ar Rass',
    'حفر الباطن / Hafr Al Batin',
    'ضباء / Duba',
  ];


  List<String> filteredCities = [];

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCities = [];
      } else {
        filteredCities = saudiCities
            .where((city) => city.contains(query))
            .toList();
      }
    });
  }

  void _onCitySelected(String city) {
    _controller.text = city;
    setState(() => filteredCities = []);
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getCurrentLocation();
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
    _mapController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print("App resumed - Attempting to get current location again.");
      _getCurrentLocation(); // Re-attempt to get location
    }
  }




  Future<void> _getCurrentLocation1() async {

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print("Permission denied after request.");
        // Optionally, show a dialog or message to the user here
        // explaining that the feature won't work without permission.
        // For example:
        // if (mounted) { // Check if the widget is still in the tree
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text("Location permission denied. Map functionality will be limited.")),
        //   );
        // }
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        print("Permission denied forever.");
        // Guide user to app settings
        // if (mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text("Location permission permanently denied. Please enable it in app settings.")),
        //   );
        //   // await Geolocator.openAppSettings(); // Option to take user to settings
        // }
        return;
      }
    }


    // Check service status AFTER permissions are sorted (or at least attempted)
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();

      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("Location services are disabled. Please enable them.")),
      //   );
      //   // await Geolocator.openLocationSettings(); // Opens system UI
      // }
      return;
    }


    print("Getting current position...");
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Position obtained: $position");

      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _marker = Marker(
            markerId:  MarkerId('marker_${id++}'),
            position: _currentPosition!,
            draggable: true,
            onDragEnd: (newPosition) {
              if (mounted) {
                setState(() {
                  _currentPosition = newPosition;
                });
              }
            },
          );
        });

        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition!, 15),
        );
      }
    } catch (e) {
      print("Error getting location: $e");
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("Error getting location: $e")),
      //   );
      // }
    }
  }


  final List<Marker> _markers = []; // ✅ store multiple markers



  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
    }

    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _markers.clear();
          _markers.addAll(_generateRandomMarkers(_currentPosition!)); // ✅ generate random pins
        });

        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition!, 15),
        );
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  /// ✅ Generate random nearby markers (about 300–500 meters away)
  List<Marker> _generateRandomMarkers(LatLng base) {
    final random = Random();
    List<Marker> markers = [];

    for (int i = 0; i < 5; i++) {
      // about 0.002–0.004 degrees ~ 300–500m roughly
      final latOffset = (random.nextDouble() - 0.5) / 125;
      final lngOffset = (random.nextDouble() - 0.5) / 125;
      final randomPosition = LatLng(
        base.latitude + latOffset,
        base.longitude + lngOffset,
      );

      markers.add(
        Marker(
          markerId: MarkerId('random_$i'),
          position: randomPosition,
          onTap: () => _showMarkerDetails(randomPosition, i),

          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure,),
        ),
      );
    }
    return markers;
  }

  void _showMarkerDetails(LatLng pos, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return LocationInfoBottomSheet();
        return  Container(
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: const Color(0x40000000), // #00000040
                offset: const Offset(0, -3),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'المنشأة',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),






                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), // اختياري
                  ),
                  child:  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'عناية المسافر',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFf9f9f9),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: Color(0xffd6d5d5)),
                              ),
                              child: const Center(
                                child: Text(
                                  'رقم الترخيص : HOTEL004',
                                  style: TextStyle(
                                    color: Color(0xff005F73),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SingleChildScrollView(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                  color: Color(0xFFe9faf0),
                                  borderRadius: BorderRadius.circular(40)
                                ),

                                child: Text('اتجاهات',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16

                                ),),
                              )
                            ],
                          ),
                        ),


                        const SizedBox(height: 10),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.location_on,
                                size: 22,
                                color: Color(0xFFB1B1B1),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'منطقة مكة المكرمة، مكه المكرمه، المسفلة، شارع إبراهيم الخليل',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '1.8 KM',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),



                const SizedBox(height: 10,),





                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: PrimaryButton(onPressed: (){

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();




                  }, child: Text('next'.tr())),
                ),
                const SizedBox(height: 20,),


              ],
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.isWidget?null:  AppBarWidget(titleWidget: Text('select_your_location'.tr(),
        style:  const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
        ),)),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(

            onTap: (LatLng tappedPosition) {
              // Move camera to tapped location
              _mapController!.animateCamera(
                CameraUpdate.newLatLng(tappedPosition),
              );

              // Add/update marker at tapped location
              setState(() {
                _marker = Marker(
                  draggable: true,
                  markerId: const MarkerId('selected'),
                  position: tappedPosition,
                );
                _currentPosition = tappedPosition; // update current position
              });
            },

            initialCameraPosition: CameraPosition(
              target: _currentPosition!,
              zoom: 15,
            ),
            //markers: _marker != null ? {_marker!} : {},
            markers: Set<Marker>.of(_markers),
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),

          if(!widget.isWidget)
          Positioned(
              top : 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: MediaQuery.sizeOf(context).width-20,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [


                      SizedBox(
                        width: 45,
                        height: 45,
                        child: InkWell(
                          onTap: (){
                            _getCurrentLocation();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(16)
                            ),
                            child: Center(
                              child: Assets.icons.search.image(
                                  width: 21,
                                  height: 21

                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),

                      Builder(
                          builder: (context) {

                            return Expanded(
                              child:    Autocomplete<String>(
                                optionsBuilder: (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text.isEmpty) {
                                    return const Iterable<String>.empty();
                                  }
                                  return saudiCities.where((city) =>
                                      city.contains(textEditingValue.text)); // بحث جزئي بالعربية
                                },
                                onSelected: (String selection) {
                                  print('city_selected'.tr()+ ': $selection');
                                },
                                fieldViewBuilder:
                                    (context, controller, focusNode, onEditingComplete) {

                                  return    TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    onEditingComplete: onEditingComplete,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                                      filled: true,
                                      fillColor: const Color(0xFFF9F9F9),
                                      hintText: 'geographic_location'.tr(),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12), // rounded corners
                                        borderSide: BorderSide.none, // no visible border
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  );
                                },
                                optionsViewBuilder: (context, onSelected, options) {
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(12),
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(maxHeight: 200),
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: options.length,
                                          itemBuilder: (context, index) {
                                            final option = options.elementAt(index);
                                            return ListTile(
                                              title: Text(option),
                                              onTap: () => onSelected(option),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                      ),

                    ],
                  ),
                ),
              )),

          Positioned(
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [

                    InkWell(
                      onTap: (){
                        _getCurrentLocation();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),

                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.primary2Color
                          ),
                          child:  Center(
                            child: Assets.icons.mapPoint.image(
                                width: 21,
                                height: 21
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),

      bottomNavigationBar:widget.isWidget?null: Container(
        height: 105,
        child:  Column(

          children: [

            const  SizedBox(height: 30,),


            SizedBox(
              child: PrimaryButton(
                onPressed: (){
                  Navigator.of(context).pop();

                  // if(widget.incidentTypeStatic==IncidentTypeStatic.menual){
                  // //  context.router.push( SelectFacilityRoute());
                  // }else if(widget.incidentTypeStatic==IncidentTypeStatic.ai){
                  //   // context.router.push(CreateIncidentWithAiRoute(latLng: _currentPosition!));
                  //   //context.router.push( SelectFacilityRoute(
                  //   //   incidentTypeStatic: IncidentTypeStatic.ai,
                  //   // ));
                  // }


                },
                child: Text('next'.tr() ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}

