import 'package:flutter/material.dart';

class AppDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final Function(T?) onChanged;

  const AppDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  AppDropdownState<T> createState() => AppDropdownState<T>();
}

class AppDropdownState<T> extends State<AppDropdown<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      padding: EdgeInsets.zero,
      isExpanded: true,
      isDense: false,
      focusColor: Colors.transparent,
      elevation: 0,
      underline: Container(),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      value: _selectedValue,
      items: widget.items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          onTap: () {},
          child: Text(
            value.toString(),
            maxLines: 1,
          ), // You can customize this as needed
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() {
          _selectedValue = newValue;
          widget.onChanged(newValue);
        });
      },
    );
  }
}
