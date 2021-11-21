import 'package:json_annotation/json_annotation.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';

part 'hotel_model.g.dart';

@JsonSerializable()
class HotelModel {
  String? name;
  int? noRoom;
  double? rentPrice;
  String? description;
  String? street;
  String? ward;
  String? district;
  String? city;
  String? furnitureType;
  String? imagePath;
  List<int>? amenities;
  String? houseType;
  UserModel? author;
  List<String>? comments;
  String? createdAt;

  HotelModel({
   this.name,
    this.noRoom,
    this.rentPrice,
    this.description,
    this.street,
    this.ward,
    this.district,
    this.city,
    this.houseType,
    this.furnitureType,
    this.imagePath,
    this.amenities,
    this.author,
    this.comments,
    this.createdAt,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);

}
