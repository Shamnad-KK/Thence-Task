import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/app_exceptions.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(error.errorMessage),
        ),
        IconButton(
            onPressed: () {
              homeBloc.add(GetProductsEvent());
            },
            icon: const Icon(Icons.refresh))
      ],
    );
  }
}
