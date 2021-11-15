import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';
import 'package:rentalz_gcs18830_flutter/utils/custom_colors.dart';

import '../controllers/report_list_controller.dart';

class ReportListView extends GetView<ReportListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report List',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildHouseCardList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHouseCardList() {
    return Obx(
      () => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.homeList.length,
        itemBuilder: (context, index) {
          return _buildHouseCard(index);
        },
      ),
    );
  }

  Widget _buildHouseCard(int index) {
    return Obx(() {
      var house = controller.homeList[index];
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
              Get.toNamed(Routes.REPORT_DETAIL, parameters: parameters);
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
