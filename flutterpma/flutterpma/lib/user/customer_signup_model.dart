class PostCustomer {
  final String fullname;
  final String email;
  final String role;
  final String address;
  final String diseaseid;
  final String password;

  PostCustomer({
    this.fullname,
    this.email,
    this.role,
    this.address,
    this.diseaseid,
    this.password,
  });

  factory PostCustomer.fromJson(Map<String, dynamic> json) {
    return PostCustomer(
      fullname: json['full_name'],
      email: json['email'],
      role: json['role'],
      address: json['address'],
      diseaseid: json['disease_id'],
      password: json['password'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['full_name'] = fullname;
    map["email"] = email;
    map['role'] = role;
    map['address'] = address;
    map['disease_id'] = diseaseid;
    map["password"] = password;
    // map["body"] = body;

    return map;
  }
}