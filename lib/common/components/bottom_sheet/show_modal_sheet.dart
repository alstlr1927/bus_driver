import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'custom_modal_route.dart';

typedef ScrollWidgetBuilder = Widget Function(
    BuildContext context, ScrollController controller);

Future<dynamic>? showModalSheet(BuildContext context,
    {WidgetBuilder? builder, RouteSettings? routeSettings}) {
  if (context.findRootAncestorStateOfType() == null) {
    return null;
  }

  return showCupertinoModalBottomSheet(
      expand: false,
      clipBehavior: Clip.none,
      barrierColor: Colors.black.withOpacity(.32),
      context: context,
      settings: routeSettings,
      duration: const Duration(milliseconds: 300),
      animationCurve: Curves.linearToEaseOut,
      previousRouteAnimationCurve: Curves.easeOut,
      backgroundColor: Colors.white,
      builder: builder!);
}

Future<dynamic>? showModalPopUp(
    {BuildContext? context, WidgetBuilder? builder}) {
  if (context?.findRootAncestorStateOfType() == null) {
    return null;
  }
  return Navigator.of(context!, rootNavigator: true).push(
    CupertinoModalRoute(
      barrierColor:
          CupertinoDynamicColor.resolve(Colors.black.withOpacity(.32), context),
      barrierLabel: 'Dismiss',
      builder: builder,
    ),
  );
}

Future<T?>? showTitleDialog<T>({
  required BuildContext? context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? barrierColor,
  RouteSettings? routeSettings,
}) {
  if ((context?.findRootAncestorStateOfType()) == null) {
    return null;
  }

  return showGeneralDialog(
      context: context!,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return WillPopScope(
            onWillPop: () {
              return Future.value(barrierDismissible);
            },
            child: builder(context));
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black.withOpacity(.32),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: _buildCupertinoDialogTransitions,
      useRootNavigator: false,
      routeSettings: routeSettings);
}

class CupertinoDialogRoute<T> extends CustomPopupRoute<T> {
  CupertinoDialogRoute({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    RouteSettings? settings,
  })  : assert(barrierDismissible != null),
        _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder,
        super(settings: settings);

  final RoutePageBuilder _pageBuilder;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  final RouteTransitionsBuilder? _transitionBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double>? animation,
      Animation<double>? secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context, animation!, secondaryAnimation!),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double>? animation,
      Animation<double>? secondaryAnimation, Widget child) {
    if (_transitionBuilder == null) {
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation!,
            curve: Curves.linear,
          ),
          child: child);
    } // Some default transition
    return _transitionBuilder!(context, animation!, secondaryAnimation!, child);
  }
}

class CupertinoModalRoute<T> extends CustomPopupRoute<T> {
  CupertinoModalRoute({
    this.barrierColor,
    this.barrierLabel,
    this.builder,
    bool? semanticsDismissible,
    ImageFilter? filter,
    RouteSettings? settings,
  }) : super(
          filter: filter,
          settings: settings,
        ) {
    _semanticsDismissible = semanticsDismissible;
  }

  final WidgetBuilder? builder;
  bool? _semanticsDismissible;

  @override
  final String? barrierLabel;

  @override
  final Color? barrierColor;

  @override
  bool get barrierDismissible => true;

  @override
  bool get semanticsDismissible => _semanticsDismissible ?? false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 330);

  Animation<double>? _animation;

  late Tween<Offset> _offsetTween;

  @override
  Animation<double> createAnimation() {
    assert(_animation == null);
    _animation = CurvedAnimation(
      parent: super.createAnimation(),

      // These curves were initially measured from native iOS horizontal page
      // route animations and seemed to be a good match here as well.
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    );
    _offsetTween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    );
    return _animation!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double>? animation,
      Animation<double>? secondaryAnimation) {
    return CupertinoUserInterfaceLevel(
      data: CupertinoUserInterfaceLevelData.elevated,
      child: Builder(builder: builder!),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double>? animation,
      Animation<double>? secondaryAnimation, Widget child) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionalTranslation(
        translation: _offsetTween.evaluate(_animation!),
        child: child,
      ),
    );
  }
}

Widget _buildCupertinoDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  final CurvedAnimation fadeAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  if (animation.status == AnimationStatus.reverse) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }
  return FadeTransition(
    opacity: fadeAnimation,
    child: child,
  );
}
