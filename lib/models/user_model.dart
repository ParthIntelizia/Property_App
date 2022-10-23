class UserModel{

  final String name;
  final String flag;
  final String code;
  final String dial_code;

  UserModel(this.name, this.flag, this.code, this.dial_code);

  factory UserModel.fromJson(dynamic json) {

    return UserModel(
      json['name'] as String,
      json['flag'] as String,
      json['code'] as String,
      json['dial_code'] as String,
    );
  }
}


