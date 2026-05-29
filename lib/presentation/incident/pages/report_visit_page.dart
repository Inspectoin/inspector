
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/questions.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:inspector/presentation/incident/widget/steps_progress_widget.dart';
import 'package:inspector/presentation/incident/widget/upload_file_bottom_sheet.dart';

@RoutePage()
class ReportVisitPage extends StatefulWidget {
  const ReportVisitPage({super.key});

  @override
  State<ReportVisitPage> createState() => _ReportVisitPageState();
}

class _ReportVisitPageState extends State<ReportVisitPage> {


  @override
  Widget build(BuildContext context) {

    return InspectionReportPage();

  }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildQuestion(String question) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RadioRow(label: 'error'.tr()),
            RadioRow(label: 'correct'.tr()),
            Expanded(
              child: Text(
                question,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget buildCollapsibleSection(String title) {
    return ExpansionTile(
      trailing: Icon(Icons.keyboard_arrow_down),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 16),
      ),
      children: [Text('section_content_here'.tr())],
    );
  }
}

class RadioRow extends StatelessWidget {
  final String label;
  const RadioRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Radio(value: true, groupValue: true, onChanged: (val) {}),
      ],
    );
  }
}



/// ==============
class InspectionReportPage extends StatefulWidget {
  const InspectionReportPage({super.key});

  @override
  State<InspectionReportPage> createState() => _InspectionReportPageState();
}

class _InspectionReportPageState extends State<InspectionReportPage>   with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CustomTabListController controller=CustomTabListController();

  final List<String> tabs = [
    "general_cleanliness".tr(),
    // "employees".tr(),
    "rooms".tr(),
    // "customer_service".tr(),
    // "security".tr(),
    // "maintenance".tr(),

  ];
  int selectedOption = 0;

  final options = ["matching".tr(), "not_matching".tr(), "needs_improvement".tr()];

  @override
  void initState() {
    super.initState();


   // inspectionFormEn

    for(int i=0;i<inspectionFormEn.inspectionQuestions.length;i++){
      for(int j=0;j<inspectionFormEn.inspectionQuestions[i].questions.length;j++){
        inspectionFormEn.inspectionQuestions[i].questions[j].answer=null;
        inspectionFormEn.inspectionQuestions[i].questions[j].images=0;
        inspectionFormEn.inspectionQuestions[i].questions[j].files=0;

      }
      }

      for(int i=0;i<inspectionForm.inspectionQuestions.length;i++) {
        for (int j = 0; j <
            inspectionForm.inspectionQuestions[i].questions.length; j++) {
          inspectionForm.inspectionQuestions[i].questions[j].answer = null;
          inspectionForm.inspectionQuestions[i].questions[j].images = 0;
          inspectionForm.inspectionQuestions[i].questions[j].files = 0;
        }
      }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        color: Colors.white,
        titleWidget: Text(
          'visit_report'.tr(),
        ),

      ),
      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20.0),

        child: Column(
          children: [

            const SizedBox(height: 10),


            Container(
              height: 58,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x1A000000), // same as #0000001A
                    offset: const Offset(0, 0),     // x: 0px, y: 0px
                    blurRadius: 8,                  // blur
                    spreadRadius: -12,              // spread (-12)
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),


              child:CustomTabList(
                controller:  controller,
                tabs: tabs,
                onChange: (){

                  setState(() {

                  });
                },
              ),),





            const SizedBox(height: 16),

            // Step Progress
            StepsProgressWidget(
              currentStep: 1,
              visitNumber: 'LS00010039',
            ),
            const SizedBox(height: 24),



            Builder(
              builder: (context) {


                var questions  = context.locale.languageCode=='ar'? inspectionForm.inspectionQuestions[controller.index].questions:
                inspectionFormEn.inspectionQuestions[controller.index].questions;

                return Column(
                  children: [

                    for(int i = 0;i<questions.length;i++)...[
                      CustomExpansionTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${i+1}. ${questions[i].question}',
                                maxLines:3,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        children: [
                          _buildQuestionCard(questions,i)
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],


                  ],
                );
              }
            ),
            // const SizedBox(height: 24),
            //
            // CustomExpansionTile(
            //   title: Row(
            //     children: [
            //       Text(
            //         '2. ${'are_there_rooms_available'.tr()}',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            //       ),
            //     ],
            //   ),
            //   children: [
            //     _buildQuestionCard()
            //   ],
            // ),


            const SizedBox(height: 24),
            //
            // PrimaryButton(onPressed: (){
            //   context.router.push(const ReviewReportVisitRoute());
            // }, child: Text('next'.tr()')),


          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        child:  Column(

          children: [

            const SizedBox(height: 10,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){




                  context.router.push(const ReviewReportVisitRoute());



                },
                child: Text('next'.tr() ),
              ),
            ),
          ],
        ),
      ),
    );
  }





  Widget _buildQuestionCard(List<InspectionQuestion> question,int questionIndex) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Column(
            children: List.generate(options.length, (index) {


            return  CupertinoRadioRow<String?>(
                value: '${options[index]},${question[questionIndex].id}',
              groupValue: question[questionIndex].answer,
                onChanged: (val) => setState(() => question[questionIndex].answer = val),
                title:  Text('${options[index]}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
              );

            }),
          ),

          const SizedBox(height: 16),


          Row(
            children: [
              GestureDetector(
                  onTap: (){
                    pickFilesDirect(context,false,(count,isDocument){

                      if(isDocument){
                        question[questionIndex].files+=count;

                    }else{
                        question[questionIndex].images+=count;

                      }

                      setState(() {

                      });
                    });
                  },
                  child: buildFileButton(Assets.icons.camera.image(), "photos".tr(), const Color(0xFFe9faf0),
                  counter:question[questionIndex].images>0?  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1FC16B)


                    ),
                    child: Center(
                      child: Text(question[questionIndex].images.toString(),style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400
                      ),),
                    ),):null),),

              // if(question[questionIndex].images>0)...[
              //   const SizedBox(width: 5),
              //
              //   Container(
              //     width: 20,
              //     height: 20,
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: Color(0xFF1FC16B)
              //
              //
              //     ),
              //     child: Center(
              //       child: Text(question[questionIndex].images.toString(),style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 14,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400
              //       ),),
              //     ),),
              // ],

              const SizedBox(width: 10),
              GestureDetector(
                  onTap: (){
                    pickFilesDirect(context,true,(count,isDocument){

                      if(isDocument){
                        question[questionIndex].files+=count;

                      }else{
                        question[questionIndex].images+=count;

                      }

                      setState(() {

                      });
                    });
                  },
                  child: buildFileButton(Assets.icons.documentFavorite.image(),
                      "documents".tr(), const Color(0xFFe6eaea),
                      counter: question[questionIndex].files > 0
                          ? Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF1FC16B)),
                              child: Center(
                                child: Text(
                                  question[questionIndex].files.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          : null)),

              // if(question[questionIndex].files>0)...[
              //   const SizedBox(width: 5),
              //
              //   Container(
              //     width: 20,
              //     height: 20,
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: Color(0xFF1FC16B)
              //
              //
              //     ),
              //     child: Center(
              //       child: Text(question[questionIndex].files.toString(),style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 14,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400
              //       ),),
              //     ),),
              // ],
            ],
          ),


          const SizedBox(height: 12),

          // Notes field
          TextFieldWidget(
            maxLines: 3,
            hintText: 'notes'.tr(),
          ),
        ],
      ),
    );
  }

}

Widget buildFileButton(Widget icon, String label, Color color, {int count = 0, Widget? counter}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      children: [
        icon,
        const SizedBox(width: 6),
        Text(label,
          style: const TextStyle( fontSize: 11,fontWeight: FontWeight.w500),
        ),

        if(counter!=null)...[
          const SizedBox(width: 10,),
          counter,
        ],

        // if (count > 0)
        //   Container(
        //     margin: const EdgeInsets.only(right: 6),
        //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        //     decoration: const BoxDecoration(
        //       color: Color(0xFF4CA89A),
        //       shape: BoxShape.circle,
        //     ),
        //     child: Text(
        //       "$count",
        //       style: const TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w500),
        //     ),
        //   ),
      ],
    ),
  );
}



class CustomTabListController{
  int index=0;
}

class CustomTabList extends StatefulWidget {
  final CustomTabListController controller;
  final Function onChange;
  final List<String> tabs;
  const CustomTabList({
    required this.controller,
    required this.onChange,
    required this.tabs,
    super.key});

  @override
  State<CustomTabList> createState() => _CustomTabListState();
}

class _CustomTabListState extends State<CustomTabList> {


  final ScrollController _scrollController = ScrollController();


  void _onTabSelected(int index) {
    if (index ==widget.controller.index) return;

    setState(() => widget.controller.index = index);

    _scrollToCenter(index);

    widget.onChange();
  }

  void _scrollToCenter(int index) {
    // This ensures smooth center alignment like TabBar does
    final screenWidth = MediaQuery.of(context).size.width;
    const itemWidth = 125.0; // Adjust to your tab item width

    final targetOffset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
    final safeOffset = targetOffset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      safeOffset,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }




  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount:widget.tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == widget.controller.index;
          return GestureDetector(
            onTap: () => _onTabSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  width:isSelected? 0:1,
                  color: isSelected? Colors.transparent:Color(0xFFe6eaea),
                ),
                color: isSelected
                    ? const Color(0xFF5BA199)
                    : Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: const Color(0x1A000000),
                    blurRadius: 8,
                    spreadRadius: -4,
                    offset: const Offset(0, 2),
                  )
                ]
                    : [],
              ),
              child: Center(
                child: Text(
                 widget.tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final Color? backgroundColor;
  final Duration duration;
  final Icon? leadingIcon; // optional leading icon

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.backgroundColor,
    this.duration = const Duration(milliseconds: 300),
    this.leadingIcon,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: _toggleExpansion,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

            decoration: BoxDecoration(
            //  color: Colors.white,
              color: widget.backgroundColor ?? Colors.white,

              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x1A000000),
                  blurRadius: 8,
                  spreadRadius: -12,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                if (widget.leadingIcon != null) ...[
                  widget.leadingIcon!,
                  const SizedBox(width: 8),
                ],
                Expanded(child: widget.title),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0, // 180° rotation when expanded
                  duration: widget.duration,
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2,),
        Text('please_select_at_least_one_answer_or_enter_a_note'.tr(),
        style: TextStyle(
          color: Color(0xFFFB3748),
          fontSize: 14,
          fontWeight: FontWeight.w400

        ),),
        const SizedBox(height: 20,),
        SizeTransition(
          sizeFactor: _animation,
          child: Column(children: widget.children),
        ),
      ],
    );
  }
}



class CupertinoRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const CupertinoRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Color(0xFFe6eaea),
            width: isSelected ? 6:3,

          ),
        ),


      ),
    );
  }
}

class CupertinoRadioRow<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Widget title;

  const CupertinoRadioRow({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return Material(
      color: isSelected ? AppColors.background : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      clipBehavior:Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: AppColors.primaryColor.withOpacity(0.1),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [

              const SizedBox(width: 12),
              Expanded(child: title,),

              // Radio circle
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primaryColor : const Color(0xFFe6eaea),
                    width: isSelected ? 6 : 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
