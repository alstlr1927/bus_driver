import 'package:bus_counter/common/provider/running_list_provider.dart';
import 'package:bus_counter/common/repository/gon_repository.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/customer/repository/customer_repository.dart';
import 'package:bus_counter/run/components/extend_run_dialog.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:bus_counter/run/view_model/run_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/components/base_button/base_button.dart';
import '../../common/components/custom_dialog/gon_dialog_land.dart';
import '../../common/utils/gon_style.dart';

class RunningItem extends StatefulWidget {
  final RunModel run;
  final int idx;
  const RunningItem({
    super.key,
    required this.run,
    required this.idx,
  });

  @override
  State<RunningItem> createState() => _RunningItemState();
}

class _RunningItemState extends State<RunningItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RunViewModel>(context, listen: false);
    final runningItem = widget.run;

    if (runningItem.remainingCount == 0) {
      return _completeWidget();
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: GonStyle.white,
        boxShadow: GonStyle.elevation_06dp(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.toWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '[ ${runningItem.nickname} ]',
                  style: GonStyle.custom(
                    fontSize: 18,
                    weight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                _countText(
                  title: '${tr('remaining_count_title')}',
                  count: runningItem.remainingCount,
                ),
                SizedBox(height: 6),
                _countText(
                  title: '${tr('completed_count_title')}',
                  count: runningItem.completedCount,
                ),
                SizedBox(height: 6),
                _countText(
                  title: '${tr('total_count_title')}',
                  count: runningItem.totalCount,
                ),
                Spacer(),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: BaseButton(
                        onPressed: () async {
                          await showExtendDialog(
                            extendCount: (int count) {
                              viewModel.extendRunCount(
                                item: widget.run,
                                count: count,
                                idx: widget.idx,
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: GonStyle.white,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${tr('extend_btn_title')}',
                            style: GonStyle.custom(
                                fontSize: 14,
                                color: Colors.black,
                                weight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: BaseButton(
                        onPressed: () {
                          viewModel.onClickCountButton(
                            item: runningItem,
                            idx: widget.idx,
                          );
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: GonStyle.black,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${tr('count_title')}',
                            style: GonStyle.custom(
                                fontSize: 14,
                                color: Colors.white,
                                weight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: CupertinoButton(
              onPressed: () {
                _alertDialog(
                  title: '${tr('check_delete_button_title')}',
                  confirm: () async {
                    await GonRepository().setDeleteRun(runId: runningItem.id);
                    Provider.of<RunningListProvider>(context, listen: false)
                        .getRunningList();
                  },
                );
              },
              child: Icon(
                Icons.delete_rounded,
                color: GonStyle.primary050,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _countText({
    required String title,
    required int count,
  }) {
    return SizedBox(
      width: 140,
      child: Row(
        children: [
          Text(
            '$title :',
            style: GonStyle.custom(
              fontSize: 16,
              weight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            '$count',
            style: GonStyle.custom(
              fontSize: 16,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _completeWidget() {
    return Builder(
      builder: (context) {
        final viewModel = Provider.of<RunViewModel>(context, listen: false);
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: GonStyle.black,
            boxShadow: GonStyle.elevation_06dp(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton(
                onPressed: () {
                  _alertDialog(
                    title: '${tr('check_complete_button_title')}',
                    confirm: () async {
                      await GonRepository()
                          .setCompleteRun(runId: widget.run.id);
                      CustomerRepository().setCustomerRunCount(
                        customerUid: widget.run.customerUid,
                        totalCount: widget.run.totalCount,
                      );
                      Provider.of<RunningListProvider>(context, listen: false)
                          .getRunningList();
                    },
                  );
                },
                child: Container(
                  width: 120,
                  height: 46,
                  decoration: BoxDecoration(
                    color: GonStyle.primary050,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${tr('completed_btn_title')}',
                    style: GonStyle.custom(
                        fontSize: 16,
                        color: Colors.white,
                        weight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 22),
              BaseButton(
                onPressed: () async {
                  await showExtendDialog(
                    extendCount: (int count) {
                      viewModel.extendRunCount(
                        item: widget.run,
                        count: count,
                        idx: widget.idx,
                      );
                    },
                  );
                },
                child: Container(
                  width: 120,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${tr('extend_btn_title')}',
                    style: GonStyle.custom(
                        fontSize: 16,
                        color: Colors.black,
                        weight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _alertDialog({
    required String title,
    required VoidCallback confirm,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return GonDialogLand(
          title: '${tr('app_ko_title')}',
          content: '$title',
          itemList: [
            GonDialogBtnItem(
              title: '${tr('confirm_btn_title')}',
              onPressed: () {
                confirm.call();
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showExtendDialog({
    required Function(int) extendCount,
  }) async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.95),
      builder: (context) {
        return ExtendRunDialog(
          onExtend: (int count) {
            if (count < 1) return;
            _alertDialog(
              title: '${tr(
                'check_extend_content',
                namedArgs: {'count': '$count'},
              )}',
              confirm: () {
                extendCount.call(count);
                context.pop();
              },
            );
          },
        );
      },
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
