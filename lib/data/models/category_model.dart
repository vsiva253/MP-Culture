class CatrgoryModel {
  final String? id;
  final String? category;
  final String? categoryHindi;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final String? date;
  final String? status;
  final String? cDiv;
  final String? cCompany;
  final String? categoryIcon; // Add the missing field

  CatrgoryModel({
    this.id,
    this.category,
    this.categoryHindi,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.status,
    this.cDiv,
    this.cCompany,
    this.categoryIcon, // Add the missing field
  });

  factory CatrgoryModel.fromJson(Map<String, dynamic> json) {
    return CatrgoryModel(
      id: json['id'],
      category: json['category'],
      categoryHindi: json['category_hindi'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      date: json['date'],
      status: json['status'],
      cDiv: json['c_div'],
      cCompany: json['c_company'],
      categoryIcon: json['category_icon'], // Add the missing field
    );
  }
}
