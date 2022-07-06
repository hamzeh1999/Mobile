class UserModel {
  String user_id;
  String user_name;
  String email;
  String password;
  int birth;
  UserModel(this.user_id, this.user_name, this.email, this.password,this.birth);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'user_name': user_name,
      'email': email,
      'password': password,
      'birth':birth
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) :birth=map['birth'], user_id = map['user_id'], user_name = map['user_name'],email = map['email'], password = map['password'];


}
