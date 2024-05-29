import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/components/custom_button/custom_button.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/customer/model/customer_model.dart';
import 'package:bus_counter/customer/view/customer_list_screen.dart';
import 'package:bus_counter/game/view/game_list_screen.dart';
import 'package:bus_counter/run/view_model/add_run_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../common/utils/validator.dart';
import '../../game/model/game_model.dart';

class AddRunScreen extends StatefulWidget {
  static String get routeName => 'add_user';

  const AddRunScreen({super.key});

  @override
  State<AddRunScreen> createState() => _AddRunScreenState();
}

class _AddRunScreenState extends State<AddRunScreen> {
  late AddRunViewModel viewModel;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    viewModel = AddRunViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddRunViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          onPressed: () => viewModel.focusoutAll(),
          title: '${tr('add_run_title')}',
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.toWidth),
                        Selector<AddRunViewModel, CustomerModel?>(
                          selector: (_, prov) => prov.customer,
                          builder: (_, customer, __) {
                            bool isSelected = customer != null;
                            return BaseButton(
                              onPressed: () {
                                context.pushNamed(
                                  CustomerListScreen.routeName,
                                  extra: (CustomerModel customer) {
                                    viewModel.setCustomer(customer);
                                    context.pop();
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50.toWidth,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: GonStyle.elevation_03dp(),
                                ),
                                child: Text(
                                  isSelected
                                      ? '${customer.nickname}'
                                      : '${tr('select_customer_btn_title')}',
                                  style: GonStyle.body2(
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 22.toWidth),
                        Selector<AddRunViewModel, GameModel?>(
                          selector: (_, prov) => prov.game,
                          builder: (_, game, __) {
                            bool isSelected = game != null;
                            return BaseButton(
                              onPressed: () {
                                context.pushNamed(GameListScreen.routeName,
                                    extra: (GameModel game) {
                                  viewModel.setGame(game);
                                  context.pop();
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50.toWidth,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: GonStyle.elevation_03dp(),
                                ),
                                child: Text(
                                  isSelected
                                      ? '${game.name}'
                                      : '${tr('select_game_btn_title')}',
                                  style: GonStyle.body2(
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30.toWidth),
                        Row(
                          children: [
                            _cntButton(
                              title: '-1',
                              onPressed: () => viewModel.setCount(-1),
                            ),
                            SizedBox(width: 6.toWidth),
                            _cntButton(
                              title: '-5',
                              onPressed: () => viewModel.setCount(-5),
                            ),
                            SizedBox(width: 20.toWidth),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: .6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextField(
                                  controller: viewModel.cntController,
                                  focusNode: viewModel.cntNode,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                      Validator().kWhiteSpaceRegex,
                                    ),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onChanged: viewModel.onChanged,
                                  enabled: false,
                                ),
                              ),
                            ),
                            SizedBox(width: 20.toWidth),
                            _cntButton(
                              title: '+1',
                              onPressed: () => viewModel.setCount(1),
                            ),
                            SizedBox(width: 6.toWidth),
                            _cntButton(
                              title: '+5',
                              onPressed: () => viewModel.setCount(5),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Selector<AddRunViewModel,
                            Tuple3<CustomerModel?, GameModel?, int>>(
                          selector: (_, prov) =>
                              Tuple3(prov.customer, prov.game, prov.count),
                          builder: (context, item, _) {
                            final CustomerModel? customer = item.item1;
                            final GameModel? game = item.item2;
                            final int count = item.item3;
                            bool isValid =
                                customer != null && count > 0 && game != null;
                            return GonButton(
                              onPressed:
                                  isValid ? viewModel.onClickRegistBtn : null,
                              option: GonButtonOption.fill(
                                text: '${tr('regist_btn_title')}',
                                theme: GonButtonFillTheme.magenta,
                                style: GonButtonFillStyle.fullRegular,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 22.toWidth),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _cntButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return BaseButton(
      onPressed: onPressed,
      child: Container(
        width: 54.toWidth,
        height: 36.toWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: GonStyle.primary050,
        ),
        child: Text(
          title,
          style: GonStyle.body2(
            color: Colors.white,
            weight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
