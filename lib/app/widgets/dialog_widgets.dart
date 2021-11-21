import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentalz_gcs18830_flutter/utils/custom_colors.dart';

class DialogWidgets {
  Widget imagePickerDialog({
    required VoidCallback onUpload,
    required VoidCallback onTakePhoto,
  }) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100.0,
              width: 50.0,
              margin: EdgeInsets.only(top: 15.0),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: onUpload,
                  child: Center(
                    child: _buildItemImagePicker(
                      icon: FontAwesomeIcons.fileUpload,
                      // Assets.icons.icUploadPhoto,
                      title: 'Gallery',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 100.0,
              width: 50.0,
              margin: EdgeInsets.only(top: 15.0),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: onTakePhoto,
                  child: Center(
                    child: _buildItemImagePicker(
                      icon: Icons.camera_alt_outlined,
                      title: 'Device',
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

  Widget _buildItemImagePicker({
    required IconData icon,
    required String title,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: CustomColors.blue,
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget buildConfirmDialog({
    required String title,
    required String description,
    required VoidCallback onNegativeClick,
    required VoidCallback onPositiveClick,
  }) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 30,
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: CustomColors.grey,
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: onNegativeClick,
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: onPositiveClick,
                        child: Center(
                          child: Text(
                            'Ok',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
