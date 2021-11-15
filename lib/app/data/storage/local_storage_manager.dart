import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_list_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_list_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';

class LocalStorageManager {
  ///Keys
  static const _hotelList = '_hotelList';
  static const _user = '_user';
  static const _userList = '_userList';

  ///
  ///Constructors
  static final LocalStorageManager _instance = LocalStorageManager._internal();

  LocalStorageManager._internal();

  factory LocalStorageManager() {
    return _instance;
  }

  ///
  ///Storage box
  static final storageBox = GetStorage();

  ///

  ///Initiate Get Storage
  Future<void> initGetStorage() async {
    await GetStorage.init();
  }

  /// Hotel List
  void setHotelList(HotelListModel? hotelList) {
    final storedHotelList = ReadWriteValue(_hotelList, '');
    if (hotelList == null) {
    }
    storedHotelList.val = json.encode(hotelList?.toJson());
  }

  HotelListModel? getHotelList() {
    final hotelListString = ReadWriteValue(_hotelList, '').val;
    if (hotelListString.isEmpty) {
      return null;
    } else {
      final hotelListJson = json.decode(hotelListString);
      final hotelList = HotelListModel.fromJson(hotelListJson);
      return hotelList;
    }
  }

  /// User
  void setUser(UserModel? user) {
    final storedUser = ReadWriteValue(_user, '');
    if (user == null) {
    }
    storedUser.val = json.encode(user?.toJson());
  }

  UserModel? getUser() {
    final userString = ReadWriteValue(_user, '').val;
    if (userString.isEmpty) {
      return null;
    } else {
      final userJson = json.decode(userString);
      final user = UserModel.fromJson(userJson);
      return user;
    }
  }

  /// User list
  void setUserList(UserListModel? userList) {
    final storedUserList = ReadWriteValue(_userList, '');
    if (userList == null) {
    }
    storedUserList.val = json.encode(userList?.toJson());
  }

  UserListModel? getUserList() {
    final userListString = ReadWriteValue(_userList, '').val;
    if (userListString.isEmpty) {
      return null;
    } else {
      final userListJson = json.decode(userListString);
      final userList = UserListModel.fromJson(userListJson);
      return userList;
    }
  }
}
