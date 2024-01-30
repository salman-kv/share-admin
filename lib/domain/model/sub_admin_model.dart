class SubAdminModel {
  final String name;
  final String password;
  final int phone;
  final String imagePath;
  final String email;
  final String? userId;

  SubAdminModel( {required this.userId,required this.email, required this.name, required this.password, required this.phone, required this.imagePath});

  Map<String , dynamic >  fromMap(){
    return {
      "email":email,
      "name" : name,
      "password":password,
      "phone":phone,
      "image":imagePath
    };
  }

}
