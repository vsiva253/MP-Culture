class UserModel {
  final String? id;
  final String? roles;
  final String? name;
  final String? email;
  final String? mobile;
  final String? sex;
  final String? state;
  final String? city;
  final String? address;
  final String? dob;
  final String? age;
  final String? username;
  final String? password;
  final String? cpassword;
  final String? companyname;
  final String? companyownername;
  final String? companyaddress;
  final String? logo;
  final String? website;
  final String? google;
  final String? facebook;
  final String? twitter;
  final String? linkedin;
  final String? instagram;
  final String? profileimage;
  final String? date;
  final String? smsEnable;
  final String? emailEnable;
  final String? createdAt;
  final String? updatedAt;
  final String? status;

  UserModel({
    this.id,
    this.roles,
    this.name,
    this.email,
    this.mobile,
    this.sex,
    this.state,
    this.city,
    this.address,
    this.dob,
    this.age,
    this.username,
    this.password,
    this.cpassword,
    this.companyname,
    this.companyownername,
    this.companyaddress,
    this.logo,
    this.website,
    this.google,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
    this.profileimage,
    this.date,
    this.smsEnable,
    this.emailEnable,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roles': roles,
      'name': name,
      'email': email,
      'mobile': mobile,
      'sex': sex,
      'state': state,
      'city': city,
      'address': address,
      'dob': dob,
      'age': age,
      'username': username,
      'password': password,
      'cpassword': cpassword,
      'companyname': companyname,
      'companyownername': companyownername,
      'companyaddress': companyaddress,
      'logo': logo,
      'website': website,
      'google': google,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'profileimage': profileimage,
      'date': date,
      'sms_enable': smsEnable,
      'email_enable': emailEnable,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      roles: json['roles'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      sex: json['sex'],
      state: json['state'],
      city: json['city'],
      address: json['address'],
      dob: json['dob'],
      age: json['age'],
      username: json['username'],
      password: json['password'],
      cpassword: json['cpassword'],
      companyname: json['companyname'],
      companyownername: json['companyownername'],
      companyaddress: json['companyaddress'],
      logo: json['logo'],
      website: json['website'],
      google: json['google'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      linkedin: json['linkedin'],
      instagram: json['instagram'],
      profileimage: json['profileimage'],
      date: json['date'],
      smsEnable: json['sms_enable'],
      emailEnable: json['email_enable'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
    );
  }
}
