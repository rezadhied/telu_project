import 'package:flutter/material.dart';
import 'package:telu_project/colors.dart';

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;

  const TextFieldComponent({super.key, required this.hintText, this.onChanged, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.black
                .withOpacity(0.2)), // Add black border decoration
        borderRadius: BorderRadius.circular(15), // Add border radius
      ),
      child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none, // Remove default border
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12), // Add content padding
          ),
          maxLines: 1, // Set maxLines to 1 to limit input to a single line
          onChanged: onChanged),
    );
  }
}
