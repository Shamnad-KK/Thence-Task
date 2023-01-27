import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/presentation/blocs/address/address_bloc.dart';
import 'package:thence_task/presentation/screens/address/widgets/address_alert_dialogue_widget.dart';
import 'package:thence_task/theme/app_colors.dart';

class Addressscreen extends StatelessWidget {
  const Addressscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  if (state.addressList.isEmpty) {
                    return const Center(
                      child: Text('No address found'),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final address = state.addressList[index];
                      return Container(
                        height: size.height * 0.1,
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.addressContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(address.place),
                          subtitle: Text(address.landMark),
                          trailing: Text(address.pincode),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: size.height * 0.01);
                    },
                    itemCount: state.addressList.length,
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                _showAddressAlertBoxx(context);
              },
              child: Container(
                height: size.height * 0.07,
                width: size.width,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.rating,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text('Add new address'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressAlertBoxx(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const AddressAlertDialogue();
      },
    );
  }
}
