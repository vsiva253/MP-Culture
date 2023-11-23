class EventData {
  final String? id;
  final String? programName;
  final String? programCategory;
  final String? programType;
  final String? programLink;
  final String? startingDate;
  final String? endDate;
  final String? startingTime;
  final String? endTime;
  final String? entryType;
  final String? chiefGuest;
  final String? venue;
  final String? address;
  final String? state;
  final String? district;
  final String? city;
  final String? pincode;
  final String? profileImg1;
  final String? profileImg2;
  final String? profileImg3;
  final String? profileImg4;
  final String? dateOfEmail;
  final String? about;
  final String? departmentBy;
  final String? createdAt;
  final String? updatedAt;
  final String? status;

  EventData({
    this.id,
    this.programName,
    this.programCategory,
    this.programType,
    this.programLink,
    this.startingDate,
    this.endDate,
    this.startingTime,
    this.endTime,
    this.entryType,
    this.chiefGuest,
    this.venue,
    this.address,
    this.state,
    this.district,
    this.city,
    this.pincode,
    this.profileImg1,
    this.profileImg2,
    this.profileImg3,
    this.profileImg4,
    this.dateOfEmail,
    this.about,
    this.departmentBy,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'] ?? '',
      programName: json['program_name'] ?? '',
      programCategory: json['program_category'] ?? '',
      programType: json['program_type'] ?? '',
      programLink: json['program_link'] ?? '',
      startingDate: json['starting_date'] ?? '',
      endDate: json['end_date'] ?? '',
      startingTime: json['starting_time'] ?? '',
      endTime: json['end_time'] ?? '',
      entryType: json['entry_type'] ?? '',
      chiefGuest: json['chief_guest'] ?? '',
      venue: json['venu'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? '',
      profileImg1: json['profile_img1'] ?? '',
      profileImg2: json['profile_img2'] ?? '',
      profileImg3: json['profile_img3'] ?? '',
      profileImg4: json['profile_img4'] ?? '',
      dateOfEmail: json['date_of_email'] ?? '',
      about: json['about'] ?? '',
      departmentBy: json['department_by'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
