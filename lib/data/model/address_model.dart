class AddressModel {
  final String place;
  final String landMark;
  final String pincode;
  AddressModel({
    required this.place,
    required this.landMark,
    required this.pincode,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'place': place,
      'landMark': landMark,
      'pincode': pincode,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      place: map['place'],
      landMark: map['landMark'],
      pincode: map['pincode'],
    );
  }
}
