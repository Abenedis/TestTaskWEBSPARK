import 'package:flutter/material.dart';

class UrlInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const UrlInputField({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12, right: 12),
          child: Icon(Icons.compare_arrows),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.go,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'https://flutter.webspark.dev/flutter/api',
              errorText: errorText,
            ),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    );
  }
}
