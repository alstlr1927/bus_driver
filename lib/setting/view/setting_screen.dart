import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/setting/components/setting_row_widget.dart';
import 'package:bus_counter/setting/view_model/setting_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static String get routeName => 'setting';
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late SettingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SettingViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '${tr('setting_title')}',
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.toWidth),
                _buildVersionWidget(),
                SizedBox(height: 20.toWidth),
                SettingRowWidget(
                  leading: '${tr('add_game_title')}',
                  onTap: () {},
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVersionWidget() {
    return Selector<SettingViewModel, String>(
      selector: (_, prov) => prov.version,
      builder: (_, version, __) {
        return Container(
          height: 48.toWidth,
          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
          child: Row(
            children: [
              Text(
                tr("current_version_title"),
                style: GonStyle.caption(
                  color: GonStyle.gray070,
                ),
              ),
              const Spacer(),
              Text(
                'v ${version}',
                style: GonStyle.caption(weight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingMenuTitle extends StatelessWidget {
  final String text;
  const _SettingMenuTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
      height: 24,
      child: Text(
        text,
        style: GonStyle.body2(
          color: GonStyle.gray070,
        ),
      ),
    );
  }
}
