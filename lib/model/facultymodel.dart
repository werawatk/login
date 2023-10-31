class FacultyModel {
  FacultyModel({
    required this.facId,
    required this.facName,
    required this.facPhone,
    required this.facImg,
  });

  final String facId;
  final String facName;
  final String facPhone;
  final String facImg;

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      facId: json["fac_id"],
      facName: json["fac_name"],
      facPhone: json["fac_phone"],
      facImg: json["fac_img"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fac_id": facId,
        "fac_name": facName,
        "fac_phone": facPhone,
        "fac_img": facImg,
      };
}
