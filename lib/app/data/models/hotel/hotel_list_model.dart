import 'package:json_annotation/json_annotation.dart';

import 'hotel_model.dart';

part 'hotel_list_model.g.dart';

@JsonSerializable()
class HotelListModel {
  List<HotelModel>? hotels;

  HotelListModel({
    this.hotels,
  });

  factory HotelListModel.fromJson(Map<String, dynamic> json) =>
      _$HotelListModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelListModelToJson(this);

}
