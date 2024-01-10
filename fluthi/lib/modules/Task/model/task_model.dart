class TaskModel {
  String? sId;
  String? title;
  String? description;
  AssignBy? assignBy;
  String? statusTask;
  AreaStart? areaStart;
  AreaStart? areaEnd;
  AssignBy? assignTo;
  String? timeStart;
  String? timeEnd;
  String? timeTotal;

  TaskModel(
      {this.sId,
      this.title,
      this.description,
      this.assignBy,
      this.statusTask,
      this.areaStart,
      this.areaEnd,
      this.assignTo,
      this.timeStart,
      this.timeEnd,
      this.timeTotal});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    assignBy = json['assignBy'] != null
        ? AssignBy.fromJson(json['assignBy'])
        : null;
    statusTask = json['statusTask'];
    areaStart = json['areaStart'] != null
        ? AreaStart.fromJson(json['areaStart'])
        : null;
    areaEnd = json['areaEnd'] != null
        ? AreaStart.fromJson(json['areaEnd'])
        : null;
    assignTo = json['assignTo'] != null
        ? AssignBy.fromJson(json['assignTo'])
        : null;
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
    timeTotal = json['timeTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    if (assignBy != null) {
      data['assignBy'] = assignBy!.toJson();
    }
    data['statusTask'] = statusTask;
    if (areaStart != null) {
      data['areaStart'] = areaStart!.toJson();
    }
    if (areaEnd != null) {
      data['areaEnd'] = areaEnd!.toJson();
    }
    if (assignTo != null) {
      data['assignTo'] = assignTo!.toJson();
    }
    data['timeStart'] = timeStart;
    data['timeEnd'] = timeEnd;
    data['timeTotal'] = timeTotal;
    return data;
  }
}

class AssignBy {
  String? uid;
  String? username;
  String? role;

  AssignBy({this.uid, this.username, this.role});

  AssignBy.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['role'] = role;
    return data;
  }
}

class AreaStart {
  String? areaName;
  double? long;
  double? lat;

  AreaStart({this.areaName, this.long, this.lat});

  AreaStart.fromJson(Map<String, dynamic> json) {
    areaName = json['areaName'];
    long = json['long'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['areaName'] = areaName;
    data['long'] = long;
    data['lat'] = lat;
    return data;
  }
}