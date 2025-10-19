class UserModel {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String mobile;
  final String photo;

  String get fullname{
    return '$firstname $lastname';
  }

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {//factory = j nije k nije constructor banaite pare
    return UserModel(
      id: jsonData['_id'],
      email: jsonData['email'],
      firstname: jsonData['firstName'],
      lastname: jsonData['lastName'],
      mobile: jsonData['mobile'],
      photo: jsonData['photo'] ?? '' // dile takbe ar na hoi empty takbe
    );
  }

  Map<String,dynamic>toJson(){
    return {
      '_id' : id,
      'email' : email,
      'firstName' : firstname,
      'lastName' : lastname,
      'mobile' : mobile,
      'photo' : photo,

    };


  }
}
