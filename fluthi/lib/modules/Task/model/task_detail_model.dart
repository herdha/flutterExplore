class TaskDetailModel {
  String? note;
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

  TaskDetailModel(
      {this.note,
      this.sId,
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

  TaskDetailModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    assignBy = json['assignBy'] != null
        ? new AssignBy.fromJson(json['assignBy'])
        : null;
    statusTask = json['statusTask'];
    areaStart = json['areaStart'] != null
        ? new AreaStart.fromJson(json['areaStart'])
        : null;
    areaEnd = json['areaEnd'] != null
        ? new AreaStart.fromJson(json['areaEnd'])
        : null;
    assignTo = json['assignTo'] != null
        ? new AssignBy.fromJson(json['assignTo'])
        : null;
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
    timeTotal = json['timeTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.assignBy != null) {
      data['assignBy'] = this.assignBy!.toJson();
    }
    data['statusTask'] = this.statusTask;
    if (this.areaStart != null) {
      data['areaStart'] = this.areaStart!.toJson();
    }
    if (this.areaEnd != null) {
      data['areaEnd'] = this.areaEnd!.toJson();
    }
    if (this.assignTo != null) {
      data['assignTo'] = this.assignTo!.toJson();
    }
    data['timeStart'] = this.timeStart;
    data['timeEnd'] = this.timeEnd;
    data['timeTotal'] = this.timeTotal;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['role'] = this.role;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['areaName'] = this.areaName;
    data['long'] = this.long;
    data['lat'] = this.lat;
    return data;
  }
}