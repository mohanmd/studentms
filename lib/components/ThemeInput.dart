import 'package:flutter/material.dart';

class ThemeInput extends StatefulWidget {
  const ThemeInput(
      {Key? key,
      required this.inputController,
      required this.inputLabel,
      this.errorMsg,
      this.isPassword = false,
      this.prefixIcon,
      this.minLength,
      this.type,
      this.validator,
      this.maxLength})
      : super(key: key);

  final TextEditingController inputController;

  final String inputLabel;
  final String? errorMsg;
  final bool isPassword;
  final IconData? prefixIcon;
  final int? minLength;
  final int? maxLength;
  final String? type;
  final validator;
  @override
  State<ThemeInput> createState() => _ThemeInputState();
}

class _ThemeInputState extends State<ThemeInput> {
  bool obscureText = true;
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.inputController,
      keyboardType:
          widget.type == 'mobile' ? TextInputType.phone : TextInputType.text,
      obscureText: obscureText && widget.isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorMsg ?? 'Please enter a valid ${widget.inputLabel}';
        }
        if (widget.type == 'email' && !emailRegex.hasMatch(value)) {
          return "Enter Valid Email";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: widget.inputLabel,
        filled: false,
        fillColor: Colors.deepPurple.shade100,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red.shade300)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red.shade100)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade800)),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: Colors.grey.shade400,
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  color: Colors.grey.shade400,
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
