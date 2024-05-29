import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:flutter/material.dart';

import '../../common/utils/gon_style.dart';

class EmptyItem extends StatelessWidget {
  final VoidCallback? onPressed;
  const EmptyItem({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: GonStyle.gray020,
          boxShadow: GonStyle.elevation_06dp(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.person_add_rounded,
          size: 80.toHeight,
          color: GonStyle.english,
        ),
      ),
    );
  }
}
