import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/Gon_style.dart';
import 'field_controller.dart';
import 'text_field_theme/text_field_theme.dart';

class TitleTextField extends StatefulWidget {
  final FieldController? controller;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final String title;
  final bool autoFocus;
  final bool usingMaxLengthValidator;
  final int? maxLength;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final int? maxLines;
  final int? minLines;
  final bool isCollapse;
  final bool isObscure;
  final bool emojiEnable;
  final Iterable<String>? autofillHints;
  EdgeInsets scrollPadding;

  TitleTextField({
    Key? key,
    this.controller,
    this.onSubmitted,
    this.onTap,
    this.onChanged,
    this.prefixIcon,
    this.hintText = '',
    this.title = '',
    this.autoFocus = false,
    this.usingMaxLengthValidator = false,
    this.scrollPadding = const EdgeInsets.all(45),
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.maxLines = 1,
    this.minLines,
    this.isCollapse = false,
    this.isObscure = false,
    this.emojiEnable = false,
    this.autofillHints = const <String>[],
  }) : super(key: key);

  @override
  _TitleTextFieldState createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  FieldController? _controller;
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4));

  @override
  void initState() {
    if (widget.controller != null) {
      _controller = widget.controller;
    } else {
      _controller = FieldController();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _controller!.statusStream,
        initialData: FieldStatus(),
        builder: (context, snapshot) {
          bool isCollapse = false;
          if (widget.isCollapse &&
              (_controller?.focusNode?.hasFocus ?? false)) {
            isCollapse = true;
          } else {
            isCollapse = false;
          }
          FieldStatus status = (snapshot.data as FieldStatus);

          var suffixWidget;
          if (widget.isObscure) {
            suffixWidget = CupertinoButton(
              padding: EdgeInsets.zero,
              pressedOpacity: .9,
              minSize: 0,
              onPressed: () {
                widget.controller!.setIsObscure(!status.isObscure);
              },
              child: !status.isObscure
                  ? Image.asset(
                      'assets/icons/hide_pw.png',
                      height: 24,
                      width: 24,
                      color: const Color(0xff999999),
                    )
                  : Image.asset(
                      'assets/icons/show_pw.png',
                      height: 24,
                      width: 24,
                      color: const Color(0xff999999),
                    ),
            );
          }
          int textLength = _controller?.status.text.characters.length ?? 0;
          var maxLengthWidget = Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '$textLength',
                  style: GonStyle.caption(
                      color: TextFieldColor.textField_default_label),
                ),
                Text(
                  '/${widget.maxLength}',
                  style: GonStyle.caption(
                      color: TextFieldColor.textField_default_label),
                ),
              ],
            ),
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.toWidth),
                    child: TextField(
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      inputFormatters: [
                        // if (!widget.emojiEnable) ...{
                        //   FilteringTextInputFormatter.deny(
                        //       Strings().blockEmojiRegex),
                        // },
                        ...widget.inputFormatters,
                      ],
                      autofillHints: widget.autofillHints,
                      obscureText: widget.isObscure ? status.isObscure : false,
                      autofocus: widget.autoFocus,
                      enabled: (status.isFieldEnable),
                      focusNode: _controller!.focusNode,
                      controller: _controller!.textController,
                      keyboardType: widget.keyboardType,
                      cursorColor: TextFieldColor.textField_text,
                      cursorWidth: 1,
                      onAppPrivateCommand: (_, __) {},
                      onSubmitted: (value) {
                        _controller!.unfocus();
                        if (widget.onSubmitted != null) {
                          widget.onSubmitted!(value);
                        }
                      },
                      onTap: widget.onTap,
                      onChanged: (value) {
                        _controller!.setText(value);
                        if (widget.onChanged != null) {
                          widget.onChanged!(value);
                        }
                      },
                      style: GonStyle.body2(
                          color: status.isFieldEnable
                              ? TextFieldColor.textField_text
                              : TextFieldColor.textField_disable_text),
                      scrollPadding: widget.scrollPadding,
                      maxLength: widget.maxLength,
                      decoration: InputDecoration(
                        counterText: '',
                        prefixIcon: widget.prefixIcon,
                        suffixIcon: suffixWidget,
                        contentPadding: isCollapse
                            ? const EdgeInsets.only(
                                left: 16, right: 16, top: 17, bottom: 36)
                            : const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                        hintText: (status.hasFocus && widget.title.isNotEmpty)
                            ? ''
                            : widget.hintText,
                        hintStyle: GonStyle.body2(
                            color: TextFieldColor.textField_hint_text,
                            weight: FontWeight.w600),
                        isCollapsed: isCollapse,
                        filled: true,
                        fillColor: Colors.white,
                        hintMaxLines: 2,
                        disabledBorder: OutlineInputBorder(
                          borderRadius: borderRadius,
                          borderSide: const BorderSide(
                              color: GonStyle.gray040, width: 1),
                        ),
                        enabledBorder: status.hasError
                            ? OutlineInputBorder(
                                borderRadius: borderRadius,
                                borderSide: const BorderSide(
                                    color: TextFieldColor.textField_error_line,
                                    width: 1),
                              )
                            : OutlineInputBorder(
                                borderRadius: borderRadius,
                                borderSide: const BorderSide(
                                    color:
                                        TextFieldColor.textField_default_line,
                                    width: 1),
                              ),
                        focusedBorder: status.hasError
                            ? OutlineInputBorder(
                                borderRadius: borderRadius,
                                borderSide: const BorderSide(
                                    color: TextFieldColor.textField_error_line,
                                    width: 1),
                              )
                            : OutlineInputBorder(
                                borderRadius: borderRadius,
                                borderSide: const BorderSide(
                                    color: TextFieldColor.textField_focus_line,
                                    width: 1),
                              ),
                      ),
                    ),
                  ),
                  if (widget.title != '') ...{
                    Positioned(
                        top: 0,
                        left: 16,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 250),
                          opacity: (widget.title.trim() != '' &&
                                      status.text.trim() != '' ||
                                  status.hasFocus)
                              ? 1.0
                              : 0.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            color: GonStyle.white,
                            child: Text(
                              widget.title,
                              style: status.hasFocus
                                  ? GonStyle.caption(
                                      color: status.hasError
                                          ? TextFieldColor.textField_focus_label
                                          : TextFieldColor
                                              .textField_focus_label)
                                  : GonStyle.caption(
                                      color: status.hasError
                                          ? TextFieldColor
                                              .textField_default_label
                                          : TextFieldColor
                                              .textField_default_label),
                            ),
                          ),
                        )),
                  }
                ],
              )),
              Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: Builder(builder: (ctx) {
                    if (widget.usingMaxLengthValidator == false &&
                        !status.hasError) {
                      return const SizedBox();
                    }
                    if (!status.hasError) {
                      return Padding(
                        padding: EdgeInsets.only(top: 3.toWidth, bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text('', style: GonStyle.caption()),
                            ),
                            if (widget.usingMaxLengthValidator) ...{
                              maxLengthWidget
                            }
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 14.toWidth, top: 3.toWidth, bottom: 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(status.errorText,
                                  style: GonStyle.caption(
                                      color: TextFieldColor
                                          .textField_error_label)),
                            ),
                            if (widget.usingMaxLengthValidator) ...{
                              maxLengthWidget
                            }
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ),
            ],
          );
        });
  }
}
