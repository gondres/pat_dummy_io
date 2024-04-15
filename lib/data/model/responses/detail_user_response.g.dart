// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailUserResponse _$DetailUserResponseFromJson(Map<String, dynamic> json) =>
    DetailUserResponse(
      id: json['id'] as String?,
      title: json['title'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      picture: json['picture'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      registerDate: json['register_date'] as String?,
      updatedDate: json['updated_date'] as String?,
    );

Map<String, dynamic> _$DetailUserResponseToJson(DetailUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'picture': instance.picture,
      'gender': instance.gender,
      'email': instance.email,
      'date_of_birth': instance.dateOfBirth,
      'phone': instance.phone,
      'location': instance.location,
      'register_date': instance.registerDate,
      'updated_date': instance.updatedDate,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'timezone': instance.timezone,
    };
