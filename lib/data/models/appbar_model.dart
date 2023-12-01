class ToolbarImagesModel {
  final String? id;
  final String? headerTitle;
  final String? headerLogo;
  final String? secondLogo;
  final String? types;
  final String? isApp;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  ToolbarImagesModel({
    this.id,
    this.headerTitle,
    this.headerLogo,
    this.secondLogo,
    this.types,
    this.isApp,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ToolbarImagesModel.fromJson(Map<String, dynamic> json) {
    return ToolbarImagesModel(
      id: json['id'] ?? '',
      headerTitle: json['header_title'] ?? '',
      headerLogo: json['header_logo'] ?? '',
      secondLogo: json['second_logo'] ?? '',
      types: json['types'] ?? '',
      isApp: json['is_app'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
