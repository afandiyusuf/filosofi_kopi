import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final double marginTop;
  final double marginBottom;
  final String hint;
  final Function validator;
  final List<TextInputFormatter> textInputFormatter;
  final TextInputType keyboardType;
  const CustomTextField(
      {Key key,
      this.controller,
      this.label,
      this.marginTop = 0,
      this.marginBottom = 0,
      this.hint,
      this.validator, this.textInputFormatter, this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child:
                  Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          TextFormField(
            inputFormatters: textInputFormatter,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: '',
              contentPadding:
                  EdgeInsets.only(top: 0, bottom: 0, left: 12, right: 12),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)),
              hintText: hint,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
