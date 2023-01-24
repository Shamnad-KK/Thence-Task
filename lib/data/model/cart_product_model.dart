class CartProductModel {
  int id;
  String image;
  int count;
  String name;
  double price;
  String priceUnit;
  CartProductModel({
    required this.id,
    required this.image,
    this.count = 1,
    required this.name,
    required this.price,
    required this.priceUnit,
  });

  CartProductModel incrementCount() {
    final int newCount = count + 1;

    return CartProductModel(
      id: id,
      image: image,
      name: name,
      price: price,
      priceUnit: priceUnit,
      count: newCount,
    );
  }

  double get newPrice {
    final double newPrice = count * price;
    return newPrice;
  }

  CartProductModel decrementCount() {
    final int newCount = count - 1;

    return CartProductModel(
      id: id,
      image: image,
      name: name,
      price: price,
      priceUnit: priceUnit,
      count: newCount,
    );
  }
}
