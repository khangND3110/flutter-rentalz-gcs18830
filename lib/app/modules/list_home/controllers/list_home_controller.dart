import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';
import 'package:rentalz_gcs18830_flutter/gen/assets.gen.dart';
import 'package:tuple/tuple.dart';

class ListHomeController extends GetxController {
  final homeList = <HotelModel>[].obs;
  final homeListClone = <HotelModel>[].obs;
  final houseType = ''.obs;
  final searchValue = ''.obs;
  final filterCityValue = ''.obs;

  late UserModel? userModel;

  final cityListFilter = <Tuple2<String, AssetGenImage>>[
    Tuple2('Hồ Chí Minh', Assets.images.imgHoChiMinh,),
    Tuple2('Đà Lạt', Assets.images.imgDalat,),
    Tuple2('Nha Trang', Assets.images.imgNhaTrang,),
    Tuple2('Đà Nẵng', Assets.images.imgDaNang,),
  ];

  @override
  void onInit() {
    super.onInit();
    userModel = LocalStorageManager().getUser();
    onRefreshHomeList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onRefreshHomeList() {
    homeList.value = LocalStorageManager().getHotelList()?.hotels ?? [];
    homeListClone.assignAll(homeList);
  }

  void onFilterCity(String city) {
    filterCityValue.value = city;
    onFilterList();
  }

  void onFilterHouseType(String type) {
    houseType.value = type;
    onFilterList();
  }

  void onSearchChanged(String search) {
    searchValue.value = search;
    onFilterList();
  }

  void onFilterList() {
    homeListClone.value = homeList
        .where(
            (element) {
          bool searchSearch = element.name?.toLowerCase().contains(searchValue.value.toLowerCase()) ?? false;
          bool filterHouseType = element.houseType == houseType.value;
          bool filterCity = element.city?.toLowerCase() == filterCityValue.value.toLowerCase();
          return searchSearch && filterHouseType && filterCity;
        }
    )
        .toList();
  }
}
