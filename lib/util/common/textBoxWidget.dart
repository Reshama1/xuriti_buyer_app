import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef validatorFunction = String? Function(String? value)?;

class TextBoxField extends StatelessWidget {
  final Function()? onTap;
  final Function(String value)? onChanged;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? textStyle;
  final validatorFunction? validator;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffix;
  final TextStyle? errorStyle;
  final Widget? prefix;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final Color? fillColor;
  final String? hintText;
  final Iterable<String>? autofillHints;
  final TextStyle? hintStyle;
  final bool? enabled;
  final bool? filled;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Function(String value)? onSubmitted;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final int? maxLength;
  final String? counterText;
  final FocusNode? focusNode;
  final int? errorMaxLines;
  const TextBoxField(
      {Key? key,
      this.onTap,
      this.autoValidateMode,
      this.textStyle,
      this.validator,
      this.controller,
      this.obscureText,
      this.suffix,
      this.errorStyle,
      this.prefix,
      this.contentPadding,
      this.border,
      this.fillColor,
      this.hintText,
      this.autofillHints,
      this.hintStyle,
      this.enabled,
      this.onChanged,
      this.filled,
      this.focusedBorder,
      this.enabledBorder,
      this.onSubmitted,
      this.keyboardType,
      this.inputFormatters,
      this.textCapitalization,
      this.maxLength,
      this.counterText,
      this.focusNode,
      this.errorMaxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      maxLength: maxLength,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      inputFormatters: inputFormatters,
      autovalidateMode: autoValidateMode,
      validator: validator,
      controller: controller,
      style: textStyle,
      autofillHints: autofillHints,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorMaxLines: errorMaxLines,
        suffix: suffix,
        counterText: counterText,
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        errorStyle: errorStyle,
        prefix: prefix,
        contentPadding: contentPadding,
        border: border,
        fillColor: fillColor,
        filled: filled,
        hintStyle: hintStyle,
        enabled: enabled ?? true,
        hintText: (hintText ?? "").tr(),
      ),
    );
  }
}
