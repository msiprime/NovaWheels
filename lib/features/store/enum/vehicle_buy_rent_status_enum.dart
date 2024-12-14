enum VehicleBuyRentStatusEnum {
  pending('pending'),
  approved('approved'),
  rejected('rejected');

  const VehicleBuyRentStatusEnum(this.value);

  final String value;
}
