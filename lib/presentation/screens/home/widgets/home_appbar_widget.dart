import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';
import 'package:thence_task/presentation/blocs/search/search_bloc.dart';
import 'package:thence_task/presentation/screens/search/search_screen.dart';
import 'package:thence_task/presentation/widgets/headline_widget.dart';
import 'package:thence_task/theme/app_textstyle.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03, vertical: size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All plants',
                style: AppTextStyle.appbarTitle,
              ),
              IconButton(
                onPressed: () {
                  if (homeBloc.state.status == HomeStatus.loaded) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            SearchBloc(homeBloc: context.read<HomeBloc>()),
                        child: const SearchScreen(),
                      ),
                    ));
                  }
                },
                icon: const Icon(Icons.search, size: 30),
              ),
            ],
          ),
          const HeadlineWidget(text: 'Houseplants'),
        ],
      ),
    );
  }
}
