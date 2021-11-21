import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_basic_text_input.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_button.dart';
import 'package:rentalz_gcs18830_flutter/utils/custom_colors.dart';

import '../controllers/add_hotel_controller.dart';

class AddHotelView extends GetView<AddHotelController> {
  final Map<String, FocusNode> mapFocusNode = {
    "hotelName": FocusNode(),
    "noRoom": FocusNode(),
    "rentPrice": FocusNode(),
    "description": FocusNode(),
    "street": FocusNode(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Hotel',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHotelNameInput(),
              Row(children: [
                Expanded(
                  child: SizedBox(
                    child: _buildNoRoomInput(),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: _buildRentPriceInput(),
                  ),
                ),
              ]),
              _buildMessageInput(),
              _buildStreetInput(),
              _buildDropdown(
                inputTitle: 'City',
                child: _buildDropDownButtonCity(),
              ),
              Row(children: [
                Expanded(
                  child: SizedBox(
                      child: _buildDropdown(
                    inputTitle: 'Districts',
                    margin: EdgeInsets.only(
                      left: 20,
                      top: 10,
                      right: 5,
                    ),
                    child: _buildDropDownButtonDistrict(),
                  )),
                ),
                Expanded(
                  child: SizedBox(
                    child: _buildDropdown(
                      inputTitle: 'Ward',
                      margin: EdgeInsets.only(
                        right: 20,
                        top: 10,
                        left: 5,
                      ),
                      child: _buildDropDownButtonWard(),
                    ),
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: _buildDropdown(
                  inputTitle: 'Furniture types',
                  child: _buildDropDownButtonFurniture(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: _buildDropdown(
                  inputTitle: 'House types',
                  child: _buildDropDownButtonHouseType(),
                ),
              ),
              Obx(
                () => (controller.imagePath.value != '')
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                              File(
                                controller.imagePath.value,
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        width: Get.width,
                        height: 200,
                      )
                    : _buildUploadImage(),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Select amenities',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    _buildGridView(),
                    Obx(
                      () => CustomButton().buildEnableButton(
                        isButtonEnable: controller.enableButton.value,
                        title: 'Create',
                        onPresses: controller.enableButton.isTrue ? controller.onCreateClick : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    TextEditingController _textController = TextEditingController(
      text: controller.description.value,
    );

    ///Set cursor position to last
    _textController.selection = TextSelection.fromPosition(TextPosition(
      offset: _textController.text.length,
    ));
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.0),
              child: Text(
                'Description',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              height: 250.0,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: mapFocusNode['description'],
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Input description',
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: controller.onDesciptionChanged,
                  onSubmitted: (value) {
                    mapFocusNode['description']?.unfocus();
                    FocusScope.of(Get.context!).requestFocus(mapFocusNode['street']);
                  },
                ),
              ),
            ),
            controller.isDescriptionErrorVisible.value
                ? Container(
                    height: 15.0,
                    margin: EdgeInsets.only(left: 30.0),
                    child: Text(
                      controller.descriptionErrorText.value,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }

  Widget _buildHotelNameInput() {
    return Obx(
      () => CustomBasicTextInput(
        inputTitle: 'Hotel name',
        hintText: 'Hotel name',
        focusNode: mapFocusNode['hotelName'],
        prefixIcon: Icon(
          FontAwesomeIcons.userAlt,
          size: 14,
          color: Colors.black,
        ),
        textEditingController: controller.hotelNameController,
        onChanged: controller.onHotelNameChanged,
        isErrorVisible: !controller.isHotelNameValid.value,
        defaultValue: controller.hotelName.value,
        initialized: controller.hotelNameInitialized.value,
        onClearTextClicked: () => controller.onHotelNameChanged(''),
        errorText: controller.hotelNameErrorText.value,
        onSubmitted: () {
          mapFocusNode['hotelName']?.unfocus();
          FocusScope.of(Get.context!).requestFocus(mapFocusNode['noRoom']);
        },
      ),
    );
  }

  Widget _buildNoRoomInput() {
    return Obx(
      () => CustomBasicTextInput(
        textInputType: TextInputType.number,
        margin: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 5,
          right: 5,
        ),
        inputTitle: 'Number of room',
        hintText: 'Number of room',
        focusNode: mapFocusNode['noRoom'],
        prefixIcon: Icon(
          FontAwesomeIcons.userAlt,
          size: 14,
          color: Colors.black,
        ),
        textEditingController: controller.noRoomController,
        onChanged: controller.onNoRoomChanged,
        isErrorVisible: !controller.isNoRoomValid.value,
        defaultValue: controller.noRoom.value,
        initialized: controller.noRoomInitialized.value,
        onClearTextClicked: () => controller.onNoRoomChanged(''),
        errorText: controller.noRoomErrorText.value,
        onSubmitted: () {
          mapFocusNode['noRoom']?.unfocus();
          FocusScope.of(Get.context!).requestFocus(mapFocusNode['rentPrice']);
        },
      ),
    );
  }

  Widget _buildRentPriceInput() {
    return Obx(
      () => CustomBasicTextInput(
        textInputType: TextInputType.number,
        margin: EdgeInsets.only(
          left: 5,
          top: 10,
          right: 20,
          bottom: 5,
        ),
        inputTitle: 'Rent price',
        hintText: 'Rent price',
        focusNode: mapFocusNode['rentPrice'],
        prefixIcon: Icon(
          FontAwesomeIcons.userAlt,
          size: 14,
          color: Colors.black,
        ),
        textEditingController: controller.rentPriceController,
        onChanged: controller.onRentPriceChanged,
        isErrorVisible: !controller.isRentPriceValid.value,
        defaultValue: controller.rentPrice.value,
        initialized: controller.rentPriceInitialized.value,
        onClearTextClicked: () => controller.onRentPriceChanged(''),
        errorText: controller.rentPriceErrorText.value,
        onSubmitted: () {
          mapFocusNode['hotelName']?.unfocus();
          FocusScope.of(Get.context!).requestFocus(mapFocusNode['description']);
        },
      ),
    );
  }

  Widget _buildStreetInput() {
    return Obx(
      () => CustomBasicTextInput(
        inputTitle: 'Street',
        hintText: 'Street',
        focusNode: mapFocusNode['street'],
        prefixIcon: Icon(
          FontAwesomeIcons.userAlt,
          size: 14,
          color: Colors.black,
        ),
        textEditingController: controller.streetController,
        onChanged: controller.onStreetChanged,
        isErrorVisible: !controller.isStreetValid.value,
        defaultValue: controller.street.value,
        initialized: controller.streetInitialized.value,
        onClearTextClicked: () => controller.onStreetChanged(''),
        errorText: controller.streetErrorText.value,
        // onSubmitted: () {
        //   mapFocusNode['hotelName']?.unfocus();
        //   FocusScope.of(Get.context!).requestFocus(mapFocusNode['noRoom']);
        // },
      ),
    );
  }

  Widget _buildUploadImage() {
    return Container(
      height: 50.0,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            controller.choosePhotoDialog();
          },
          child: Container(
            child: Center(
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.images,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Upload image',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required Widget child,
    required String inputTitle,
    EdgeInsetsGeometry? margin,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 30.0),
          child: Text(
            inputTitle,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 50.0,
          width: Get.width,
          margin: margin ?? EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color: Colors.grey,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.only(left: 15),
            child: child,
          ),
        ),
      ],
    );
  }

  Widget _buildDropDownButtonCity() {
    return Obx(
      () => DropdownButton<int>(
        value: null,
        hint: Text(
          controller.cityName.isNotEmpty ? controller.cityName.value : 'Select city',
          style: TextStyle(color: Colors.black),
        ),
        underline: SizedBox(),
        iconSize: 0,
        onChanged: (index) {
          var city = controller.cityList.elementAt(index ?? 0);
          controller.cityName.value = city.name ?? '';
          controller.districtList.value = city.districts ?? [];
          controller.checkButtonValid();
        },
        items: List.generate(
          controller.cityList.length,
          (index) {
            var city = controller.cityList.elementAt(index);
            return DropdownMenuItem(
              child: Text(
                city.name ?? '',
                style: TextStyle(color: Colors.black),
              ),
              value: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropDownButtonDistrict() {
    return Obx(
      () => DropdownButton<int>(
        value: null,
        hint: Text(
          controller.districtName.isNotEmpty ? controller.districtName.value : 'Select district',
          style: TextStyle(color: Colors.black),
        ),
        underline: SizedBox(),
        iconSize: 0,
        onChanged: (index) {
          var district = controller.districtList.elementAt(index ?? 0);
          controller.districtName.value = district.name ?? '';
          controller.wardList.value = district.wards ?? [];
          controller.checkButtonValid();
        },
        items: List.generate(
          controller.districtList.length,
          (index) {
            var district = controller.districtList.elementAt(index);
            return DropdownMenuItem(
              child: Text(
                district.name ?? '',
                style: TextStyle(color: Colors.black),
              ),
              value: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropDownButtonWard() {
    return Obx(
      () => DropdownButton<int>(
        value: null,
        hint: Text(
          controller.wardName.isNotEmpty ? controller.wardName.value : 'Select ward',
          style: TextStyle(color: Colors.black),
        ),
        underline: SizedBox(),
        iconSize: 0,
        onChanged: (index) {
          var ward = controller.wardList.elementAt(index ?? 0);
          controller.wardName.value = ward.name ?? '';
          controller.checkButtonValid();
        },
        items: List.generate(
          controller.wardList.length,
          (index) {
            var ward = controller.wardList.elementAt(index);
            return DropdownMenuItem(
              child: Text(
                ward.name ?? '',
                style: TextStyle(color: Colors.black),
              ),
              value: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropDownButtonFurniture() {
    return Obx(
      () => DropdownButton<int>(
        value: null,
        hint: Text(
          controller.furnitureName.isNotEmpty ? controller.furnitureName.value : 'Select furniture',
          style: TextStyle(color: Colors.black),
        ),
        underline: SizedBox(),
        iconSize: 0,
        onChanged: (index) {
          var name = controller.furnitureList.elementAt(index ?? 0);
          controller.furnitureName.value = name;
          controller.checkButtonValid();
        },
        items: List.generate(
          controller.furnitureList.length,
          (index) {
            var name = controller.furnitureList.elementAt(index);
            return DropdownMenuItem(
              child: Text(
                name,
                style: TextStyle(color: Colors.black),
              ),
              value: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropDownButtonHouseType() {
    return Obx(
      () => DropdownButton<int>(
        value: null,
        hint: Text(
          controller.houseTypeName.isNotEmpty
              ? controller.houseTypeName.value
              : 'Select house type',
          style: TextStyle(color: Colors.black),
        ),
        underline: SizedBox(),
        iconSize: 0,
        onChanged: (index) {
          var name = controller.houseTypeList.elementAt(index ?? 0);
          controller.houseTypeName.value = name;
          controller.checkButtonValid();
        },
        items: List.generate(
          controller.houseTypeList.length,
          (index) {
            var name = controller.houseTypeList.elementAt(index);
            return DropdownMenuItem(
              child: Text(
                name,
                style: TextStyle(color: Colors.black),
              ),
              value: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return Obx(
      () => GridView.builder(
        itemCount: controller.amenityList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 1.0,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return _amenityCard(index);
        },
      ),
    );
  }

  Widget _amenityCard(int index) {
    return Obx(() {
      var amenity = controller.amenityList[index];
      return Container(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              controller.amenityList[index].isSelected =
                  !(controller.amenityList[index].isSelected ?? false);
              controller.amenityList.refresh();
              controller.checkButtonValid();
            },
            child: Container(
              decoration: BoxDecoration(
                color: amenity.isSelected ?? false ? CustomColors.green : CustomColors.greyF7,
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
            ),
          ),
        ),
      );
    });
  }
}
