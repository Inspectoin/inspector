import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/incident/widget/create_visit_bottom_sheet.dart';
import 'package:inspector/presentation/incident/widget/steps_progress_widget.dart';
import 'package:inspector/presentation/incident/widget/tab.dart';
import 'package:signature/signature.dart';
import 'dart:ui' as ui;

@RoutePage()
class SignReportPage extends StatefulWidget {
  const SignReportPage({super.key});

  @override
  State<SignReportPage> createState() => _SignReportPageState();
}

class _SignReportPageState extends State<SignReportPage> {
  @override
  Widget build(BuildContext context) {
    return  const VisitReportScreen();
  }
}



class VisitReportScreen extends StatefulWidget {
  const VisitReportScreen({super.key});

  @override
  State<VisitReportScreen> createState() => _VisitReportScreenState();
}

class _VisitReportScreenState extends State<VisitReportScreen>   with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final SignatureController _signatureController = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 2,
  );

  final SignatureController _signatureController1 = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 2,
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signatureController.dispose();
    super.dispose();
  }



  String selectedSignatureOption = 'facility_signature'.tr(); // default selected



  @override
  Widget build(BuildContext context) {
    //Navigator.of(context).pop();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(titleWidget: Text('visit_report_vs00010039'.tr()),color: Colors.white,),


      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF7F9FA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          child: Column(
            children: [


              const SizedBox(height: 16),

              // Tabs
              // TabBar (built-in)
              Material(
                color: Colors.white,
                elevation: 0.2,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  //height: 70,


                  padding: EdgeInsets.all(5),
                  child: TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    dividerHeight: 0,
                    labelColor: Colors.white,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,

                    unselectedLabelColor: AppColors.secondaryColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    //  indicatorColor: AppColors.redColor,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorWeight: 3,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.primaryColor,

                    ),
                    tabs: [
                      Tab(

                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("facility_signature".tr()),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            // border: Border.all(color: AppColors.primaryColor, width: 1)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("inspector".tr()),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Step Progress
              StepsProgressWidget(
                currentStep: 3,
                visitNumber: 'LS00010039',
              ),


              const SizedBox(height: 20),



               Expanded(
                   child: TabBarView(
                     physics: NeverScrollableScrollPhysics(),
                   controller: _tabController,
                   children: [
                 page(
                   name: "abdulrahman_bin_mohammed_al_dosari".tr(),
                   id:"1023456789",
                   email: "sami.alqahtani@example.sa",
                   phone: "+966501234567",
                   controller: _signatureController,
                   index: 0,
                 ),
                 page(
                   name: "sami_bin_abdullah_al_qahtani".tr(),
                   id: "2098765432",
                   email: "abdulrahman.dosari@example.sa",
                   phone: "+966512345678",
                     controller: _signatureController1,
                   index: 1
                 ),
               ]))
            ],
          ),
        ),

      ),
      bottomNavigationBar: Container(
        height: 90,
        child:  Column(

          children: [

            const SizedBox(height: 10,),

            SizedBox(
              child: PrimaryButton(
                onPressed: () async{






                await  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: false,
                    builder: (context) => const CreateVisitBottomSheet(),
                  );

                  int count = 0;
                  context.router.popUntil((_) => count++ >= 4);

                },
                child: Text('save'.tr() ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget page({
    required String name,
    required String id,
    required String email,
    required String phone,
    required SignatureController controller,
    required int index,
}) {

    return  SingleChildScrollView(
      child: Column(
        children: [
          // Info fields
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:  [
              _InfoChip(id),
              _InfoChip(name),
              _InfoChip(phone),
              _InfoChip(email),
            ],
          ),
      
          const SizedBox(height: 20),
      
          // Signature type radio buttons
          Material(
            color: Colors.white,
            elevation: 0.4,
            borderRadius: BorderRadius.circular(24),
      
            child: Container(
              padding: const EdgeInsets.all(20),
      
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(index==0)// show only for facility ..
                  Row(
                    children: [
                      _SignatureRadio(
                        label: 'unable_to_sign'.tr(),
                        value: 'unable_to_sign'.tr(),
                        groupValue: selectedSignatureOption,
                        onChanged: (value) => setState(() {
                          print(value);
                          print(selectedSignatureOption);

                          selectedSignatureOption = value!;


                        }),
                      ),
                      const SizedBox(width: 16),
                      _SignatureRadio(
                        label: 'refused_to_sign'.tr(),
                        value: 'refused_to_sign'.tr(),
                        groupValue: selectedSignatureOption,
                        onChanged: (value) => setState(() {
                          selectedSignatureOption = value!;
                        }),
                      ),
                    ],
                  ),
      
                  const SizedBox(height: 12),

                  if(selectedSignatureOption== 'unable_to_sign'.tr() && index==0)
                    Container(
                      height: 150,

                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE6EAEA)),
                      ),
                      child: Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('unable_to_sign'.tr(),
                          style: TextStyle(
                            fontSize: 25
                          ),),
                          TextButton(
                            onPressed: (){
                              selectedSignatureOption = '';
                              setState(() {

                              });
                            },
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.arrow_back,size: 13,),
                                const SizedBox(width: 5,),
                                Text('back'.tr(),
                                  style: TextStyle(
                                      fontSize: 12
                                  ),),
                              ],
                            ),
                          ),
                        ],
                      )),
                    )
                  else  if(selectedSignatureOption== 'refused_to_sign'.tr()&& index==0)
                    Container(
                      height: 150,

                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE6EAEA)),
                      ),
                      child: Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('refused_to_sign'.tr(),
                            style: TextStyle(
                                fontSize: 25
                            ),),

                          TextButton(
                            onPressed: (){
                              selectedSignatureOption = '';
                              setState(() {

                              });
                            },
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.arrow_back,size: 13,),
                                const SizedBox(width: 5,),
                                Text('back'.tr(),
                                  style: TextStyle(
                                      fontSize: 12
                                  ),),
                              ],
                            ),
                          ),
                        ],
                      )),
                    )
                  else
                  // Signature pad
                  Column(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE6EAEA)),
                        ),
                        child: Signature(
                          controller: controller,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: (){
                          controller.clear();
                        },
                        borderRadius: BorderRadius.circular(18),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => controller.clear(),
                              icon: const Icon(Icons.delete_outline,
                                  color: Color(0xFF5BA199)),
                            ),
                            Text(
                              'clear_signature'.tr(),
                              style: TextStyle(color: Colors.grey),
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
      
          const SizedBox(height: 20),
        ],
      ),
    );

  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
     // width: (MediaQuery.of(context).size.width / 2) - 20,
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6EAEA)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
      ),
    );
  }



}
class _SignatureRadio extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const _SignatureRadio({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFe6eaea),width: 1)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(

              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: const Color(0xFF5BA199), // your custom color
            ),
           // const SizedBox(width: 5),
            Text(
              label,

              style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

