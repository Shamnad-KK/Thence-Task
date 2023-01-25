class ProductsModel {
  ProductsModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.displaySize,
    required this.availableSize,
    required this.unit,
    required this.price,
    required this.priceUnit,
    required this.description,
    // required this.isFavorite,
  });
  // bool isFavorite;
  final int? id;
  final String? imageUrl;
  final String? name;
  final dynamic rating;
  final int? displaySize;
  final List<int?>? availableSize;
  final String? unit;
  final String? price;
  final String? priceUnit;
  final String? description;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        rating: json["rating"],
        displaySize: json["display_size"],
        availableSize: json["available_size"] == null
            ? []
            : json["available_size"] == null
                ? []
                : List<int?>.from(json["available_size"]!.map((x) => x)),
        unit: json["unit"],
        price: json["price"],
        priceUnit: json["price_unit"],
        description: json["description"],
        // isFavorite: json["isFavorite"] ?? false,
      );

  // ProductsModel toggleFavorites() {
  //   return ProductsModel(
  //     id: id,
  //     imageUrl: imageUrl,
  //     name: name,
  //     rating: rating,
  //     displaySize: displaySize,
  //     availableSize: availableSize,
  //     unit: unit,
  //     price: price,
  //     priceUnit: priceUnit,
  //     description: description,
  //     isFavorite: !isFavorite,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image_url': imageUrl,
      'name': name,
      'rating': rating,
      'display_size': displaySize,
      'available_size': availableSize,
      'unit': unit,
      'price': price,
      'price_unit': priceUnit,
      'description': description,
      // 'isFavorite': isFavorite,
    };
  }
}
