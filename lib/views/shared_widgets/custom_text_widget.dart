import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';
import '../../constants.dart';

class DefaultFormFlield extends StatefulWidget {
  final TextEditingController controller;
  final Key? formKey;
  final String hintText;
  final int? maxLenth;
  final TextInputType inputType;
  final int? maxLine;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  const DefaultFormFlield(
      {Key? key,
      this.formKey,
      required this.controller,
      required this.hintText,
      this.onChanged,
      this.maxLenth,
      required this.validator,
      this.maxLine = 1,
      this.inputType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  State<DefaultFormFlield> createState() => _DefaultFormFlieldState();
}

class _DefaultFormFlieldState extends State<DefaultFormFlield> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formKey,
      controller: widget.controller,
      maxLength: widget.maxLenth,
      maxLines: widget.maxLine,
      keyboardType: widget.inputType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? !isVisible : false,
      style: const TextStyle(
          color: CResources.blueGrey, fontFamily: Strings.notosansFontFamilly),
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                  print('pressed');
                },
                child:
                    Icon(isVisible ? Icons.visibility : Icons.visibility_off))
            : null,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CResources.blueGrey)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CResources.blueGrey)),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: CResources.grey.withOpacity(0.9)),
      ),
    );
  }
}
