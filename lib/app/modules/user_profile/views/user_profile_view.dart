import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';
import 'package:rentalz_gcs18830_flutter/gen/assets.gen.dart';
import 'package:rentalz_gcs18830_flutter/utils/custom_colors.dart';
import 'package:tuple/tuple.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  final List<Tuple3> listFunctions = [
    Tuple3(
      'Ring bell',
      FontAwesomeIcons.bell,
          () {
            FlutterRingtonePlayer.playNotification();
      },
    ),
    Tuple3(
      'Vibration device',
      FontAwesomeIcons.phone,
          () {
            Vibrate.vibrate();

            final Iterable<Duration> pauses = [
              const Duration(milliseconds: 500),
              const Duration(milliseconds: 500),
            ];
            Vibrate.vibrateWithPauses(pauses);
      },
    ),
    Tuple3(
      'Add hotel',
      FontAwesomeIcons.building,
      () {
        Get.toNamed(Routes.ADD_HOTEL);
      },
    ),
    Tuple3(
      'Reports',
      FontAwesomeIcons.city,
          () {
        Get.toNamed(Routes.REPORT_LIST);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width,
                  height: 100.0,
                ),
                _buildAvatar(context),
                _buildUserName(),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: listFunctions.map((e) {
                      return _buildActionItem(e.item1, e.item2, e.item3);
                    }).toList(),
                  ),
                ),
                _buildLogOut(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final imageSize = 175.0;
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(imageSize / 2),
        border: Border.all(color: Colors.white, width: 2.0),
        color: Colors.blue,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        ///Use stack here for ripple effect when clicking on image
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(imageSize / 2),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Assets.images.imgAvatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: CustomColors.blue.withOpacity(0.2),
                onTap: () {},
                borderRadius: BorderRadius.circular(imageSize / 2),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserName() {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: Text(
        '${controller.userModel?.fullName}',
        style: TextStyle(fontSize: 32),
      ),
    );
  }

  Widget _buildActionItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                  size: 26,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogOut() {
    return Container(
      margin: EdgeInsets.only(top: 80.0, bottom: 75.0),
      child: Center(
        child: InkWell(
          onTap: () {
            controller.onUserLogout();
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Wrap(
              children: [
                Icon(
                  Icons.send_to_mobile_outlined,
                  size: 28,
                ),
                SizedBox(width: 10.0),
                Text(
                  'Log out',
                  style: TextStyle(fontSize: 22),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
