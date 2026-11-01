import 'package:flutter/material.dart';
import 'package:uber/core/constants/colors.dart';
import 'package:uber/features/signup/data/models/country_model.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm({
    super.key,
    this.countryModel,
    required this.onChanged,
    this.prefixIcon,
    this.isObscure = false,
    this.hint,
    this.validator,
    this.keyboardType,
  });
  final CountryModel? countryModel;
  final Widget? prefixIcon;
  final bool isObscure;
  final void Function(String) onChanged;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
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
      obscureText: widget.isObscure,
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: _textEditingController,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        constraints: BoxConstraints(minHeight: 52),
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
