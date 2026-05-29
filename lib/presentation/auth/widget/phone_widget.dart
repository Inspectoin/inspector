
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String fullNumber)? onChanged;

  const CustomPhoneField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  Country _selectedCountry = Country(
    phoneCode: '966',
    countryCode: 'SA',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Saudi Arabia',
    example: '512345678',
    displayName: 'Saudi Arabia',
    displayNameNoCountryCode: 'Saudi Arabia',
    e164Key: '',
  );

  void _pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() => _selectedCountry = country);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Country code selector
        InkWell(
          onTap: _pickCountry,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  '+${_selectedCountry.phoneCode}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Phone input
        Expanded(
          child: TextField(
            controller: widget.controller,
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.right,
            inputFormatters: [
              PhoneInputFormatter(
                defaultCountryCode: _selectedCountry.countryCode,
              ),
            ],
            decoration: const InputDecoration(
              hintText: 'رقم الهاتف',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {
              final fullNumber = '+${_selectedCountry.phoneCode}$val';
              if (widget.onChanged != null) {
                widget.onChanged!(fullNumber);
              }
            },
          ),
        ),
      ],
    );
  }
}
