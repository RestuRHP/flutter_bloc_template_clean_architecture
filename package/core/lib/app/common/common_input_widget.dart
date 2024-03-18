import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/colors.dart';
import 'text_default.dart';

class CommonInputWidget extends StatelessWidget {
  final String? hintText, font, text, errorText, labelText;
  final Widget? prefixIcon, suffixIcon;
  final bool? autoCorrect, autoFocus, readOnly, obscureText;
  final bool? counterText, showCursor, enabled, noPrefixPadding;
  final TextInputType? keyboardType;
  final Function()? onPressed, onEditingComplete;
  final Function(String)? onChanged, onSubmitted;
  final TextEditingController? controller;
  final int? maxLength, maxLines, minLines;
  final double? fontSize, fontSizeHint, borderRadius;
  final FontWeight? fontWeight;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final TextStyle? labelStyle;
  final Color? color, fontColorHint, errorColor;
  final EdgeInsetsGeometry? padding, contentPadding;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final BorderSide? borderSide;

  const CommonInputWidget({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.autoCorrect,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.controller,
    this.autoFocus = false,
    this.maxLength,
    this.readOnly,
    this.onPressed,
    this.counterText,
    this.maxLines,
    this.minLines,
    this.font,
    this.fontSize,
    this.fontWeight,
    this.showCursor,
    this.inputFormatters,
    this.text,
    this.textCapitalization,
    this.onSubmitted,
    this.errorText,
    this.enabled,
    this.textAlignVertical,
    this.fontSizeHint,
    this.labelText,
    this.labelStyle,
    this.color,
    this.borderRadius,
    this.padding,
    this.contentPadding,
    this.obscureText,
    this.validator,
    this.textInputAction,
    this.borderSide,
    this.fontColorHint,
    this.noPrefixPadding,
    this.errorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            enabled: enabled,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            obscureText: obscureText ?? false,
            textAlignVertical: textAlignVertical,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            inputFormatters: inputFormatters,
            showCursor: showCursor,
            maxLines: maxLines ?? 1,
            minLines: minLines,
            onTap: onPressed,
            readOnly: readOnly ?? false,
            enableInteractiveSelection: readOnly,
            maxLength: maxLength,
            controller: controller,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onSubmitted,
            autofocus: autoFocus ?? false,
            autocorrect: autoCorrect ?? false,
            enableSuggestions: false,
            keyboardType: keyboardType,
            textInputAction: textInputAction ?? TextInputAction.next,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w400,
              color: AppColors.black,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: color ?? Colors.white,
              counterText: counterText == null ? "" : null,
              labelText: labelText,
              labelStyle: labelStyle,
              prefixIcon: Padding(
                padding: noPrefixPadding == true
                    ? EdgeInsets.zero
                    : prefixIcon == null
                    ? const EdgeInsets.only(left: 15)
                    : const EdgeInsets.symmetric(horizontal: 15),
                child: prefixIcon,
              ),
              suffixIcon: Padding(
                padding: suffixIcon == null
                    ? const EdgeInsets.only(right: 15)
                    : const EdgeInsets.symmetric(horizontal: 15),
                child: suffixIcon,
              ),
              hintText: hintText,
              errorStyle: const TextStyle(height: 0.1, fontSize: 0),
              contentPadding: contentPadding ?? const EdgeInsets.all(15),
              hintStyle: TextStyle(
                fontSize: fontSizeHint ?? 14,
                fontWeight: FontWeight.w600,
                color: fontColorHint ?? Colors.black45,
              ),
              prefixIconConstraints:
              const BoxConstraints(minWidth: 1, maxHeight: 22),
              suffixIconConstraints:
              const BoxConstraints(minWidth: 1, maxHeight: 22),
              border: _buildBorder(),
              enabledBorder: _buildBorder(),
              disabledBorder: _buildBorder(),
              focusedBorder: _buildBorder(),
            ),
          ),
          if (errorText?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: TextDefault(
                errorText!,
                fontSize: 12,
                textColor: errorColor ?? Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: borderSide ?? const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
    );
  }
}