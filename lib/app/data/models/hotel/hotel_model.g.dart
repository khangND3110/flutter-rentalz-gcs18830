// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelModel _$HotelModelFromJson(Map<String, dynamic> json) {
  return HotelModel(
    name: json['name'] as String?,
    noRoom: json['noRoom'] as int?,
    rentPrice: (json['rentPrice'] as num?)?.toDouble(),
    description: json['description'] as String?,
    street: json['street'] as String?,
    ward: json['ward'] as String?,
    district: json['district'] as String?,
    city: json['city'] as String?,
    houseType: json['houseType'] as String?,
    furnitureType: json['furnitureType'] as String?,
    imagePath: json['imagePath'] as String?,
    amenities:
        (json['amenities'] as List<dynamic>?)?.map((e) => e as int).toList(),
    author: json['author'] == null
        ? null
        : UserModel.fromJson(json['author'] as Map<String, dynamic>),
    comments:
        (json['comments'] as List<dynamic>?)?.map((e) => e as String).toList(),
    createdAt: json['createdAt'] as String?,
  );
}

Map<String, dynamic> _$HotelModelToJson(HotelModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'noRoom': instance.noRoom,
      'rentPrice': instance.rentPrice,
      'description': instance.description,
      'street': instance.street,
      'ward': instance.ward,
      'district': instance.district,
      'city': instance.city,
      'furnitureType': instance.furnitureType,
      'imagePath': instance.imagePath,
      'amenities': instance.amenities,
      'houseType': instance.houseType,
      'author': instance.author,
      'comments': instance.comments,
      'createdAt': instance.createdAt,
    };
