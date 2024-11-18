// Enum for vehicle status (matches 'status' column in the table)
enum VehicleStatus {
  available('available'),
  sold('sold'),
  rented('rented'),
  booked('booked');

  final String displayName;

  const VehicleStatus(this.displayName);
}
