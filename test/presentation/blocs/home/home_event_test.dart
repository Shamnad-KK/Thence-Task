import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';

class MockHomeEvent extends Mock implements HomeEvent {}

void main() {
  group(
    'Home events',
    () {
      test(
        'Supports value comparisons',
        () {
          final event1 = GetProductsEvent();
          final event2 = GetProductsEvent();
          expect(event1, equals(event2));
        },
      );
      test(
        'Supports value comparisons',
        () {
          final ProductsModel selectedProduct1 = ProductsModel(
            id: 1,
            imageUrl: 'img1',
            name: 'name1',
            rating: 'rating1',
            displaySize: 1,
            availableSize: [1, 2],
            unit: 'unit1',
            price: 'price1',
            priceUnit: 'priceUnit1',
            description: 'description1',
          );
          final ProductsModel selectedProduct2 = ProductsModel(
            id: 2,
            imageUrl: 'img1',
            name: 'name1',
            rating: 'rating1',
            displaySize: 1,
            availableSize: [1, 2],
            unit: 'unit1',
            price: 'price1',
            priceUnit: 'priceUnit1',
            description: 'description1',
          );

          final event1 = SelectAProductEvent(product: selectedProduct1);
          final event2 = SelectAProductEvent(product: selectedProduct2);
          expect(event1, isNot(event2));
        },
      );
    },
  );
}
