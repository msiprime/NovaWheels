import 'package:flutter/material.dart';

class VehicleAvailabilityWidget extends StatefulWidget {
  const VehicleAvailabilityWidget({super.key});

  @override
  VehicleAvailabilityWidgetState createState() =>
      VehicleAvailabilityWidgetState();
}

class VehicleAvailabilityWidgetState extends State<VehicleAvailabilityWidget> {
  bool isForRent = false; // Default value
  bool isForSale = false; // Default value

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rent Toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Available for Rent:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Switch(
              value: isForRent,
              onChanged: (bool value) {
                setState(() {
                  isForRent = value;
                });
              },
            ),
          ],
        ),
        // Sale Toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Available for Sale:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Switch(
              value: isForSale,
              onChanged: (bool value) {
                setState(() {
                  isForSale = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
