import 'package:flutter/material.dart';
import 'package:telu_project/colors.dart';

class TextFieldComponent extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final bool isPassword;

  const TextFieldComponent({super.key, required this.hintText, this.onChanged, this.textEditingController, this.isPassword = false});

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

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
      child: Center(
        child: TextField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none, // Remove default border
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 12.0),
              suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,  // Add content padding
            ),
            obscureText: _obscureText,
            maxLines: 1, // Set maxLines to 1 to limit input to a single line
            onChanged: widget.onChanged),
      ),
    );
  }
}
