part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {}

class AddAddressEvent extends AddressEvent {
  final AddressModel address;
  AddAddressEvent({
    required this.address,
  });
  @override
  List<Object?> get props => [address];
}
