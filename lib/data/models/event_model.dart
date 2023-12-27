class EventData {
  final String? programId; // Added missing field
  final String? id;
  final String? programName;
  final String? programCategory;
  final String? programSubCategory;
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
  final String? timeOfEmail;
  final String? about;
  final String? departmentBy;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? category;
  final String? categoryHindi;
  final String? categoryIcon;
  final String? description;
  final String? date;
  final String? cDiv;
  final String? cCompany;
  final String? subcategory;
  final String? subcategoryHindi;
  final String? catid;
  final String? subIcon;
  final String? subDiv;
  final String? subComp;
  final String? userId; // Added missing field
  final String? roles;
  final String? username;
  final String? deptCode;
  final String? deptName;
  final String? deptWebsite;
  final String? deptAbout;
  final String? deptImage;
  final String? academyBanner;
  final String? deptmentName;
  final String? deptAddress;
  final String? deptContact;
  final String? deptName1;
  final String? deptDesignation;
  final String? academyNotice;
  final String? deptMobile;
  final String? deptEmail;
  final String? deptPassword;
  final String? venueName;
  final String? venueContact;
  final String? venueWebsite;
  final String? venueState;
  final String? venueCity;
  final String? venueArea;
  final String? venuePincode;
  final String? venueAddress;
  final String? venueLogo;
  final String? venueImage;
  final String? venueAbout;
  final String? venueGoogleLocation;
  final String? updatedBy;
  final String? stateName;
  final String? cityName;
  final List<ArtistModel>? artists;

  EventData({
    this.programId,
    this.id,
    this.programName,
    this.programCategory,
    this.programSubCategory,
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
    this.timeOfEmail,
    this.about,
    this.departmentBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.category,
    this.categoryHindi,
    this.categoryIcon,
    this.description,
    this.date,
    this.cDiv,
    this.cCompany,
    this.subcategory,
    this.subcategoryHindi,
    this.catid,
    this.subIcon,
    this.subDiv,
    this.subComp,
    this.userId,
    this.roles,
    this.username,
    this.deptCode,
    this.deptName,
    this.deptWebsite,
    this.deptAbout,
    this.deptImage,
    this.academyBanner,
    this.deptmentName,
    this.deptAddress,
    this.deptContact,
    this.deptName1,
    this.deptDesignation,
    this.academyNotice,
    this.deptMobile,
    this.deptEmail,
    this.deptPassword,
    this.venueName,
    this.venueContact,
    this.venueWebsite,
    this.venueState,
    this.venueCity,
    this.venueArea,
    this.venuePincode,
    this.venueAddress,
    this.venueLogo,
    this.venueImage,
    this.venueAbout,
    this.venueGoogleLocation,
    this.updatedBy,
    this.stateName,
    this.cityName,
    this.artists,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    // Parse the "artists" field as a list of maps
    List<dynamic>? artistsJson = json['artists'];

    return EventData(
      programId: json['program_id'],
      id: json['id'],
      programName: json['program_name'],
      programCategory: json['program_category'],
      programSubCategory: json['program_sub_category'],
      programType: json['program_type'],
      programLink: json['program_link'],
      startingDate: json['starting_date'],
      endDate: json['end_date'],
      startingTime: json['starting_time'],
      endTime: json['end_time'],
      entryType: json['entry_type'],
      chiefGuest: json['chief_guest'],
      venue: json['venue'],
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
      timeOfEmail: json['time_of_email'],
      about: json['about'],
      departmentBy: json['department_by'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
      category: json['category'],
      categoryHindi: json['category_hindi'],
      categoryIcon: json['category_icon'],
      description: json['description'],
      date: json['date'],
      cDiv: json['c_div'],
      cCompany: json['c_company'],
      subcategory: json['subcategory'],
      subcategoryHindi: json['subcategory_hindi'],
      catid: json['catid'],
      subIcon: json['sub_icon'],
      subDiv: json['sub_div'],
      subComp: json['sub_comp'],
      userId: json['userId'],
      roles: json['roles'],
      username: json['username'],
      deptCode: json['dept_code'],
      deptName: json['dept_name'],
      deptWebsite: json['dept_website'],
      deptAbout: json['dept_about'],
      deptImage: json['dept_image'],
      academyBanner: json['academy_baner'],
      deptmentName: json['deptment_name'],
      deptAddress: json['dept_address'],
      deptContact: json['dept_contact'],
      deptName1: json['dept_name1'],
      deptDesignation: json['dept_designation'],
      academyNotice: json['academy_notice'],
      deptMobile: json['dept_mobile'],
      deptEmail: json['dept_email'],
      deptPassword: json['dept_password'],
      venueName: json['venue_name'],
      venueContact: json['venue_contact'],
      venueWebsite: json['venue_website'],
      venueState: json['venue_state'],
      venueCity: json['venue_city'],
      venueArea: json['venue_area'],
      venuePincode: json['venue_picode'],
      venueAddress: json['venue_address'],
      venueLogo: json['venue_logo'],
      venueImage: json['venue_image'],
      venueAbout: json['venue_about'],
      venueGoogleLocation: json['venue_google_location'],
      updatedBy: json['updated_by'],
      stateName: json['state_name'],
      cityName: json['city_name'],
      artists: artistsJson != null
          ? artistsJson
              .map((artistJson) => ArtistModel.fromJson(artistJson))
              .toList()
          : null,
    );
  }
}

class ArtistModel {
  final String? artistName;
  final String? artistMobile;
  final String? artistDate;
  final String? artistTime;
  final String? artistEmail;

  ArtistModel({
    this.artistName,
    this.artistMobile,
    this.artistDate,
    this.artistTime,
    this.artistEmail,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      artistName: json['artist_name'],
      artistMobile: json['artist_mobile'],
      artistDate: json['artist_date'],
      artistTime: json['artist_time'],
      artistEmail: json['artist_email'],
    );
  }
}
