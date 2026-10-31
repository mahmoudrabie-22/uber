import 'package:flutter/material.dart';
import 'package:uber/core/constants/colors.dart';
import 'package:uber/features/signup/data/models/country_model.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this._textEditingController,
    this.countryModel,
  });
  final CountryModel? countryModel;
  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: Center(
            widthFactor: 1,
            child: Text(
              '+${countryModel?.callingCode??'00'}' ,
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

          borderSide: BorderSide(color: Colors.transparent),
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
