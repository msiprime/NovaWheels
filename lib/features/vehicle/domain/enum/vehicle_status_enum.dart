enum VehicleStatus {
  available('available'),
  booked('booked'),
  rented('rented'),
  sold('sold');

  final String value;

  const VehicleStatus(this.value);

  @override
  String toString() => value;
}

//status = ANY (ARRAY['available'::text, 'sold'::text, 'rented'::text, 'booked'::text])
