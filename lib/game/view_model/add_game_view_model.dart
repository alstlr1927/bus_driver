import 'package:bus_counter/common/components/title_text_field/field_controller.dart';
import 'package:bus_counter/game/repository/game_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/components/custom_dialog/gon_dialog_land.dart';

class AddGameViewModel extends ChangeNotifier {
  State state;

  FieldController nameController = FieldController();
  String gameName = '';

  bool isLoad = false;

  void onChanged(String val) {
    gameName = val.trim();
    notifyListeners();
  }

  Future<void> onClickRegistGameButton() async {
    bool isValid =
        await GameRepository().checkDuplicateGameName(name: gameName);
    if (!isValid) {
      _alertDialog(
        title: '${tr('duplicated_game_name_title')}',
        confirm: () => state.context.pop(),
      );
      return;
    }

    if (isLoad) return;
    isLoad = true;

    await GameRepository().createGame(name: gameName);

    isLoad = false;
    state.context.pop();
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  AddGameViewModel(this.state);

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
              },
            ),
          ],
        );
      },
    );
  }
}
