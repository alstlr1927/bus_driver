import 'package:bus_counter/common/components/base_button/base_button.dart';
import 'package:bus_counter/common/components/dropdown/drop_down_button.dart';
import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/history/view/history_detail_screen.dart';
import 'package:bus_counter/history/view_model/history_view_model.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  static String get routeName => 'history';
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HistoryViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HistoryViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HistoryViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return Consumer<HistoryViewModel>(
          builder: (context, prov, _) {
            final historyList = viewModel.viewUserList;
            final filterType = viewModel.filterType;
            return DefaultLayout(
              title: '히스토리',
              actions: [_buildDropdown()],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: Column(
                  children: [
                    // SizedBox(height: 10.toWidth),
                    if (historyList.isNotEmpty)
                      Expanded(
                        child: LazyLoadScrollView(
                          onEndOfPage: () {
                            viewModel.getHistoryData(state: filterType.code);
                          },
                          child: ListView.builder(
                            itemCount: historyList.length,
                            itemBuilder: (context, index) {
                              final user = historyList[index];
                              return _RunListTile(runItem: user);
                            },
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              '데이터가 존재하지 않습니다.',
                              style: GonStyle.body1(
                                weight: FontWeight.w500,
                                color: GonStyle.gray080,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDropdown() {
    return Builder(
      builder: (context) {
        HistoryViewModel viewModel =
            Provider.of<HistoryViewModel>(context, listen: false);
        return GonDropdown(
          itemList: FilterType.values.map((e) => e.kr).toList(),
          onSelectItem: viewModel.setFilter,
        );
      },
    );
  }
}

class _RunListTile extends StatelessWidget {
  final RunModel runItem;
  const _RunListTile({
    Key? key,
    required this.runItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: () {
        context.pushNamed(
          HistoryDetailScreen.routeName,
          extra: runItem,
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.toWidth),
        padding:
            EdgeInsets.symmetric(horizontal: 20.toWidth, vertical: 16.toWidth),
        decoration: BoxDecoration(
          color: GonStyle.white,
          boxShadow: GonStyle.elevation_04dp(),
          borderRadius: BorderRadius.circular(8),
        ),
        // height: 20,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${runItem.nickname}',
                      style: GonStyle.body2(weight: FontWeight.w600),
                    ),
                    SizedBox(height: 4.toWidth),
                    Text(
                      '${runItem.completedCount} / ${runItem.totalCount}',
                      style: GonStyle.caption(),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (runItem.completedAt != null)
                      dateWidget(runItem.completedAt!),
                    SizedBox(height: 4.toWidth),
                    getStatus(runItem.runState),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dateWidget(DateTime dt) {
    String dtFormat = 'HH : mm';
    DateTime nowDt = DateTime.now();

    int nowDtNum = int.parse(DateFormat('yyMMdd').format(nowDt));
    int comDtNum = int.parse(DateFormat('yyMMdd').format(dt));

    if (nowDtNum != comDtNum) {
      dtFormat = 'yy.MM.dd';
    }
    return Text(
      '${DateFormat(dtFormat).format(runItem.completedAt!)}',
      textAlign: TextAlign.end,
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
}
