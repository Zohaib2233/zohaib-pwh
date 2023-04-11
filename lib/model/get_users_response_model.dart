/// id : 1
/// first_name : "Mal"
/// last_name : "Vanner"
/// email : "mvanner0@washingtonpost.com"
/// gender : "Male"
/// ip_address : "67.128.112.91"
///



class UserObject {
  UserObject({
    num? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? ipAddress,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _gender = gender;
    _ipAddress = ipAddress;
  }

  UserObject.fromJson(dynamic json) {
    // _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _gender = json['gender'];
    _ipAddress = json['ip_address'];
  }

  num? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _gender;
  String? _ipAddress;

  UserObject copyWith({
    num? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? ipAddress,
  }) =>
      UserObject(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        gender: gender ?? _gender,
        ipAddress: ipAddress ?? _ipAddress,
      );

  num? get id => _id;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get email => _email;

  String? get gender => _gender;

  String? get ipAddress => _ipAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['gender'] = _gender;
    map['ip_address'] = _ipAddress;
    return map;
  }
}
