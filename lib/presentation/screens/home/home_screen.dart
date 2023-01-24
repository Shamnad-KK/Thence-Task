import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_appbar_widget.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_error_widget.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_loaded_widget.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_shimmers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height * 0.14),
        child: const HomeAppBarWidget(),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const HomeShimmers();
          }
          if (state.status == Status.loaded) {
            return const HomeLoadedWidget();
          }
          return const HomeErrorWidget();
        },
      ),
    );
  }
}
