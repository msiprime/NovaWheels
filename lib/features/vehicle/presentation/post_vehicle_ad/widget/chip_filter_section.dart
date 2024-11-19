import 'package:flutter/material.dart';

class ChipFilterSection<T extends Enum> extends StatefulWidget {
  final String chipLabel;
  final List<T> values;
  final void Function(T)? onSelected;

  const ChipFilterSection({
    super.key,
    required this.chipLabel,
    required this.values,
    this.onSelected,
  });

  @override
  State<ChipFilterSection<T>> createState() => _ChipFilterSectionState<T>();
}

class _ChipFilterSectionState<T extends Enum>
    extends State<ChipFilterSection<T>> {
  T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.chipLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 3),
        Wrap(
          spacing: 8.0,
          children: widget.values.map((T value) {
            return ChoiceChip(
              selected: selectedValue == value,
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              visualDensity: VisualDensity.compact,
              label: Text(value.name.capitalizeFirst()),
              onSelected: (selected) {
                setState(() {
                  selectedValue = selected ? value : null;
                });
                if (selected && widget.onSelected != null) {
                  widget.onSelected!(value);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

extension StringExtensions on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
