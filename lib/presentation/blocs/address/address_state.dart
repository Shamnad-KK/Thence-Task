part of 'address_bloc.dart';

class AddressState extends Equatable {
  final List<AddressModel> addressList;
  const AddressState({
    required this.addressList,
  });

  AddressState copyWith({
    List<AddressModel>? addressList,
  }) {
    return AddressState(
      addressList: addressList ?? this.addressList,
    );
  }

  factory AddressState.initial() {
    return const AddressState(
      addressList: [],
    );
  }

  @override
  List<Object> get props => [addressList];
}
