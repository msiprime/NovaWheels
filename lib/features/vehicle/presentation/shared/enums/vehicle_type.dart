enum VehicleType {
  sell(true),
  rent(true);

  final bool isSelected;

  const VehicleType(this.isSelected);
}
