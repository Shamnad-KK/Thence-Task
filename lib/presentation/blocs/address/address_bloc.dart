import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thence_task/data/model/address_model.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressState.initial()) {
    on<AddAddressEvent>(_addAddress);
  }

  void _addAddress(
    AddAddressEvent event,
    Emitter<AddressState> emit,
  ) {
    List<AddressModel> addressList = state.addressList.toList();
    addressList.add(event.address);
    emit(
      state.copyWith(addressList: addressList),
    );
  }
}
