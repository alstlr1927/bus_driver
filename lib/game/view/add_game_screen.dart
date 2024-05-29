import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/game/view_model/add_game_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/components/custom_button/custom_button.dart';
import '../../common/components/title_text_field/title_text_field.dart';
import '../../common/utils/gon_style.dart';

class AddGameScreen extends StatefulWidget {
  static String get routeName => 'add_game';
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  late AddGameViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = AddGameViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddGameViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '${tr('add_game_title')}',
          onPressed: () => viewModel.nameController.unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Column(
              children: [
                SizedBox(height: 30.toWidth),
                TitleTextField(
                  title: '${tr('input_game_name_title')}',
                  hintText: '${tr('input_game_name_title')}',
                  controller: viewModel.nameController,
                  onChanged: viewModel.onChanged,
                  onSubmitted: (val) => viewModel.nameController.unfocus(),
                ),
                const Spacer(),
                Selector<AddGameViewModel, String>(
                    selector: (_, prov) => prov.gameName,
                    builder: (_, gameName, __) {
                      final isReady = gameName.trim().length > 1;
                      return GonButton(
                        onPressed:
                            isReady ? viewModel.onClickRegistGameButton : null,
                        option: GonButtonOption.fill(
                          text: '${tr('regist_btn_title')}',
                          theme: GonButtonFillTheme.lightMagenta,
                          style: GonButtonFillStyle.fullRegular,
                        ),
                      );
                    }),
                SizedBox(
                  height: GonStyle.defaultBottomPadding() + 14.toWidth,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
