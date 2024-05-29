import 'package:bus_counter/common/components/custom_button/custom_button.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/provider/profile_provider.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/manager/view/profile_edit_screen.dart';
import 'package:bus_counter/manager/view_model/profile_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/profile_image_widget.dart';

class ProfileScreen extends StatefulWidget {
  static String get routeName => 'profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          title: '${tr('profile_title')}',
          actions: [_buildEditButton()],
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _EmptySpace(height: 30.toWidth),
                const ProfileImageWrapper(),
                _EmptySpace(height: 20.toWidth),
                const _ProfileInfoWrapper(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditButton() {
    return GonButton(
      onPressed: () {
        context.pushNamed(ProfileEditScreen.routeName);
      },
      option: GonButtonOption.text(
        text: '${tr('edit_profile_btn_title')}',
        theme: GonButtonTextTheme.subBlue,
        style: GonButtonTextStyle.regular,
      ),
    );
  }
}

class _ProfileInfoWrapper extends StatelessWidget {
  const _ProfileInfoWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<ProfileProvider, String>(
          selector: (_, prov) => prov.nickname,
          builder: (_, name, __) {
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.toWidth, vertical: 6.toWidth),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: GonStyle.gray060)),
              ),
              child: Text(
                '$name',
                style: GonStyle.body1(
                  weight: FontWeight.w600,
                  color: GonStyle.gray080,
                ),
              ),
            );
          },
        ),
      ],
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
