import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool disabled;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.disabled = false,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dynamicBackgroundColor = backgroundColor ??
        (disabled ? Colors.grey : Theme.of(context).primaryColor);
    Color dynamicTextColor = textColor ?? Colors.white;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: dynamicBackgroundColor,
          foregroundColor: dynamicTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: onPressed,
        child: Container(child: Text(text)),
      ),
    );
  }
}
