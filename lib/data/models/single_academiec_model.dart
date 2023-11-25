class SingleAacademies {
  final String? id;
  final String? username;
  final String? deptCode;
  final String? deptName;
  final String? deptWebsite;
  final String? deptAbout;
  final String? deptmentName;
  final String? deptAddress;
  final String? deptContact;
  final String? deptName1;
  final String? deptDesignation;
  final String? deptMobile;
  final String? deptEmail;
  final String? createdAt;
  final String? updatedAt;
  final String? date;
  final String? status;

  SingleAacademies({
    this.id,
    this.username,
    this.deptCode,
    this.deptName,
    this.deptWebsite,
    this.deptAbout,
    this.deptmentName,
    this.deptAddress,
    this.deptContact,
    this.deptName1,
    this.deptDesignation,
    this.deptMobile,
    this.deptEmail,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.status,
  });

  factory SingleAacademies.fromJson(Map<String, dynamic> json) {
    return SingleAacademies(
      id: json['id'],
      username: json['username'],
      deptCode: json['dept_code'],
      deptName: json['dept_name'],
      deptWebsite: json['dept_website'],
      deptAbout: json['dept_about'],
      deptmentName: json['deptment_name'],
      deptAddress: json['dept_address'],
      deptContact: json['dept_contact'],
      deptName1: json['dept_name1'],
      deptDesignation: json['dept_designation'],
      deptMobile: json['dept_mobile'],
      deptEmail: json['dept_email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      date: json['date'],
      status: json['status'],
    );
  }
}
