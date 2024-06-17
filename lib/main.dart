import 'dart:io';

import 'package:bus_counter/common/provider/profile_provider.dart';
import 'package:bus_counter/common/provider/running_list_provider.dart';
import 'package:bus_counter/common/repository/gon_repository.dart';
import 'package:bus_counter/common/utils/gon_style.dart';
import 'package:bus_counter/common/utils/gon_utils.dart';
import 'package:bus_counter/firebase_options.dart';
import 'package:bus_counter/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'common/utils/const.dart';
import 'common/view/forced_update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String minVer = await GonRepository().getMinVersion();
  PackageInfo projectVersion = await PackageInfo.fromPlatform();
  String curVer = projectVersion.version;

  int compare = GonUtil().compare(curVer, minVer);

  if (compare == -1) {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('ko', 'KR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ko', 'KR'),
        child: ScreenUtilInit(
          designSize: Device.get().isTablet! && Device.get().isAndroid!
              ? GonStyle.tabletDesignSize
              : GonStyle.defaultDesignSize,
          builder: (context, child) {
            return MaterialApp(
              title: '쌀먹',
              theme: Constants.theme,
              debugShowCheckedModeBanner: false,
              showPerformanceOverlay: false,
              builder: (context, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final MediaQueryData data = MediaQuery.of(context);
                    bool usingDeviceSize =
                        Device.get().isTablet! && Device.get().isAndroid!;
                    if (usingDeviceSize) {
                      GonStyle.applyDesignSize = GonStyle.tabletDesignSize;
                    }
                    ScreenUtil.init(
                      context,
                      designSize: usingDeviceSize
                          ? GonStyle.tabletDesignSize
                          : GonStyle.defaultDesignSize,
                    );
                    return MediaQuery(
                      data: data.copyWith(
                        textScaler:
                            TextScaler.linear(Platform.isAndroid ? .95 : 1.0),
                      ),
                      child: child!,
                    );
                  },
                );
              },
              home: Builder(
                builder: (context) {
                  return ForcedUpdate(curVer: curVer);
                },
              ),
            );
          },
        ),
      ),
    );
  } else {
    runApp(const _App());
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [Locale('ko', 'KR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ko', 'KR'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
          ),
          ChangeNotifierProvider<RunningListProvider>(
            create: (_) => RunningListProvider(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: Device.get().isTablet! && Device.get().isAndroid!
              ? GonStyle.tabletDesignSize
              : GonStyle.defaultDesignSize,
          builder: (context, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              theme: Constants.theme,
              title: Constants.appName,
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
              builder: (context, child) {
                final MediaQueryData data = MediaQuery.of(context);
                bool usingDeviceSize =
                    Device.get().isTablet! && Device.get().isAndroid!;
                if (usingDeviceSize) {
                  GonStyle.applyDesignSize = GonStyle.tabletDesignSize;
                }
                ScreenUtil.init(context,
                    designSize: usingDeviceSize
                        ? GonStyle.tabletDesignSize
                        : GonStyle.defaultDesignSize);

                return MediaQuery(
                  data: data.copyWith(
                      textScaler:
                          TextScaler.linear(Platform.isAndroid ? .95 : 1)),
                  child: child!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
