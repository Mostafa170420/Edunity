import 'package:edunity/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.floatingLabelBehavior,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isobscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword && isobscure,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: widget.suffixIcon ??
                  (widget.isPassword
                      ? IconButton(
                          icon: Image.asset(
                            isobscure ? AppAssets.eye : AppAssets.eye,
                          ),
                          onPressed: () {
                            setState(() {
                              isobscure = !isobscure;
                            });
                          },
                        )
                      : null),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(11),
                    child: widget.prefixIcon,
                  )
                : null,
          ),
        ));
  }
}
