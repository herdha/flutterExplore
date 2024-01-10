class DriverModel {
  String? title;
  int? total;

  DriverModel({this.title, this.total});

  DriverModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['total'] = total;
    return data;
  }
}