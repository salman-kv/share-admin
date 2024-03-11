import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';

class SubAdminModel {
  final String name;
  final String password;
  final int phone;
  final String imagePath;
  final String email;
  String? userId;
  List<String>? hotels;

  SubAdminModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.password,
      required this.phone,
      required this.imagePath});

  Map<String, dynamic> toMaps() {
    return {
      "email": email,
      "name": name,
      "password": password,
      "phone": phone,
      "image": imagePath
    };
  }

  static SubAdminModel fromMap(Map<String, dynamic> map,String userid) {
    return SubAdminModel(
        userId: userid,
        email: map["email"],
        name: map["name"],
        password: map["password"],
        phone: map["phone"],
        imagePath: map["image"]);
  }
}
