import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Style {
  static Style get I => GetIt.I<Style>();

  late final TextTheme textTheme;

  Style.init({required BuildContext context}) {
    textTheme = ThemeData.light().textTheme.apply(fontFamily: 'Work Sans');
  }

  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        backgroundColor: Colors.yellow.shade600,
        primaryColor: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(secondary: Colors.yellow.shade600),
        textTheme: textTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
        textButtonTheme: TextButtonThemeData(style: buttonStyle),
      );

  ButtonStyle get buttonStyle => ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      );
}
