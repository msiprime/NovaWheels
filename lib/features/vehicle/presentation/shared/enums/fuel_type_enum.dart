// Enum for vehicle fuel types (matches 'fuel_type' column in the table)
enum VehicleFuelType {
  petrol('petrol'),
  diesel('diesel'),
  electric('electric'),
  hybrid('hybrid'),
  cng('CNG'),
  other('other');

  final String displayName;

  const VehicleFuelType(this.displayName);
}
