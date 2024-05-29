import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/game/model/game_model.dart';
import 'package:flutter/material.dart';

import '../../common/utils/gon_style.dart';

class GameTile extends StatelessWidget {
  final GameModel gameItem;
  final Function(GameModel)? onPressed;
  const GameTile({
    super.key,
    required this.gameItem,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: () {
        onPressed?.call(gameItem);
      },
      child: Container(
        width: double.infinity,
        margin:
            EdgeInsets.symmetric(vertical: 10.toWidth, horizontal: 16.toWidth),
        padding:
            EdgeInsets.symmetric(horizontal: 20.toWidth, vertical: 16.toWidth),
        decoration: BoxDecoration(
          color: GonStyle.white,
          boxShadow: GonStyle.elevation_04dp(),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          '${gameItem.name}',
          style: GonStyle.body2(
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
