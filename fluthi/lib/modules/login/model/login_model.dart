class LoginModel {
  Id? iId;
  String? name;
  String? username;
  String? email;
  String? role;
  String? password;
  RoleRef? roleRef;
  String? token;

  LoginModel(
    {
      this.iId,
      this.name,
      this.username,
      this.email,
      this.role,
      this.password,
      this.roleRef,
      this.token
    }
  );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    iId : json['_id'] != null ? Id.fromJson(json['_id']) : null,
    name : json['name'],
    username : json['username'],
    email : json['email'],
    role : json['role'],
    password : json['password'],
    roleRef :
        json['roleRef'] != null ? RoleRef.fromJson(json['roleRef']) : null,
    token : json['token'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iId != null) {
      data['_id'] = iId!.toJson();
    }
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['role'] = role;
    data['password'] = password;
    if (roleRef != null) {
      data['roleRef'] = roleRef!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$oid'] = oid;
    return data;
  }
}

class RoleRef {
  String? name;
  List<Permission>? permission;

  RoleRef({this.name, this.permission});

  RoleRef.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['permission'] != null) {
      permission = <Permission>[];
      json['permission'].forEach((v) {
        permission!.add(Permission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (permission != null) {
      data['permission'] = permission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permission {
  String? name;
  bool? allAccess;
  List<Menu>? menu;

  Permission({this.name, this.allAccess, this.menu});

  Permission.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    allAccess = json['allAccess'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['allAccess'] = allAccess;
    if (menu != null) {
      data['menu'] = menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String? name;
  bool? view;
  bool? add;
  bool? edit;
  bool? delete;
  bool? scan;
  bool? start;
  bool? end;

  Menu(
      {this.name,
      this.view,
      this.add,
      this.edit,
      this.delete,
      this.scan,
      this.start,
      this.end});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    view = json['view'];
    add = json['add'];
    edit = json['edit'];
    delete = json['delete'];
    scan = json['scan'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['view'] = view;
    data['add'] = add;
    data['edit'] = edit;
    data['delete'] = delete;
    data['scan'] = scan;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}