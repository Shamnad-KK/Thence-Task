import 'package:flutter_test/flutter_test.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';

void main() {
  group(
    'Home State test group',
    () {
      test(
        'Initial has correct status',
        () {
          expect(
            HomeState.initial(),
            equals(HomeState.initial()),
          );
        },
      );

      // test(
      //   'returns 0'
      //   'when ',
      //   () {
      //     expect(
      //       HomeState.initial().copywith(status: HomeStatus.loading),
      //       isZero,
      //     );
      //   },
      // );
    },
  );
}
