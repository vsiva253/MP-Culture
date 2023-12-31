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
  final String? profileImg;
  final String? bannerImg;
  final String? bannerImg1;
  final String? attachmentEmailImg;
  final String? dateOfEmail;
  final String? about;
  final String? departmentBy;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final List<ArtistModel>? artists;

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
    this.profileImg,
    this.bannerImg,
    this.bannerImg1,
    this.attachmentEmailImg,
    this.dateOfEmail,
    this.about,
    this.departmentBy,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.artists,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    // Parse the "artists" field as a list of maps
    List<dynamic>? artistsJson = json['artists'];

    return EventData(
      id: json['id'],
      programName: json['program_name'],
      programCategory: json['program_category'],
      programType: json['program_type'],
      programLink: json['program_link'],
      startingDate: json['starting_date'],
      endDate: json['end_date'],
      startingTime: json['starting_time'],
      endTime: json['end_time'],
      entryType: json['entry_type'],
      chiefGuest: json['chief_guest'],
      venue: json['venu'],
      address: json['address'],
      state: json['state'],
      district: json['district'],
      city: json['city'],
      pincode: json['pincode'],
      profileImg: json['profile_img'],
      bannerImg: json['banner_img'],
      bannerImg1: json['banner_img1'],
      attachmentEmailImg: json['attachment_email_img'],
      dateOfEmail: json['date_of_email'],
      about: json['about'],
      departmentBy: json['department_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
      artists: artistsJson != null
          ? artistsJson
              .map((artistJson) => ArtistModel.fromJson(artistJson))
              .toList()
          : null,
    );
  }
}

class ArtistModel {
  final String? name;
  final String? category;
  final String? artistDatetime;
  final String? description;

  ArtistModel({
    this.name,
    this.category,
    this.artistDatetime,
    this.description,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      name: json['name'],
      category: json['category'],
      artistDatetime: json['artist_datetime'],
      description: json['description'],
    );
  }
}
