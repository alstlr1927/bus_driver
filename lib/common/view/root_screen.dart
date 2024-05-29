import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/provider/profile_provider.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/common/utils/images.dart';
import 'package:bus_counter/common/view_model.dart/root_view_model.dart';
import 'package:bus_counter/manager/view/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  static String get routeName => 'root';
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late RootViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = RootViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RootViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '${tr('app_ko_title')}',
          actions: [
            _profileWidget(),
          ],
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
              child: Column(
                children: [
                  SizedBox(height: 16.toWidth),
                  Container(
                    height: 450.toWidth,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const _CustomerWidget(),
                              SizedBox(height: 12.toWidth),
                              const _HistoryWidget(),
                              SizedBox(height: 12.toWidth),
                              const _SettingWidget(),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.toWidth),
                        const _CounterWidget(),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.toWidth),
                  const _GameListWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _profileWidget() {
    return Consumer<ProfileProvider>(
      builder: (context, prov, _) {
        final user = prov.manager;
        return BaseButton(
          onPressed: () {
            context.pushNamed(ProfileScreen.routeName);
          },
          child: Container(
            margin: EdgeInsets.only(right: 24.toWidth),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: user.profileImageUrl.isEmpty
                  ? Image.asset(
                      defaultProfile,
                      fit: BoxFit.cover,
                      width: 24.toWidth,
                      height: 24.toWidth,
                    )
                  : Image.network(
                      user.profileImageUrl,
                      fit: BoxFit.cover,
                      width: 24.toWidth,
                      height: 24.toWidth,
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _GameListWidget extends StatelessWidget {
  const _GameListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RootViewModel viewModel =
        Provider.of<RootViewModel>(context, listen: false);
    return BaseButton(
      onPressed: () => viewModel.onClickGameListButton(),
      child: Container(
        width: double.infinity,
        height: 140.toWidth,
        decoration: BoxDecoration(
          color: GonStyle.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: GonStyle.elevation_04dp(),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                  child: Image.asset(
                    gameListIcon,
                    height: 130.toWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.toWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tr('game_list_btn_title')}',
                    style: GonStyle.h4(
                      weight: FontWeight.bold,
                      color: GonStyle.gray090,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterWidget extends StatelessWidget {
  const _CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RootViewModel viewModel =
        Provider.of<RootViewModel>(context, listen: false);
    return Expanded(
      child: BaseButton(
        onPressed: () => viewModel.onClickCounterButton(),
        child: Container(
          decoration: BoxDecoration(
            color: GonStyle.subYellow24,
            borderRadius: BorderRadius.circular(8),
            boxShadow: GonStyle.elevation_04dp(),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.toWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${tr('counter_btn_title')}',
                  style: GonStyle.h4(
                    weight: FontWeight.bold,
                    color: GonStyle.gray090,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  counterIcon,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomerWidget extends StatelessWidget {
  const _CustomerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RootViewModel viewModel =
        Provider.of<RootViewModel>(context, listen: false);
    return Expanded(
      child: BaseButton(
        onPressed: () => viewModel.onClickCustomerButton(),
        child: Container(
          decoration: BoxDecoration(
            color: GonStyle.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: GonStyle.elevation_04dp(),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    customerIcon,
                    height: 90.toWidth,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.toWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tr('customer_btn_title')}',
                      style: GonStyle.h4(
                        weight: FontWeight.bold,
                        color: GonStyle.gray090,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryWidget extends StatelessWidget {
  const _HistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RootViewModel viewModel =
        Provider.of<RootViewModel>(context, listen: false);
    return Expanded(
      child: BaseButton(
        onPressed: () => viewModel.onClickHistoryButton(),
        child: Container(
          decoration: BoxDecoration(
            color: GonStyle.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: GonStyle.elevation_04dp(),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    historyIcon,
                    height: 90.toWidth,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.toWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tr('history_btn_title')}',
                      style: GonStyle.h4(
                        weight: FontWeight.bold,
                        color: GonStyle.gray090,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingWidget extends StatelessWidget {
  const _SettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RootViewModel viewModel =
        Provider.of<RootViewModel>(context, listen: false);
    return Expanded(
      child: BaseButton(
        onPressed: () => viewModel.onClickSettingButton(),
        child: Container(
          decoration: BoxDecoration(
            color: GonStyle.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: GonStyle.elevation_04dp(),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    settingIcon,
                    height: 90.toWidth,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.toWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tr('setting_btn_title')}',
                      style: GonStyle.h4(
                        weight: FontWeight.bold,
                        color: GonStyle.gray090,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
