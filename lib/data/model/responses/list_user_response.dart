import 'package:json_annotation/json_annotation.dart';

part 'list_user_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ListUserResponse {
  List<Data>? data;
  int? total;
  int? page;
  int? limit;

  ListUserResponse({this.data, this.total, this.page, this.limit});

  ListUserResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  Data({this.id, this.title, this.firstName, this.lastName, this.picture});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['picture'] = this.picture;
    return data;
  }
}
