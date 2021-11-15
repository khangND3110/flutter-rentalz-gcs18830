import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/amenity/amenity_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/city_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/district_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_list_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/vietnam_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/ward_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/list_home/controllers/list_home_controller.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_modal_configuration.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/dialog_widgets.dart';
import 'package:rentalz_gcs18830_flutter/gen/assets.gen.dart';
import 'package:rentalz_gcs18830_flutter/utils/image_picker_utils.dart';

class AddHotelController extends GetxController {
  /// hotel name
  final hotelName = ''.obs;
  final isHotelNameValid = false.obs;
  final hotelNameInitialized = false.obs;
  final hotelNameErrorText = ''.obs;
  TextEditingController hotelNameController = TextEditingController();

  /// street
  final street = ''.obs;
  final isStreetValid = false.obs;
  final streetInitialized = false.obs;
  final streetErrorText = ''.obs;
  TextEditingController streetController = TextEditingController();

  /// num of room
  final noRoom = ''.obs;
  final isNoRoomValid = false.obs;
  final noRoomInitialized = false.obs;
  final noRoomErrorText = ''.obs;
  TextEditingController noRoomController = TextEditingController();

  /// rent price
  final rentPrice = ''.obs;
  final isRentPriceValid = false.obs;
  final rentPriceInitialized = false.obs;
  final rentPriceErrorText = ''.obs;
  TextEditingController rentPriceController = TextEditingController();

  /// description
  final description = ''.obs;
  final isDescriptionErrorVisible = false.obs;
  final descriptionErrorText = ''.obs;

  /// buttons
  final enableButton = false.obs;

  /// dropdowns
  final cityList = <CityModel>[].obs;
  final cityName = ''.obs;

  final districtList = <DistrictModel>[].obs;
  final districtName = ''.obs;

  final wardList = <WardModel>[].obs;
  final wardName = ''.obs;

  final furnitureList = <String>[
    'Unfurnished',
    'Part furnished',
    'Furnished',
  ].obs;
  final furnitureName = ''.obs;

  final houseTypeList = <String>[
    'House',
    'Apartment',
    'Villa',
  ].obs;
  final houseTypeName = ''.obs;

  /// image
  final imagePath = ''.obs;

  /// Amenities
  final amenityIds = <int>[].obs;
  final amenityList = <AmenityModel>[
    AmenityModel(
      id: 1,
      icon: Icon(FontAwesomeIcons.wifi, size: 40),
      title: 'Free wifi',
      isSelected: false,
    ),
    AmenityModel(
      id: 2,
      icon: Icon(FontAwesomeIcons.carAlt, size: 40),
      title: 'Free parking',
      isSelected: false,
    ),
    AmenityModel(
      id: 3,
      icon: Icon(FontAwesomeIcons.swimmer, size: 40),
      title: 'Free pool',
      isSelected: false,
    ),
    AmenityModel(
      id: 4,
      icon: Icon(FontAwesomeIcons.wind, size: 40),
      title: 'Air freshener',
      isSelected: false,
    ),
  ].obs;

  late UserModel? userModel;

  @override
  void onInit() {
    super.onInit();
    userModel = LocalStorageManager().getUser();
    initDataCity();
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// hotel name
  void onHotelNameChanged(String hotelName) {
    if (!hotelNameInitialized.value) {
      hotelNameInitialized.value = true;
    }
    if (hotelName.isEmpty) {
      hotelNameController.clear();
    }
    this.hotelName.value = hotelName;

    if (hotelName.isEmpty) {
      hotelNameErrorText.value = 'This field is required';
    }
    isHotelNameValid.value = hotelName.isNotEmpty;
    checkButtonValid();
  }

  /// num of room
  void onNoRoomChanged(String noRoom) {
    if (!noRoomInitialized.value) {
      noRoomInitialized.value = true;
    }
    if (noRoom.isEmpty) {
      noRoomController.clear();
    }
    this.noRoom.value = noRoom;

    if (noRoom.isEmpty) {
      noRoomErrorText.value = 'This field is required';
    }
    isNoRoomValid.value = noRoom.isNotEmpty;
    checkButtonValid();
  }

  /// rent price
  void onRentPriceChanged(String rentPrice) {
    if (!rentPriceInitialized.value) {
      rentPriceInitialized.value = true;
    }
    if (rentPrice.isEmpty) {
      rentPriceController.clear();
    }
    this.rentPrice.value = rentPrice;

    if (rentPrice.isEmpty) {
      rentPriceErrorText.value = 'This field is required';
    }
    isRentPriceValid.value = rentPrice.isNotEmpty;
    checkButtonValid();
  }

  /// street
  void onStreetChanged(String street) {
    if (!streetInitialized.value) {
      streetInitialized.value = true;
    }
    if (street.isEmpty) {
      streetController.clear();
    }
    this.street.value = street;

    if (street.isEmpty) {
      streetErrorText.value = 'This field is required';
    }
    isStreetValid.value = street.isNotEmpty;
    checkButtonValid();
  }

  void onDesciptionChanged(String message) {
    description.value = message;
    if (message.isEmpty) {
      descriptionErrorText.value = 'This field is required';
      isDescriptionErrorVisible.value = true;
    } else {
      descriptionErrorText.value = '';
      isDescriptionErrorVisible.value = false;
    }
    checkButtonValid();
  }

  void checkButtonValid() {
    final isAmenityNotEmpty = amenityList.where((item) => item.isSelected == true).isNotEmpty;

    enableButton.value = isHotelNameValid.value &&
        isNoRoomValid.value &&
        isRentPriceValid.value &&
        isStreetValid.value &&
        description.isNotEmpty &&
        cityName.isNotEmpty &&
        districtName.isNotEmpty &&
        wardName.isNotEmpty &&
        furnitureName.isNotEmpty &&
        imagePath.isNotEmpty &&
        isAmenityNotEmpty;
  }

  Future<void> initDataCity() async {
    print('on init data');

    var json = Assets.json.address;
    String data = await rootBundle.loadString(json);
    Map<String, dynamic> jsonResult = await jsonDecode(data);
    var model = VietnamModel.fromJson(jsonResult);
    cityList.value = model.data ?? [];
  }

  /// Image picker dialog

  Future<void> choosePhotoDialog() async {
    showModal(
      context: Get.context!,
      configuration: BlurFadeScaleTransitionConfiguration(barrierDismissible: true),
      builder: (context) {
        return DialogWidgets().imagePickerDialog(
          onUpload: () async => {
            imagePath.value = await ImagePickerUtils().getImagePathGallery(
                  maxHeight: 1080,
                  maxWidth: 1920,
                  imageQuality: 0,
                ) ??
                '',
            checkButtonValid(),
            Get.back(),
          },
          onTakePhoto: () async => {
            {
              imagePath.value = await ImagePickerUtils().getImagePathCamera(
                    maxHeight: 1080,
                    maxWidth: 1920,
                    imageQuality: 0,
                  ) ?? '',
              checkButtonValid(),
              Get.back(),
            }
          },
        );
      },
    );
  }

  void onCreateHotel() async {
    if(enableButton.isTrue) {
      await initializeDateFormatting('vi-VN', null);
      String createdAt = DateFormat.yMd().add_jm().format(DateTime.now());

      HotelListModel? hotelList = LocalStorageManager().getHotelList();
      final amenities = amenityList.where((item) => item.isSelected == true).map((e) => e.id ?? 0).toList();

      var hotel = HotelModel(
        name: hotelName.value,
        noRoom: int.parse(noRoom.value),
        rentPrice: double.parse(rentPrice.value),
        description: description.value,
        street: street.value,
        ward: wardName.value,
        district: districtName.value,
        city: cityName.value,
        houseType: houseTypeName.value,
        furnitureType: furnitureName.value,
        imagePath: imagePath.value,
        amenities: amenities,
        author: userModel,
        createdAt: createdAt,
      );

      print('time: $createdAt');

      if(hotelList == null) {
        HotelListModel list = HotelListModel();
        list.hotels = [hotel];
        LocalStorageManager().setHotelList(list);
      } else {
        hotelList.hotels?.add(hotel);
        LocalStorageManager().setHotelList(hotelList);
      }
      ListHomeController _listHomeController = Get.put(ListHomeController());
      _listHomeController.onRefreshHomeList();
      Get.until((route) => route.settings.name == Routes.LIST_HOME);
    }
  }

  void onCallValue() {
    print(LocalStorageManager().getHotelList());
  }

  @override
  void onClose() {}
}
