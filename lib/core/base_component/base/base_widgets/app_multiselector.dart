import 'package:flutter/material.dart';

class AppMultiSelector extends StatefulWidget {
  final List<String> items;
  final List<String>? selectedItems;
  final Function(List<String>?) onChanged;

  const AppMultiSelector(
      {super.key,
      required this.items,
      required this.onChanged,
      this.selectedItems = const []});

  @override
  AppMultiSelectorState createState() => AppMultiSelectorState();
}

class AppMultiSelectorState extends State<AppMultiSelector> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isSelected = widget.selectedItems?.contains(item);

        return ListTile(
          title: Text(item),
          leading: Checkbox(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  if (value) {
                    widget.selectedItems?.add(item);
                    widget.onChanged(widget.selectedItems);
                  } else {
                    widget.selectedItems?.remove(item);
                    widget.onChanged(widget.selectedItems);
                  }
                }
              });
            },
          ),
        );
      },
    );
  }
}
