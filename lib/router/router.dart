import 'dart:async';

import 'package:bus_counter/common/view/root_screen.dart';
import 'package:bus_counter/customer/model/customer_model.dart';
import 'package:bus_counter/customer/view/add_customer_screend.dart';
import 'package:bus_counter/customer/view/customer_detail_screen.dart';
import 'package:bus_counter/customer/view/customer_list_screen.dart';
import 'package:bus_counter/customer/view/customer_modify_screen.dart';
import 'package:bus_counter/customer/view/search_customer_result_screen.dart';
import 'package:bus_counter/game/model/game_model.dart';
import 'package:bus_counter/game/view/add_game_screen.dart';
import 'package:bus_counter/game/view/game_list_screen.dart';
import 'package:bus_counter/history/view/history_detail_screen.dart';
import 'package:bus_counter/history/view/history_screen.dart';
import 'package:bus_counter/manager/view/profile_edit_screen.dart';
import 'package:bus_counter/manager/view/profile_screen.dart';
import 'package:bus_counter/run/model/run_model.dart';
import 'package:bus_counter/run/view/run_screen.dart';
import 'package:bus_counter/setting/view/setting_screen.dart';
import 'package:bus_counter/run/view/add_run_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/utils/logger.dart';
import '../common/view/splash_screen.dart';
import '../login/view/email_login_screen.dart';
import '../login/view/email_regist_screen.dart';
import '../login/view/login_landing_screen.dart';
import '../manager/view/input_regist_user_info.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (_, __) => SplashScreen(),
    ),
    GoRoute(
      path: '/',
      name: RootScreen.routeName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const RootScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: 'couter',
          name: RunScreen.routeName,
          builder: (_, __) => RunScreen(),
          routes: [
            GoRoute(
              path: 'add_run',
              name: AddRunScreen.routeName,
              builder: (_, __) => AddRunScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'history',
          name: HistoryScreen.routeName,
          builder: (_, __) => HistoryScreen(),
          routes: [
            GoRoute(
              path: 'history_detail',
              name: HistoryDetailScreen.routeName,
              builder: (_, state) {
                final runItem = state.extra as RunModel;
                return HistoryDetailScreen(runItem: runItem);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'game_list',
          name: GameListScreen.routeName,
          builder: (_, state) {
            return GameListScreen(
              onItemPressed: state.extra as Function(GameModel)?,
            );
          },
          routes: [
            GoRoute(
              path: 'add_game',
              name: AddGameScreen.routeName,
              builder: (_, __) => AddGameScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'customer_list',
          name: CustomerListScreen.routeName,
          builder: (_, state) {
            return CustomerListScreen(
              onItemPressed: state.extra as Function(CustomerModel)?,
            );
          },
          routes: [
            GoRoute(
              path: 'add_customer',
              name: AddCustomerScreen.routeName,
              builder: (_, __) => AddCustomerScreen(),
            ),
            GoRoute(
              path: 'customer_modify',
              name: CustomerModifyScreen.routeName,
              builder: (_, state) {
                final customer = state.extra as CustomerModel;
                return CustomerModifyScreen(
                  customer: customer,
                );
              },
            ),
            GoRoute(
              path: 'customer_detail',
              name: CustomerDetailScreen.routeName,
              builder: (_, state) {
                final customer = state.extra as CustomerModel;
                return CustomerDetailScreen(customer: customer);
              },
            ),
            GoRoute(
              path: 'search_customer',
              name: SearchCustomerResultScreen.routeName,
              builder: (_, state) {
                Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                final String nickname = data['nickname'];
                final Function(CustomerModel)? onItemPressed =
                    data['onItemPressed'];
                final Function(CustomerModel)? onDelete = data['onDelete'];
                final Function(CustomerModel)? onUpdate = data['onUpdate'];
                return SearchCustomerResultScreen(
                  nickname: nickname,
                  onItemPressed: onItemPressed,
                  onDelete: onDelete,
                  onUpdate: onUpdate,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          name: ProfileScreen.routeName,
          builder: (_, __) => ProfileScreen(),
          routes: [
            GoRoute(
              path: 'profile_edit',
              name: ProfileEditScreen.routeName,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: const ProfileEditScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'setting',
          name: SettingScreen.routeName,
          builder: (_, __) => SettingScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/login_landing',
      name: LoginLandingScreen.routeName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const LoginLandingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: 'email_login',
          name: EmailLoginScreen.routeName,
          builder: (_, __) => EmailLoginScreen(),
        ),
        GoRoute(
          path: 'email_regist',
          name: EmailRegistScreen.routeName,
          builder: (_, __) => EmailRegistScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/input_user_info',
      name: InputRegistUserInfo.routeName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const InputRegistUserInfo(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  ],
  observers: [
    GoRouterObserver(),
  ],
);

class GoRouterObserver extends NavigatorObserver {
  final List<Route<dynamic>?> _history = <Route<dynamic>?>[];

  String getHistoryToString() {
    return _history
        .map((element) => element!.settings.name)
        .toList()
        .toString();
  }

  List<Route<dynamic>> classHistories = [];

  List<String?> getHistories() {
    return _history.map((element) => element!.settings.name).toList();
  }

  Route? get top => _history.last;

  final List<Route<dynamic>?> _poppedRoutes = <Route<dynamic>?>[];

  final StreamController _historyChangeStreamController =
      StreamController.broadcast();

  Stream get historyChangeStream => _historyChangeStreamController.stream;

  static final GoRouterObserver _singleton = GoRouterObserver._internal();

  GoRouterObserver._internal();

  factory GoRouterObserver() {
    return _singleton;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _history.add(route);
    _poppedRoutes.remove(route);
    try {
      classHistories.add(route);
    } catch (e) {}
    _historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.push,
      newRoute: route,
      oldRoute: previousRoute,
    ));
    GonLog().i('History Observer : didPush \n ${getHistoryToString()}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _poppedRoutes.add(_history.last);

    try {
      classHistories.removeLast();
    } catch (e) {}
    _history.removeLast();
    _historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.pop,
      newRoute: route,
      oldRoute: previousRoute,
    ));

    GonLog().i('History Observer : didPop \n ${getHistoryToString()}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _history.remove(route);
    try {
      classHistories.remove(route);
    } catch (e) {}
    _historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.remove,
      newRoute: route,
      oldRoute: previousRoute,
    ));
    GonLog().i('History Observer : didRemove \n ${getHistoryToString()}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route? oldRoute}) {
    try {
      if (newRoute is MaterialPageRoute) {
        classHistories.removeLast();
        classHistories.add(newRoute);
      }
    } catch (e) {}
    int oldRouteIndex = _history.indexOf(oldRoute);
    _history.replaceRange(oldRouteIndex, oldRouteIndex + 1, [newRoute]);
    _historyChangeStreamController.add(HistoryChange(
      action: NavigationStackAction.replace,
      newRoute: newRoute,
      oldRoute: oldRoute,
    ));
    GonLog().i('History Observer : didReplace \n ${getHistoryToString()}');
  }
}

class HistoryChange {
  HistoryChange({this.action, this.newRoute, this.oldRoute});

  final NavigationStackAction? action;
  final Route<dynamic>? newRoute;
  final Route<dynamic>? oldRoute;
}

enum NavigationStackAction { push, pop, remove, replace }
