import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../utils/gon_style.dart';
import '../../utils/logger.dart';

class GonDropdown extends StatefulWidget {
  final List<String> itemList;
  final Function(int) onSelectItem;

  const GonDropdown({
    Key? key,
    required this.itemList,
    required this.onSelectItem,
  }) : super(key: key);

  @override
  State<GonDropdown> createState() => _GonDropdownWidget();
}

class _GonDropdownWidget extends State<GonDropdown> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 42,
      child: Builder(
        builder: (context) {
          return DropdownButton2(
            value: widget.itemList[selectedIndex],
            customButton: Container(
              padding: EdgeInsets.only(left: 8.toWidth),
              // color: Colors.amber,
              width: 120.toWidth,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.itemList[selectedIndex],
                    style: GonStyle.body2(
                      color: Colors.black,
                      weight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 6.toWidth),
                  ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.black, BlendMode.srcATop),
                    child: Image.asset(
                      "assets/icons/arrowup.png",
                      width: 11.toWidth,
                      height: 11.toWidth,
                    ),
                  ),
                  SizedBox(width: 16.toWidth),
                ],
              ),
            ),
            onChanged: (newValue) {
              GonLog().i('newValue : $newValue');
              if (newValue == null) {
                return;
              }
              setState(() {
                int findIndex = 0;
                for (var item in widget.itemList) {
                  if (item == newValue) {
                    selectedIndex = findIndex;
                    break;
                  }
                  findIndex += 1;
                }
                widget.onSelectItem(findIndex);
              });
            },
            items: widget.itemList.map((String item) {
              return DropdownMenuItem<String>(
                  value: item,
                  child: SizedBox(
                    height: 24,
                    child: Center(
                        child: Text(
                      item,
                      style: GonStyle.body2(
                        color: Colors.black,
                        weight: FontWeight.w600,
                      ),
                    )),
                  ));
            }).toList(),
            buttonStyleData: ButtonStyleData(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            dropdownStyleData: DropdownStyleData(
              offset: Offset(16, 0),
              scrollbarTheme: ScrollbarThemeData(
                thumbVisibility: MaterialStateProperty.all<bool>(false),
                trackVisibility: MaterialStateProperty.all<bool>(false),
              ),
              maxHeight: 200,
              decoration: BoxDecoration(
                color: GonStyle.white.withOpacity(1),
              ),
            ),
            underline: const SizedBox(),
          );
        },
      ),

      // GestureDetector(
      //   onTap: () {

      //   },
      //   child: Row(
      //     children: [
      //       const Spacer(),
      //       Text(widget.itemList[selectedIndex]),
      //       const SizedBox(width: 4,),
      //       Image.asset(
      //         arrowDownIcon,
      //         width: 20,
      //         height: 20,
      //       )
      //     ],
      //   ),
      // )
    );
  }
}
