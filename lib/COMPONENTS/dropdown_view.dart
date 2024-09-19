import 'package:flutter/material.dart';

class DropdownView extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final Color textColor;
  final Color backgroundColor;
  final String? defaultValue; // Make defaultValue nullable

  const DropdownView({
    super.key,
    required this.items,
    required this.onChanged,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.black,
    this.defaultValue, // Accept defaultValue in constructor
  });

  @override
  _DropdownViewState createState() => _DropdownViewState();
}

class _DropdownViewState extends State<DropdownView> {
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedItem with defaultValue if provided and exists in items, otherwise fallback to the first item if available
    if (widget.defaultValue != null &&
        widget.items.contains(widget.defaultValue)) {
      _selectedItem = widget.defaultValue!;
    } else {
      _selectedItem = widget.items.isNotEmpty ? widget.items[0] : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: widget.backgroundColor,
      style: TextStyle(
        color: widget.textColor,
        fontSize: 20,
      ),
      value: _selectedItem.isNotEmpty
          ? _selectedItem
          : null, // Avoid passing empty string if no items
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedItem = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        }
      },
    );
  }
}
