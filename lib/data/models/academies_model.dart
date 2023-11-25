class DepartmentModel {
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

  DepartmentModel({
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

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as String?,
      username: json['username'] as String?,
      deptCode: json['dept_code'] as String?,
      deptName: json['dept_name'] as String?,
      deptWebsite: json['dept_website'] as String?,
      deptAbout: json['dept_about'] as String?,
      deptmentName: json['deptment_name'] as String?,
      deptAddress: json['dept_address'] as String?,
      deptContact: json['dept_contact'] as String?,
      deptName1: json['dept_name1'] as String?,
      deptDesignation: json['dept_designation'] as String?,
      deptMobile: json['dept_mobile'] as String?,
      deptEmail: json['dept_email'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
    );
  }
}
