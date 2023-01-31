class UserModel {
  final String id;
  final String userName;
  UserModel({
    required this.id,
    required this.userName,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      userName: map['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
    };
  }
}
