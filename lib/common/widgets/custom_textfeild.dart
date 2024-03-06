import 'package:flutter/material.dart';

class CustomTextfeild extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

   const CustomTextfeild({super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        labelText: labelText,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
       if(value==null || value.isEmpty){
         return 'Please enter a valid $labelText';
       }
        return null;
      },
    );
  }
}
