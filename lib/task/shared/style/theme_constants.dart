import 'package:flutter/material.dart';
import 'package:tasks/task/shared/constant/padding_margin_values_manager.dart';
import 'package:tasks/task/shared/style/styles_manager.dart';

import 'colors_manager.dart';
import 'font_manager.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorManager.primary,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: ColorManager.accent),
    // elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),side: BorderSide(color: ColorManager.darkPrimary, width: 2) )),

          backgroundColor:
              MaterialStateProperty.all<Color>(ColorManager.basic)),

    ),
    // text
    textTheme: TextTheme(
      headline1: TextStyle(
          color: ColorManager.darkPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 24),
      headline2: TextStyle(
          color: ColorManager.basic,
          fontWeight: FontWeight.w700,
          fontSize: 30,
          fontFamily: FontConstants.fontFamily),
      headline4:
          TextStyle(color: ColorManager.basic, fontWeight: FontWeight.bold),
    ),
    // input
  inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.basic,
      // content padding
      contentPadding: const EdgeInsets.fromLTRB(10,25,10,25),
      // hint style
      hintStyle:
      getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s18),
      labelStyle:
      getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s18),
      errorStyle: getRegularStyle(color: ColorManager.accent2),

      // enabled border style
      enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.lightPrimary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),
      //

      // // focused border style
      focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.darkPrimary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),

      // // error border style
      errorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.accent2, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),
      // // focused border style
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.basic, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18)))),
    // done
    );

ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: ColorManager.primary,
  floatingActionButtonTheme:
  FloatingActionButtonThemeData(backgroundColor: ColorManager.accent),
  // elevated button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),side: BorderSide(color: ColorManager.darkPrimary, width: 2) )),

        backgroundColor:
        MaterialStateProperty.all<Color>(ColorManager.basic)),

  ),
  // text
  textTheme: TextTheme(
    headline1: TextStyle(
        color: ColorManager.darkPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 24),
    headline2: TextStyle(
        color: ColorManager.basic,
        fontWeight: FontWeight.w700,
        fontSize: 30,
        fontFamily: FontConstants.fontFamily),
    headline4:
    TextStyle(color: ColorManager.basic, fontWeight: FontWeight.bold),
  ),
  // input
  inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.basic,
      // content padding
      contentPadding: const EdgeInsets.fromLTRB(10,25,10,25),
      // hint style
      hintStyle:
      getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s18),
      labelStyle:
      getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s18),
      errorStyle: getRegularStyle(color: ColorManager.accent2),

      // enabled border style
      enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.lightPrimary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),
      //

      // // focused border style
      focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.darkPrimary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),

      // // error border style
      errorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.accent2, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18))),
      // // focused border style
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: ColorManager.basic, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s18)))),
  // done
);
