import 'package:flutter/material.dart';

import '../../utils/gon_style.dart';

class DefaultDivider extends StatelessWidget {
  final double height;
  final double? indent;
  final double? endIndent;
  const DefaultDivider({
    Key? key,
    this.height = 0,
    this.indent,
    this.endIndent,
  })  : assert(height == null || height >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: GonStyle.gray040,
      endIndent: endIndent,
      indent: indent,
      thickness: 1,
    );
  }
}
