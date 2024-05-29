import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/common/utils/logger.dart';
import 'package:bus_counter/game/components/game_tile.dart';
import 'package:bus_counter/game/model/game_model.dart';
import 'package:bus_counter/game/view_model/game_list_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/components/title_text_field/title_text_field.dart';
import '../../common/utils/gon_style.dart';

class GameListScreen extends StatefulWidget {
  static String get routeName => 'game_list';

  final Function(GameModel)? onItemPressed;
  const GameListScreen({
    super.key,
    this.onItemPressed,
  });

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  late GameListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = GameListViewModel(this);
    GonLog().i('function : ${widget.onItemPressed}');
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameListViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '${tr('game_list_title')}',
          onPressed: () => viewModel.searchController.unfocus(),
          actions: [_addButton()],
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: TitleTextField(
                  controller: viewModel.searchController,
                  hintText: '${tr('search_game_hint')}',
                  onChanged: viewModel.onChanged,
                  onSubmitted: (v) => viewModel.searchController.unfocus(),
                ),
              ),
              SizedBox(height: 22.toWidth),
              Expanded(
                child: Selector<GameListViewModel, List<GameModel>>(
                  selector: (_, prov) => prov.viewList,
                  builder: (context, customerList, _) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: customerList.length,
                      itemBuilder: (context, index) {
                        final customer = customerList[index];
                        return GameTile(
                          gameItem: customer,
                          onPressed: widget.onItemPressed,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _addButton() {
    return BaseButton(
      onPressed: () => viewModel.onClickAddButton(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Icon(
          Icons.add,
          color: GonStyle.subBlue,
          size: 28.toWidth,
        ),
      ),
    );
  }
}
