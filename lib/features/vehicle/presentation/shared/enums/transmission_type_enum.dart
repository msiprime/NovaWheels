// Enum for vehicle transmission types (matches 'transmission' column in the table)
enum VehicleTransmissionType {
  manual('manual'),
  automatic('automatic'),
  semiAutomatic('semi-automatic'),
  other('other');

  final String displayName;

  const VehicleTransmissionType(this.displayName);
}
