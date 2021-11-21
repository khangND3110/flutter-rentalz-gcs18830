import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/amenity/amenity_model.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';
import 'package:rentalz_gcs18830_flutter/gen/assets.gen.dart';
import 'package:rentalz_gcs18830_flutter/utils/custom_colors.dart';

import '../controllers/report_detail_controller.dart';

class ReportDetailView extends GetView<ReportDetailController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHomeImage(),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: _buildHomeDetail(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      height: 90,
                      child: _buildImageList(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text(
                              'Amenities',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildGridView(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              'Contact',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              "Reporter: ${controller.houseModel.value.author?.fullName}",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              "Phone: ${controller.houseModel.value.author?.phoneNumber}",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildBookContainer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeDetail() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Obx(
              () => Text(
                controller.houseModel.value.name ?? '',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Obx(
              () => Text(
                '${controller.houseModel.value.street},'
                ' ${controller.houseModel.value.ward},'
                ' ${controller.houseModel.value.district},'
                ' ${controller.houseModel.value.city}',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
            ),
            child: Row(
              children: [
                _buildIconInfo(
                    icon: FontAwesomeIcons.bed, num: controller.houseModel.value.noRoom ?? 0),
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
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'House type:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Obx(
                  () => Text(
                "${controller.houseModel.value.houseType}",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Obx(
              () => Text(
                "${controller.houseModel.value.description}",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return Obx(
      () => GridView.builder(
        itemCount: controller.houseModel.value.amenities?.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 1.0,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return Obx(() {
            var amenity = _buildAmenityType(controller.houseModel.value.amenities?[index] ?? 0);
            return Container(
              decoration: BoxDecoration(
                color: CustomColors.grey,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: amenity.icon,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        amenity.title ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildImageList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, builder) {
        return Container(
          width: Get.width / 3 + 40,
          height: 90,
          margin: EdgeInsets.only(
            right: 10,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.imgOnBoarding,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHomeImage() {
    return Container(
      height: Get.height / 2,
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(controller.houseModel.value.imagePath ?? '')),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: _buildButtonRadius(
              icon: Icons.keyboard_arrow_left_rounded,
              onTap: () {
                Get.back();
              },
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: _buildButtonRadius(
              icon: FontAwesomeIcons.pen,
              onTap: () {
                Map<String, String> parameters = {};
                parameters["house_model"] = jsonEncode(controller.houseModel);
                Get.toNamed(Routes.REPORT_EDIT, parameters: parameters);
              },
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: _buildButtonRadius(
              icon: FontAwesomeIcons.trashAlt,
              onTap: () {
                controller.onDeleteClick();
              },
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRadius({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: color,
              ),
            ),
          ),
        ),
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

  Widget _buildBookContainer() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.grey,
      ),
      width: Get.width,
      height: 70,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => Text(
                    "\$${controller.houseModel.value.rentPrice}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.blue,
                    ),
                  ),
                ),
                Text(
                  "Total price",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _buildBookButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton() {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Container(
            child: Center(
              child: Text(
                "Book now",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AmenityModel _buildAmenityType(int type) {
    switch (type) {
      case 1:
        return AmenityModel(
          id: 1,
          icon: Icon(FontAwesomeIcons.wifi, size: 40),
          title: 'Free wifi',
          isSelected: false,
        );
      case 2:
        return AmenityModel(
          id: 2,
          icon: Icon(FontAwesomeIcons.carAlt, size: 40),
          title: 'Free parking',
          isSelected: false,
        );
      case 3:
        return AmenityModel(
          id: 3,
          icon: Icon(FontAwesomeIcons.swimmer, size: 40),
          title: 'Free pool',
          isSelected: false,
        );
      case 4:
        return AmenityModel(
          id: 4,
          icon: Icon(FontAwesomeIcons.wind, size: 40),
          title: 'Air freshener',
          isSelected: false,
        );
      default:
        return AmenityModel(
          id: 1,
          icon: Icon(FontAwesomeIcons.wifi, size: 40),
          title: 'Free wifi',
          isSelected: false,
        );
    }
  }
}
