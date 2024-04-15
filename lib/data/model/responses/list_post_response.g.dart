// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPostUserResponse _$ListPostUserResponseFromJson(
        Map<String, dynamic> json) =>
    ListPostUserResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$ListPostUserResponseToJson(
        ListPostUserResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      image: json['image'] as String?,
      likes: json['likes'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      text: json['text'] as String?,
      publishDate: json['publish_date'] as String?,
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'likes': instance.likes,
      'tags': instance.tags,
      'text': instance.text,
      'publish_date': instance.publishDate,
      'owner': instance.owner,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      id: json['id'] as String?,
      title: json['title'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'picture': instance.picture,
    };
