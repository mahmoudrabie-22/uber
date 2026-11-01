import 'package:flutter/material.dart';
import 'package:uber/core/constants/colors.dart';
import 'package:uber/features/signup/data/models/country_model.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm({super.key, this.countryModel,required this.onChanged});
  final CountryModel? countryModel;
 final void Function(String) onChanged;

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your phone number';
        }

        final phone = value.trim();

        if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(phone)) {
          return 'Please enter a valid Egyptian phone number';
        }

        return null;
      },
      onChanged: widget.onChanged,
      controller: _textEditingController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: Center(
            widthFactor: 1,
            child: Text(
              '+${widget.countryModel?.callingCode ?? '00'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        constraints: BoxConstraints(minHeight: 52),
        hintText: '0100 123 4567',
        hintStyle: TextStyle(fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),

          borderSide: BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),

          borderSide: BorderSide(color: Colors.transparent),
        ),
        fillColor: myGray,
        filled: true,
      ),
    );
  }
}
