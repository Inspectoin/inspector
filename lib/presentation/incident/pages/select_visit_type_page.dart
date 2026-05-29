
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/domain/incident/entities/visites.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/incident/pages/facilities_page.dart';

@RoutePage()
class SelectVisitTypePage  extends StatefulWidget {
  const SelectVisitTypePage({super.key});


  @override
  State<SelectVisitTypePage> createState() => _SelectVisitTypeState();
}

class _SelectVisitTypeState extends State<SelectVisitTypePage> {


  int? selectedIndex;
  @override
  Widget build(BuildContext context) {

   // var list =context.locale.languageCode=='ar'?visitTypes:visitTypesEn ;
    List<String> filters =context.locale.languageCode=='ar'?  visits.map((e)=>e.visitType).toSet().toList():visitsEn.map((e)=>e.visitType).toSet().toList();


    return Scaffold(
      appBar: AppBarWidget(
        titleWidget:  Text('نوع الزيارة'),
        subTitleWidget:  Text('يرجى اختيار نوع الزيارة',
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.grayTextColor
        ),),



      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(children: [

          Expanded(child: ListView.separated(
              itemBuilder: (context,index){
                return Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  child: RadioListTile<int>(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,

                    value: index,                    // unique value for this tile
                    groupValue: selectedIndex,       // currently selected value
                    title: Text(filters[index]),       // item's label
                    onChanged: (int? value) {
                      setState(() {
                        selectedIndex = value;      // update selection
                      });
                    },
                  ),
                );
              },
              separatorBuilder:  (context,index){
                return const SizedBox(height: 20,);
              }, itemCount:filters.length )
          )
        ],),
      ),

      bottomNavigationBar: Container(
        height: 90,
        child:  Column(

          children: [

            const SizedBox(height: 10,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){

                  Navigator.pop(context);

                },
                child: Wrap(
                  children: [
                    Assets.icons.addSquare.image(
                        color: Colors.white,
                        width: 24
                    ),
                    const SizedBox(width: 10,),
                    Text('تحديد نوع'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> visitTypes = ['تفتيش شكوى','تقديم اقتراح','تقديم اقتراح','تحديث معلومات العميل',
  'تحديث معلومات العميل','طلب استرداد','تقديم شكوى عن خدمة','طلب معلومات إضافية'];
List<String> visitTypesEn = [
  'Complaint Inspection',
  'Submit Suggestion',
  'Submit Suggestion',
  'Update Customer Information',
  'Update Customer Information',
  'Refund Request',
  'Service Complaint',
  'Request Additional Information',
];
