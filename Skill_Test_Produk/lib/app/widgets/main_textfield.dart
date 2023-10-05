import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TfieldType { general, search }

class MainTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool obscrureText, readOnly;
  final IconData? prefixIcon;
  final TextInputType? type;
  final TfieldType tfieldType;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final int maxLines;
  final Widget? suffixIcon;
  final String? suffixText;
  final TextInputAction? textInputAction;
  final String? errorText;

  const MainTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.obscrureText = false,
    this.prefixIcon,
    this.readOnly = false,
    this.type,
    this.onTap,
    this.maxLines = 1,
    this.onChanged,
    this.onEditingComplete,
    this.suffixIcon,
    this.textInputAction,
    this.suffixText,
    this.errorText,
    this.hintText,
    this.tfieldType = TfieldType.general,
  });

  @override
  Widget build(BuildContext context) {
    return tfieldType == TfieldType.search
        ? TextField(
            textInputAction:
                maxLines > 1 ? null : textInputAction ?? TextInputAction.next,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            controller: controller,
            enableSuggestions: true,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                child: StatefulBuilder(builder: (context, setState) {
                  return TextField(
                    textInputAction: maxLines > 1
                        ? null
                        : textInputAction ?? TextInputAction.next,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: controller,
                    onChanged: onChanged,
                    onEditingComplete: onEditingComplete,
                    obscureText: obscrureText,
                    obscuringCharacter: '*',
                    keyboardType: type,
                    readOnly: readOnly,
                    maxLines: maxLines,
                    minLines: 1,
                    onTap: onTap,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      labelText: labelText,
                      hintText: hintText,
                      border: InputBorder.none,
                      suffixIcon: suffixIcon,
                      suffixText: suffixText ?? '',
                    ),
                  );
                }),
              ),
            ),
          );
  }
}
