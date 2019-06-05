class PostExpert {
  final String fullname;
  final String email;

  final String role;
  final String address;
  final String joblocation;
  final String specialization;
  final String diseaseid;
  final String password;



  


  PostExpert({
    this.fullname,
    this.email,

    this.role,
    this.address,
    this.joblocation,
    this.specialization,
    this.diseaseid,
    this.password,



  });


  factory PostExpert.fromJson(Map<String, dynamic> json) {
    return PostExpert(
      fullname: json['full_name'],
      email: json['email'],
      role: json['role'],
      address: json['address'],
      joblocation: json['job_location'],
      specialization: json['specialization_area'],
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
    map['job_location'] = joblocation;
    map['specialization_area'] = specialization;
    map['disease_id'] = diseaseid;
    map["password"] = password;


    // map["body"] = body;

    return map;
  }
}