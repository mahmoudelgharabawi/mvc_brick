import 'package:tecfy_basic_package/tecfy_basic_package.dart';

class Customer {
  String? firstName;
  String? lastName;
  String? profilePhoto;
  String? email;
  String? mobileNumber;

  String? type;
  String? status;
  Customer();

  Customer.fromJson(Map<String, dynamic> data) {
    firstName = data["firstName"];
    lastName = data["lastName"];
    profilePhoto = data["profilePhoto"];
    email = data["email"];
    mobileNumber = data["mobileNumber"];

    type = data["type"];
    status = data["status"];
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "profilePhoto": profilePhoto,
      "email": email,
      "mobileNumber": mobileNumber,
      "type": type,
      "status": status,
    };
  }
}
