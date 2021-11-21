import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/amenity/amenity_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_list_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/city_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/district_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/vietnam_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/provine/ward_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/list_home/controllers/list_home_controller.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/controllers/report_list_controller.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_modal_configuration.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/dialog_widgets.dart';
import 'package:rentalz_gcs18830_flutter/gen/assets.gen.dart';
import 'package:rentalz_gcs18830_flutter/utils/image_picker_utils.dart';

class ReportEditController extends GetxController {
  late UserModel? userModel;
  final houseModel = HotelModel().obs;

  /// hotel name
  final hotelName = ''.obs;
  final isHotelNameValid = false.obs;
  final hotelNameInitialized = false.obs;
  final hotelNameErrorText = ''.obs;
  late TextEditingController hotelNameController = TextEditingController();

  /// street
  final street = ''.obs;
  final isStreetValid = false.obs;
  final streetInitialized = false.obs;
  final streetErrorText = ''.obs;
  late TextEditingController streetController = TextEditingController();

  /// num of room
  final noRoom = ''.obs;
  final isNoRoomValid = false.obs;
  final noRoomInitialized = false.obs;
  final noRoomErrorText = ''.obs;
  late TextEditingController noRoomController = TextEditingController();

  /// rent price
  final rentPrice = ''.obs;
  final isRentPriceValid = false.obs;
  final rentPriceInitialized = false.obs;
  final rentPriceErrorText = ''.obs;
  late TextEditingController rentPriceController = TextEditingController();

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

  @override
  void onInit() {
    super.onInit();
    userModel = LocalStorageManager().getUser();
    final houseJson = jsonDecode(Get.parameters['house_model'] ?? '');
    houseModel.value = HotelModel.fromJson(houseJson);
    initDataCity().then(
      (_) => {
        initValueHouse(),
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  void initValueHouse() {
    ///
    onHotelNameChanged(houseModel.value.name ?? '');
    hotelNameController.text = houseModel.value.name ?? '';

    ///
    onStreetChanged(houseModel.value.street ?? '');
    streetController.text = houseModel.value.street ?? '';

    ///
    onNoRoomChanged(houseModel.value.noRoom.toString());
    noRoomController.text = houseModel.value.noRoom.toString();

    ///
    onRentPriceChanged(houseModel.value.rentPrice.toString());
    rentPriceController.text = houseModel.value.rentPrice.toString();

    ///
    onDesciptionChanged(houseModel.value.description ?? '');

    /// city
    var city = cityList.firstWhere((ct) => ct.name == houseModel.value.city);
    cityName.value = city.name ?? '';
    districtList.value = city.districts ?? [];

    /// district
    var district = districtList.firstWhere((dt) => dt.name == houseModel.value.district);
    districtName.value = district.name ?? '';
    wardList.value = district.wards ?? [];

    /// ward
    var ward = wardList.firstWhere((w) => w.name == houseModel.value.ward);
    wardName.value = ward.name ?? '';

    /// House type
    houseTypeName.value = houseModel.value.houseType ?? '';

    /// Furniture type
    furnitureName.value = houseModel.value.furnitureType ?? '';

    /// image
    imagePath.value = houseModel.value.imagePath ?? '';

    /// amenities
    houseModel.value.amenities?.forEach((element) {
      amenityList.firstWhere((item) => element == item.id).isSelected = true;
    });
    amenityList.refresh();
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
                  ) ??
                  '',
              checkButtonValid(),
              Get.back(),
            }
          },
        );
      },
    );
  }

  void onEditClick() {
    showModal(
      context: Get.context!,
      configuration: BlurFadeScaleTransitionConfiguration(barrierDismissible: true),
      builder: (context) {
        return DialogWidgets().buildConfirmDialog(
          title: 'Edit hotel',
          description: 'Are you sure to edit this hotel?',
          onNegativeClick: () {
            Get.back();
          },
          onPositiveClick: () {
            onEditHotel();
            Get.back();
          },
        );
      },
    );
  }

  void onEditHotel() {
    if (enableButton.isTrue) {
      HotelListModel? currentHotelList = LocalStorageManager().getHotelList();
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
        createdAt: houseModel.value.createdAt,
      );

      int index = currentHotelList?.hotels?.indexWhere((element) => element.name == houseModel.value.name) ?? 0;
      currentHotelList!.hotels![index] = hotel;

      print(currentHotelList);

      LocalStorageManager().setHotelList(currentHotelList);

      ListHomeController _listHomeController = Get.put(ListHomeController());
      _listHomeController.onRefreshHomeList();

      ReportListController _reportListController = Get.put(ReportListController());
      _reportListController.onRefreshHomeList();
      Get.until((route) => route.settings.name == Routes.REPORT_LIST);
    }
  }

  void onCallValue() {
    print(LocalStorageManager().getHotelList());
  }

  @override
  void onClose() {}
}
