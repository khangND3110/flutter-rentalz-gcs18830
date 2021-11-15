import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';
import 'package:rentalz_gcs18830_flutter/gen/assets.gen.dart';
import 'package:rentalz_gcs18830_flutter/utils/custom_colors.dart';
import 'package:tuple/tuple.dart';

import '../controllers/list_home_controller.dart';

class ListHomeView extends GetView<ListHomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildSearchContainer(),
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _buildLocationCardList(),
                    _buildHouseType(),
                    _buildHouseCardList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHouseCardList() {
    return Obx(
      () => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.homeListClone.length,
        itemBuilder: (context, index) {
          return _buildHouseCard(index);
        },
      ),
    );
  }

  Widget _buildHouseCard(int index) {
    return Obx(() {
      var house = controller.homeListClone[index];
      return Container(
        margin: EdgeInsets.only(
          right: 20,
          top: 20,
          left: 20,
        ),
        padding: EdgeInsets.all(10),
        height: Get.height / 3 + 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Map<String, String> parameters = {};
              parameters["house_model"] = jsonEncode(house);
              Get.toNamed(Routes.HOME_DETAIL, parameters: parameters);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            File(
                              house.imagePath ?? '',
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${house.name}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$${house.rentPrice}",
                                style: TextStyle(
                                  color: CustomColors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            "${house.street}, ${house.ward}, ${house.district}, ${house.city}",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Row(
                            children: [
                              _buildIconInfo(
                                icon: FontAwesomeIcons.bed,
                                num: house.noRoom ?? 0,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: _buildIconInfo(
                                  icon: FontAwesomeIcons.bath,
                                  num: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            "Created at: ${house.createdAt}",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHouseType() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  controller.onFilterHouseType('House');
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'House',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: controller.houseType.value == 'House'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  controller.onFilterHouseType('Apartment');
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Apartment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: controller.houseType.value == 'Apartment'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  controller.onFilterHouseType('Villa');
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Villa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: controller.houseType.value == 'Villa'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCardList() {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
      ),
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Discovery',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.cityListFilter.length,
              itemBuilder: (context, index) {
                return _buildLocationCard(controller.cityListFilter[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(Tuple2<String, AssetGenImage> data) {
    return Obx(
      () {
        return Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              controller.onFilterCity(data.item1);
            },
            child: Container(
              margin: EdgeInsets.only(
                right: 10,
                top: 20,
                bottom: 20,
                left: 5,
              ),
              padding: EdgeInsets.all(10),
              width: Get.width / 2 - 40,
              decoration: BoxDecoration(
                border: controller.filterCityValue.value == data.item1 ? Border.all(width: 0.5, color: Colors.grey) : null,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: data.item2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Text(
                          data.item1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchContainer() {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 60,
              width: Get.width,
              padding: EdgeInsets.only(
                right: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.grey,
              ),
              child: Center(
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.black,
                      size: 18,
                    ),
                    hintText: 'Search address',
                  ),
                  onChanged: controller.onSearchChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${controller.userModel?.fullName}',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50,
              width: 50,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () {
                    Get.toNamed(Routes.USER_PROFILE);
                  },
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: Assets.images.imgAvatar,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconInfo({
    required IconData icon,
    required int num,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 16,
        ),
        Container(
          margin: EdgeInsets.only(left: 6),
          child: Text(
            '$num',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
