import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'di/di.dart' as sl;

String token = 'c10258a13ae01e077d79d1a8c638087a896a2767';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await sl.init();
  runApp(EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: const [Locale('uz'), Locale('ru')],
      path: 'assets/l10n',
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('uz'),
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) =>
          MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode: ThemeMode.system,
            theme: ThemeData(
              scrollbarTheme: ScrollbarThemeData(
                thickness: MaterialStateProperty.all(5.w),
                radius: Radius.circular(3.r),
                crossAxisMargin: 12,
                thumbColor: MaterialStateProperty.all(AppColors.blue),
                thumbVisibility: MaterialStateProperty.all(true),
                trackColor: MaterialStateProperty.all(AppColors.blue),
              ),
            ),
          ),
    );
  }
}
