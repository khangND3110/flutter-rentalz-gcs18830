// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelListModel _$HotelListModelFromJson(Map<String, dynamic> json) {
  return HotelListModel(
    hotels: (json['hotels'] as List<dynamic>?)
        ?.map((e) => HotelModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HotelListModelToJson(HotelListModel instance) =>
    <String, dynamic>{
      'hotels': instance.hotels,
    };
