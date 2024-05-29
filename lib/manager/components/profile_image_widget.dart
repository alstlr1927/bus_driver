import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/common/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/provider/profile_provider.dart';

class ProfileImageWrapper extends StatelessWidget {
  final VoidCallback? onPressed;
  const ProfileImageWrapper({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ProfileProvider, String>(
      selector: (_, prov) => prov.profileImage,
      builder: (_, imageUrl, __) {
        if (imageUrl.isEmpty) {
          return BaseButton(
            onPressed: onPressed,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.asset(
                defaultProfile,
                width: 150.toWidth,
                height: 150.toWidth,
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        return BaseButton(
          onPressed: onPressed,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(
              imageUrl,
              width: 150.toWidth,
              height: 150.toWidth,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
