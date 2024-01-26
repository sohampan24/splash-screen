// ignore_for_file: empty_constructor_bodies, camel_case_types, file_names

class userModel {
  String? uid;
  String? name;
  String? phoneNo;
  String? email;
  String? password;

  userModel({this.uid, this.name, this.phoneNo, this.email, this.password});

  //data from server
  factory userModel.fromMap(map) {
    return userModel(
      uid: map['uid'],
      name: map['name'],
      phoneNo: map['phoneNo'],
      email: map['email'],
      password: map['password'],
    );
  }

  //sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNo': phoneNo,
      'email': email,
      'password': password,
    };
  }
}