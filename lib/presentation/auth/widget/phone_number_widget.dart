import 'package:inspector/presentation/core/utils/validation.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
import 'package:intl_phone_number_input/src/widgets/countries_search_list_widget.dart';
import 'package:intl_phone_number_input/src/utils/util.dart';
import 'package:intl_phone_number_input/src/providers/country_provider.dart';
import 'package:intl_phone_number_input/src/models/country_list.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';

class PhoneNumberWidget extends StatefulWidget {
  final TextEditingController controller;
  final InputDecoration inputDecoration;
  final bool? enabled;
  final Function(bool)? onInputValidated;
  final Function(PhoneNumber)? onInputChanged;
  final Key? textFieldKey;
  final NewPhoneNumber phoneNumber;



  const PhoneNumberWidget({
    super.key,
    required this.controller,
    required this.inputDecoration,
    this.onInputValidated,
    this.onInputChanged,
    this.enabled = true,
    this.textFieldKey,
    required this.phoneNumber,

  });

  @override
  State<PhoneNumberWidget> createState() => _IntoPhoneNumberState();
}

class _IntoPhoneNumberState extends State<PhoneNumberWidget> {


  // Country? country;
  List<Country> countries = [];

  @override
  void initState() {
    loadCountries();
    super.initState();

  }

  Future<bool> init() async {
   if (widget.controller.text.isNotEmpty && widget.controller.text.contains("+")) {
      var phoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(widget.controller.text);
      widget.controller.text = phoneNumber.phoneNumber!.replaceAll('+${phoneNumber.dialCode}', '');

      widget.phoneNumber.dialCode= '+${phoneNumber.dialCode}';
      widget.phoneNumber.phoneNumber= phoneNumber.phoneNumber;
      widget.phoneNumber.isoCode= phoneNumber.isoCode;

      setState(() {});

   }
    return true;
  }



  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: init(),
      builder: (context,snapshot) {
        if(!snapshot.hasData) return SizedBox();
        return Row(
          children: [

            Expanded(
              child: TextFieldWidget(
                textAlign: context.locale.languageCode=='ar'? TextAlign.right:TextAlign.left,
                textDirection: ui.TextDirection.ltr,
                textFieldKey: widget.textFieldKey,
                controller: widget.controller,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  PhoneInputFormatter(
                    defaultCountryCode: widget.phoneNumber.isoCode,
                  ),
                ],
                  validator: (value) => Validation.phoneNumber(value?.replaceAll(' ', "")),

                  hintText: 'رقم الموبايل',
               prefixIcon: Wrap(
              children: [

                SizedBox(
                  width: 80,
                  child: IconButton(onPressed: ()async{
                    var newCountry = await showCountrySelectorBottomSheet(context, countries);
                    //country= newCountry??country;
                    if(newCountry==null) return;

                    widget.phoneNumber.dialCode=newCountry?.dialCode??'';
                    widget.phoneNumber.isoCode=newCountry?.alpha2Code??'';

                    setState(() {});
                  }, icon: Container(
                    //  width: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFCCCCCC)
                  ),
                    child: Row(
                      children: [
                        const Icon(Icons.keyboard_arrow_down_rounded,size: 20,color: Colors.white,),
                        Text(
                          widget.phoneNumber.dialCode,
                          style: const TextStyle(fontSize: 16,color: Colors.white),
                        ),
                      ],
                    ),
                  ),),
                ),
              ],
            )

                // onChanged: (val) {
                //   // final fullNumber = '+${_selectedCountry.phoneCode}$val';
                //   // if (widget.onChanged != null) {
                //   //   widget.onChanged!(fullNumber);
                //   // }
                // },
              ),
            ),
          ],
        );
      },
    );



  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.BOTTOM_SHEET] is selected
  Future<Country?> showCountrySelectorBottomSheet(
      BuildContext inheritedContext, List<Country> countries) {
    return showModalBottomSheet(
      context: inheritedContext,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      useSafeArea: true,
      builder: (BuildContext context) {
        return Stack(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: DraggableScrollableSheet(
              builder: (BuildContext context, ScrollController controller) {
                return Directionality(
                  textDirection: Directionality.of(inheritedContext),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).canvasColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: CountrySearchListWidget(
                      countries,
                      context.locale.languageCode,
                      searchBoxDecoration: InputDecoration(),
                      scrollController: controller,
                      showFlags: true,
                      useEmoji: false,
                      autoFocus:false,
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
      },
    );
  }

  /// loads countries from [Countries.countryList] and selected Country
  void loadCountries({Country? previouslySelectedCountry}) {
    if (this.mounted) {
      List<Country> countries =
      CountryProvider.getCountriesData(countries:[]);

      Country country = previouslySelectedCountry ??
           getInitialSelectedCountry(
            countries,
            widget.phoneNumber.dialCode!,
          );

      print('intial');
      print(country.name);
      // Remove potential duplicates
      countries = countries.toSet().toList();

      // final CountryComparator? countryComparator =
      //     widget.selectorConfig.countryComparator;
      // if (countryComparator != null) {
      //   countries.sort(countryComparator);
      // }

      setState(() {
        this.countries = countries;
       // this.country = country;
        widget.phoneNumber.isoCode = country.alpha2Code;
      });
    }
  }


   Country getInitialSelectedCountry(
      List<Country> countries, String countryCode) {
    return countries.firstWhere((country) => country.dialCode == countryCode,
        orElse: () => countries[0]);
  }


}


class NewPhoneNumber {
   String? phoneNumber;

   String dialCode;

   String? isoCode;


    NewPhoneNumber({
     required this.dialCode, this.isoCode,
     this.phoneNumber,

});


}
