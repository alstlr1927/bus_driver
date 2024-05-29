import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../common/components/custom_button/custom_button.dart';
import '../components/profile_image_widget.dart';

class ProfileEditScreen extends StatelessWidget {
  static String get routeName => 'profile_edit';
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '${tr('edit_profile_title')}',
      actions: [_buildEditButton()],
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _EmptySpace(height: 30.toWidth),
            ProfileImageWrapper(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return GonButton(
      onPressed: () {
        //
      },
      option: GonButtonOption.text(
        text: '${tr('save_btn_title')}',
        theme: GonButtonTextTheme.subBlue,
        style: GonButtonTextStyle.regular,
      ),
    );
  }
}

class _EmptySpace extends StatelessWidget {
  final double height;
  const _EmptySpace({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
