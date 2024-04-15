// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListUserResponse _$ListUserResponseFromJson(Map<String, dynamic> json) =>
    ListUserResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$ListUserResponseToJson(ListUserResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      title: json['title'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'picture': instance.picture,
    };
