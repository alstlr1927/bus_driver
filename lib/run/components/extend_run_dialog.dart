import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/components/base_button/base_button.dart';
import '../../common/utils/gon_style.dart';

class ExtendRunDialog extends StatefulWidget {
  final Function(int) onExtend;
  const ExtendRunDialog({
    super.key,
    required this.onExtend,
  });

  @override
  State<ExtendRunDialog> createState() => _ExtendRunDialogState();
}

class _ExtendRunDialogState extends State<ExtendRunDialog> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300.toWidth,
        height: 190.toWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${tr('run_extend_count_title')}',
                    style: GonStyle.body1(
                      weight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.toWidth),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.trim().isEmpty) {
                            count = 0;
                          } else {
                            try {
                              count = int.parse(value.trim());
                            } catch (e) {
                              count = 0;
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: GonStyle.gray060,
            ),
            BaseButton(
              onPressed: () => widget.onExtend(count),
              child: Container(
                height: 50.toWidth,
                alignment: Alignment.center,
                child: Text(
                  '${tr('extend_btn_title')}',
                  style: GonStyle.body1(
                    weight: FontWeight.w600,
                    color: GonStyle.gray090,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
