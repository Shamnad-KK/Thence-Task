// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  factory CartProductModel.fromJson(Map<String, dynamic> data) {
    return CartProductModel(
        id: data['id'],
        image: data['image_url'],
        name: data['name'],
        price: double.parse(data['price']),
        priceUnit: data['price_unit'],
        count: data['count'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': image,
      'name': name,
      'price': price.toString(),
      'price_unit': priceUnit,
      'count': count,
    };
  }
}
