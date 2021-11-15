import 'package:get/get.dart';

import 'package:rentalz_gcs18830_flutter/app/modules/auth/login/bindings/login_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/auth/login/views/login_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/auth/register/bindings/register_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/auth/register/views/register_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/home/bindings/home_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/home/views/home_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/list_home/bindings/list_home_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/list_home/home_detail/bindings/home_detail_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/list_home/home_detail/views/home_detail_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/list_home/views/list_home_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/on_boarding/bindings/on_boarding_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/on_boarding/views/on_boarding_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/splash/bindings/splash_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/splash/views/splash_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/add_hotel/bindings/add_hotel_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/add_hotel/views/add_hotel_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/bindings/user_profile_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/edit_profile/bindings/edit_profile_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/edit_profile/views/edit_profile_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/bindings/report_list_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/report_detail/bindings/report_detail_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/report_detail/report_edit/bindings/report_edit_binding.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/report_detail/report_edit/views/report_edit_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/report_detail/views/report_detail_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/views/report_list_view.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/views/user_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ON_BOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.LIST_HOME,
      page: () => ListHomeView(),
      binding: ListHomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME_DETAIL,
      page: () => HomeDetailView(),
      binding: HomeDetailBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_HOTEL,
      page: () => AddHotelView(),
      binding: AddHotelBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_LIST,
      page: () => ReportListView(),
      binding: ReportListBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_EDIT,
      page: () => ReportEditView(),
      binding: ReportEditBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_DETAIL,
      page: () => ReportDetailView(),
      binding: ReportDetailBinding(),
    ),
  ];
}
