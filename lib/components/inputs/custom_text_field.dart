/// A customizable text field widget with support for validation, password masking, and custom icons.
import 'package:edunity/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  /// Creates a [CustomTextField].
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
    this.maxLines = 1,
    this.label,
    this.onChanged,
  });

  /// The controller for the text field.
  final TextEditingController controller;

  /// The hint text to display when the text field is empty.
  final String? hintText;

  /// The validator function to use for validating the text field's input.
  final String? Function(String?)? validator;

  /// Whether the text field is for a password.
  final bool isPassword;

  /// An optional icon to display at the end of the text field.
  final Widget? suffixIcon;

  /// An optional icon to display at the beginning of the text field.
  final Widget? prefixIcon;

  final Widget? label;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// The callback function to execute when the text field is tapped.
  final Function()? onTap;

  /// The type of keyboard to use for the text field.
  final TextInputType? keyboardType;

  /// The floating label behavior for the text field's label.
  final FloatingLabelBehavior? floatingLabelBehavior;

  final int? maxLines;

  final Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  /// Whether the password text should be obscured.
  bool isobscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TextFormField(
          onChanged: widget.onChanged,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword && isobscure,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          textCapitalization: TextCapitalization.sentences,
          maxLines: widget.isPassword ? 1 : (widget.maxLines ?? 1),
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            label: widget.label,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            suffixIcon: widget.suffixIcon ??
                (widget.isPassword
                    ? IconButton(
                        icon: Image.asset(
                          isobscure ? AppAssets.eye : AppAssets.eye,
                        ),
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            isobscure = !isobscure;
                          });
                        },
                      )
                    : null),
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
