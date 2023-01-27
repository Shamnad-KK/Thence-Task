import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/data/model/address_model.dart';
import 'package:thence_task/presentation/blocs/address/address_bloc.dart';
import 'package:thence_task/presentation/widgets/custom_text_field.dart';

class AddressAlertDialogue extends StatelessWidget {
  const AddressAlertDialogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final TextEditingController placeController = TextEditingController();
    final TextEditingController landMarkController = TextEditingController();
    final TextEditingController pinCodeController = TextEditingController();

    return Dialog(
      child: Container(
        height: size.height * 0.33,
        width: size.width * 0.6,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomTextField(
              controller: placeController,
              hint: 'place',
            ),
            AppSpacing.sboxH10,
            CustomTextField(
              controller: landMarkController,
              hint: 'landmark',
            ),
            AppSpacing.sboxH10,
            CustomTextField(
              controller: pinCodeController,
              hint: 'pincode',
            ),
            AppSpacing.sboxH10,
            BlocListener<AddressBloc, AddressState>(
              listener: (context, state) {
                Navigator.of(context).pop();
              },
              child: ElevatedButton(
                onPressed: () {
                  final AddressModel address = AddressModel(
                    place: placeController.text,
                    landMark: landMarkController.text,
                    pincode: pinCodeController.text,
                  );
                  BlocProvider.of<AddressBloc>(context).add(
                    AddAddressEvent(address: address),
                  );
                },
                child: const Text('Add'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
