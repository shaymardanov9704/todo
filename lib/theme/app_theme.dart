import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData light = ThemeData(
    canvasColor: Colors.transparent,
    primaryColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.background,
    backgroundColor: AppColors.background,
    cardColor: AppColors.background,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme(
      primary: AppColors.assets,
      secondary: AppColors.assets,
      surface: Colors.transparent,
      background: AppColors.background,
      error: AppColors.red,
      onPrimary: AppColors.assets,
      onSecondary: AppColors.assets,
      onSurface: AppColors.assets,
      onBackground: AppColors.background,
      onError: AppColors.assets,
      brightness: Brightness.light,
      primaryVariant: AppColors.assets,
      secondaryVariant: AppColors.assets,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: ZoomPageTransitionsBuilder()
    }),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        // ios
        statusBarBrightness: Brightness.light,
        // android
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: AppColors.assets,
      ),
      titleTextStyle: AppTextStyles.appBarTitle,
      color: AppColors.white,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
      bodyText2: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
    ),
    fontFamily: 'SFPro',
  );
  static final ThemeData dark = ThemeData(
    canvasColor: Colors.transparent,
    primaryColor: AppColors.assets,
    scaffoldBackgroundColor: AppColors.black,
    backgroundColor: AppColors.background,
    cardColor: AppColors.background,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        // ios
        statusBarBrightness: Brightness.light,
        // android
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: AppColors.assets,
      ),
      titleTextStyle: AppTextStyles.appBarTitle,
      color: AppColors.white,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
      bodyText2: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
    ),
    fontFamily: 'SFPro',
  );
}
