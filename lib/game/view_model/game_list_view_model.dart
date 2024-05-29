import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/game/repository/game_repository.dart';
import 'package:bus_counter/game/view/add_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/components/title_text_field/field_controller.dart';
import '../model/game_model.dart';

class GameListViewModel extends ChangeNotifier {
  State state;

  FieldController searchController = FieldController();

  List<GameModel> viewList = [];

  List<GameModel> gameList = [];

  Future<void> onClickAddButton() async {
    await state.context.pushNamed(AddGameScreen.routeName);
    getGameList();
  }

  Future<void> getGameList() async {
    var res = await GameRepository().getGameList();

    try {
      List<GameModel> temp = res.map((e) => GameModel.fromJson(e)).toList();
      gameList = [...temp];
      viewList = [...temp];
      notifyListeners();
    } catch (e, trace) {
      GonLog().e('getGameList error : $e');
      GonLog().e('$trace');
    }
  }

  void onChanged(String val) {
    if (val.trim().isEmpty) {
      viewList = [...gameList];
      notifyListeners();
    } else {
      List<GameModel> temp = gameList
          .where((e) => e.name.toLowerCase().contains(val.trim().toLowerCase()))
          .toList();
      viewList = [...temp];
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  GameListViewModel(this.state) {
    getGameList();
  }
}
