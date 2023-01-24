import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/presentation/blocs/search/search_bloc.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_product_widget.dart';
import 'package:thence_task/presentation/widgets/headline_widget.dart';
import 'package:thence_task/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchBloc searchBloc;
  @override
  void initState() {
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.add(SearchInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const HeadlineWidget(text: 'Search'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  searchBloc.add(SearchForProductsEvent(query: value));
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Search here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
            AppSpacing.sboxH10,
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return state.foundProducts.isEmpty
                      ? const Center(
                          child: Text('No products'),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            final product = state.foundProducts[index];
                            return HomeProductWidget(product: product);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: size.height * 0.05);
                          },
                          itemCount: state.foundProducts.length);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
