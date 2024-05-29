import 'package:bus_counter/common/utils/Gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:flutter/material.dart';

import '../base_button/base_button.dart';

class GonDialog extends StatefulWidget {
  final String title;
  final String content;
  final List<GonDialogBtnItem> itemList;
  const GonDialog({
    super.key,
    this.title = '',
    this.content = '',
    required this.itemList,
  });

  @override
  State<GonDialog> createState() => _GonDialogState();
}

class _GonDialogState extends State<GonDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        height: widget.itemList.isEmpty ? 150.toWidth : 190.toWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.toWidth),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.title.isNotEmpty) ...{
                      Text(
                        '${widget.title}',
                        style: GonStyle.body1(
                          color: GonStyle.primary050,
                          weight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.toWidth),
                    },
                    if (widget.content.isNotEmpty)
                      Text(
                        '${widget.content}',
                        style: GonStyle.body2(
                          color: GonStyle.gray090,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
            if (widget.itemList.isNotEmpty) ...{
              Divider(
                height: 1,
                color: GonStyle.gray060,
              ),
              Row(
                children: widget.itemList
                    .map((item) {
                      return Container(child: item);
                    })
                    .superJoin(Container(
                      color: GonStyle.gray060,
                      width: 1,
                      height: 50.toWidth,
                    ))
                    .toList(),
              ),
            },
          ],
        ),
      ),
    );
  }
}

class GonDialogBtnItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const GonDialogBtnItem({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: BaseButton(
        onPressed: onPressed,
        child: Container(
          height: 50.toWidth,
          alignment: Alignment.center,
          child: Text(
            title,
            style: GonStyle.body2(
              color: GonStyle.gray090,
            ),
          ),
        ),
      ),
    );
  }
}
