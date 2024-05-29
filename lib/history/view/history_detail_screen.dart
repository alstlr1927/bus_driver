import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../common/utils/gon_style.dart';

class HistoryDetailScreen extends StatelessWidget {
  static String get routeName => 'history_detail';

  final RunModel runItem;
  const HistoryDetailScreen({
    super.key,
    required this.runItem,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '상세 히스토리',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.toWidth),
        child: Column(
          children: [
            SizedBox(height: 30.toWidth),
            _buildTextWidget(
              title: '${tr('nickname_title')}',
              content: '${runItem.nickname}',
            ),
            SizedBox(height: 14.toWidth),
            _buildTextWidget(
              title: '${tr('game_name_title')}',
              content: '${runItem.gameName}',
            ),
            SizedBox(height: 14.toWidth),
            _buildStateWidget(
              title: '${tr('run_state_title')}',
              code: '${runItem.runState}',
            ),
            SizedBox(height: 14.toWidth),
            _buildTextWidget(
              title: '${tr('run_count_title')}',
              content: '${runItem.completedCount}',
            ),
            SizedBox(height: 14.toWidth),
            _buildTextWidget(
              title: '${tr('total_count_title')}',
              content: '${runItem.totalCount}',
            ),
            SizedBox(height: 14.toWidth),
            _buildTextWidget(
              title: '${tr('regist_date_title')}',
              content: '${getDateTimeToString(runItem.createdAt)}',
            ),
            SizedBox(height: 14.toWidth),
            if (runItem.completedAt != null)
              _buildTextWidget(
                title: '${tr('completed_date_title')}',
                content: '${getDateTimeToString(runItem.completedAt!)}',
              ),
            if (runItem.deletedAt != null)
              _buildTextWidget(
                title: '${tr('deleted_date_title')}',
                content: '${getDateTimeToString(runItem.deletedAt!)}',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextWidget({
    required String title,
    required String content,
  }) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 16.toWidth, vertical: 12.toWidth),
      decoration: BoxDecoration(
        color: GonStyle.white,
        boxShadow: GonStyle.elevation_01dp(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            '$title :',
            style: GonStyle.body2(
              weight: FontWeight.w600,
              color: GonStyle.gray070,
            ),
          ),
          Spacer(),
          Text(
            '$content',
            style: GonStyle.body2(
              weight: FontWeight.w600,
              color: GonStyle.gray070,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateWidget({
    required String title,
    required String code,
  }) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 16.toWidth, vertical: 12.toWidth),
      decoration: BoxDecoration(
        color: GonStyle.white,
        boxShadow: GonStyle.elevation_01dp(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            '$title :',
            style: GonStyle.body2(
              weight: FontWeight.w600,
              color: GonStyle.gray070,
            ),
          ),
          Spacer(),
          getStatus(code),
        ],
      ),
    );
  }

  Text getStatus(String code) {
    switch (code) {
      case 'C':
        return Text(
          '${tr('completed_state')}',
          style: GonStyle.body2(
            weight: FontWeight.w600,
            color: GonStyle.subBlue,
          ),
        );
      case 'D':
        return Text(
          '${tr('deleted_state')}',
          style: GonStyle.body2(
            weight: FontWeight.w600,
            color: GonStyle.primary050,
          ),
        );
      case 'R':
        return Text(
          '${tr('running_state')}',
          style: GonStyle.body2(
            weight: FontWeight.w600,
            color: GonStyle.subGreen,
          ),
        );
      default:
        return Text('');
    }
  }

  String getDateTimeToString(DateTime dt) {
    String dtStr = DateFormat('yyyy.MM.dd').format(dt);
    return dtStr;
  }
}
