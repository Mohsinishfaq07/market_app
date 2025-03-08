import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final Function(String?) onChanged;
  final Color borderColor;
  final double borderRadius;
  final double width;
  final double height;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.borderColor = Colors.grey,
    this.borderRadius = 10.0,
    this.width = double.infinity,
    this.height = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down, color: borderColor),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
