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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80.0,
              width: 150.0,
              margin: EdgeInsets.only(top: 15.0),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: onUpload,
                  child: _buildItemImagePicker(
                    icon: FontAwesomeIcons.fileUpload,
                    // Assets.icons.icUploadPhoto,
                    title: 'Chọn ảnh từ thiết bị',
                  ),
                ),
              ),
            ),
            Container(
              height: 80.0,
              width: 150.0,
              margin: EdgeInsets.only(top: 15.0),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: onTakePhoto,
                  child: _buildItemImagePicker(
                    icon: Icons.camera_alt_outlined,
                    title: 'Chụp ảnh mới',
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
}