// Enum for vehicle rental status (matches 'rental_status' column in the table)
enum VehicleRentalStatus {
  booked('booked'),
  rented('rented'),
  available('available');

  final String displayName;

  const VehicleRentalStatus(this.displayName);
}
