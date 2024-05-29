import 'dart:io';

import 'package:bus_counter/common/layout/default_layout.dart';
import 'package:bus_counter/common/provider/running_list_provider.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:bus_counter/run/view_model/run_view_model.dart';
import 'package:bus_counter/run/components/empty_item.dart';
import 'package:bus_counter/run/components/running_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class RunScreen extends StatefulWidget {
  static String get routeName => 'counter';
  const RunScreen({super.key});

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  late RunViewModel viewModel;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    viewModel = RunViewModel(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RunViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return DefaultLayout(
          backgroundColor: GonStyle.white,
          resizeToAvoidBottomInset: false,
          child: SafeArea(
            top: true,
            right: false,
            child: Column(
              children: [
                _appBar(),
                Selector<RunningListProvider, List<RunBase>>(
                    selector: (_, prov) => prov.runningList,
                    builder: (context, list, _) {
                      return Expanded(
                        child: Padding(
                          padding: Platform.isIOS
                              ? EdgeInsets.fromLTRB(18, 12, 30, 18)
                              : EdgeInsets.fromLTRB(18, 12, 18, 18),
                          child: LayoutBuilder(
                            builder: (context, layout) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: list.mapIndexed((index, item) {
                                  return Selector<RunningListProvider, RunBase>(
                                      selector: (_, prov) =>
                                          (prov.runningList[index]),
                                      builder: (_, runBase, __) {
                                        return SizedBox(
                                          width: layout.maxWidth * .31,
                                          child: Builder(
                                            builder: (context) {
                                              if (runBase is RunModel) {
                                                return RunningItem(
                                                  run: runBase,
                                                  idx: index,
                                                );
                                              }
                                              return EmptyItem(
                                                onPressed:
                                                    viewModel.onClickEmptyUser,
                                              );
                                            },
                                          ),
                                        );
                                      });
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _appBar() {
    return Container(
      width: double.infinity,
      height: 62.toHeight,
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              '${tr('run_counter_title')}',
              style: GonStyle.custom(
                fontSize: 18,
                weight: FontWeight.w600,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CupertinoButton(
              onPressed: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: GonStyle.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
