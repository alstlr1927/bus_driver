import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/components/custom_dialog/gon_dialog_land.dart';

class ProfileViewModel extends ChangeNotifier {
  State state;

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ProfileViewModel(this.state) {
    //
  }

  Future<void> _alertDialog({
    required String title,
    VoidCallback? confirm,
  }) async {
    await showDialog(
      context: state.context,
      builder: (context) {
        return GonDialogLand(
          title: '${tr('app_ko_title')}',
          content: '$title',
          itemList: [
            GonDialogBtnItem(
              title: '${tr('confirm_btn_title')}',
              onPressed: () {
                confirm?.call();
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
