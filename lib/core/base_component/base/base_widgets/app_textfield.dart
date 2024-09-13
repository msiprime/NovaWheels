import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';

class AppTextField extends HookWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.borderRadius = 12,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.prefix,
    this.suffix,
    this.validator,
    this.borderWidth,
    this.borderColor,
    this.isFiled,
    required this.onChanged,
    this.isEnabled,
  });

  final TextEditingController controller;
  final bool readOnly;

  final String labelText;
  final double borderRadius;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final double? borderWidth;
  final FormFieldValidator<String>? validator;
  final Function(String?) onChanged;
  final Color? borderColor;
  final bool? isFiled;
  final String? hintText;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    final obscurePassword = useState(true);

    return TextFormField(
      readOnly: readOnly,
      enabled: isEnabled,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
        alignLabelWithHint: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        label: FittedBox(
          child: Text(
            labelText,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.black54),
          ),
        ),
        floatingLabelBehavior: hintText != null
            ? FloatingLabelBehavior.never
            : FloatingLabelBehavior.auto,
        filled: isFiled ?? false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: borderWidth ?? 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.textFieldBorderColor,
            width: borderWidth ?? 0.50,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: AppColors.textFieldBorderColor,
            width: borderWidth ?? 1.2,
          ),
        ),
        suffixIcon: obscureText
            ? GestureDetector(
                onTap: () {
                  obscurePassword.value = !obscurePassword.value;
                },
                child: obscurePassword.value
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : suffix,
        prefixIcon: prefix,
      ),
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
      obscureText: obscureText && obscurePassword.value,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
