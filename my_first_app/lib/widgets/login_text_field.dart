import 'package:flutter/material.dart';
    


import '../utils/textfield_styles.dart';

class LoginTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool hasAsteriks;

  const LoginTextField({super.key,required this.controller,required this.hintText, this.validator,this.hasAsteriks=false});
    
      @override
      Widget build(BuildContext context) {
        return TextFormField(

          obscureText: hasAsteriks,
          validator: (value) {
          if(validator!=null)
            {
               return validator!(value);
            }

          },
          controller: controller,
          textAlign: TextAlign.center,
          // Set text alignment to center
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red), // Set border color to red
            ),
            hintText: '$hintText',
            hintStyle: ThemeTextStyles.loginTextFieldStyle,
            // Set hint text color to white and italic
            filled: true,
            fillColor: Colors.black,
            // Set background color to black
            contentPadding: EdgeInsets.symmetric(
                vertical: 15.0), // Adjust content padding
          ),
          style: TextStyle(
              color: Colors.white), // Set text color to white
        );
      }
    }
    