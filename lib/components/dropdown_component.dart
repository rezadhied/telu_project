import 'package:flutter/material.dart';
import 'package:telu_project/colors.dart';


class DropdownComponent extends StatelessWidget {
  final String hintText;
  final List<String> subMenu;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;

  const DropdownComponent({
    Key? key,
    required this.hintText,
    required this.subMenu,
    this.selectedItem,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedItem,
          hint: Text(hintText),
          items: subMenu.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontWeight: FontWeight.w400)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

