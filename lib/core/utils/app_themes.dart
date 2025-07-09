import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppThemes {
  static final light = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.mirage,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      splashColor: AppColors.transparent,
      foregroundColor: AppColors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.mirage,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(color: AppColors.white),
      unselectedIconTheme: IconThemeData(color: AppColors.white),
      unselectedLabelStyle: TextStyle(color: AppColors.white),
      selectedIconTheme: IconThemeData(color: AppColors.white),
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.mirage,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      actionsIconTheme: IconThemeData(color: AppColors.mirage),
      iconTheme: IconThemeData(color: AppColors.mirage),
      titleTextStyle: TextStyle(color: AppColors.mirage, fontSize: 20),
    ),
    iconTheme: const IconThemeData(color: AppColors.mirage),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.mirage,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.mirage),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.mirage),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.mirage),

      displayLarge: TextStyle(fontSize: 57, color: AppColors.mirage),
      displayMedium: TextStyle(fontSize: 45, color: AppColors.mirage),
      displaySmall: TextStyle(fontSize: 36, color: AppColors.mirage),

      headlineLarge: TextStyle(fontSize: 32, color: AppColors.mirage),
      headlineMedium: TextStyle(fontSize: 28, color: AppColors.mirage),
      headlineSmall: TextStyle(fontSize: 24, color: AppColors.mirage),

      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.mirage,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.mirage,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.mirage,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.mirage,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.mirage,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.mirage,
      ),
    ),
    splashColor: AppColors.transparent,
    highlightColor: AppColors.transparent,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          AppColors.white,
        ), // Set text color
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          AppColors.mirage,
        ), // Set text color
      ),
    ),
    cardTheme: const CardTheme(
      color: AppColors.white,
      shadowColor: AppColors.mirage,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.all(8),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.catskillWhite,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      elevation: 8,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.white,
      width: 300,
      elevation: 8,
      scrimColor: AppColors.gray20, // subtle overlay behind drawer
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      headerBackgroundColor: AppColors.white,
      headerForegroundColor: AppColors.mirage,
      yearForegroundColor: WidgetStateProperty.all(AppColors.mirage),
      rangeSelectionBackgroundColor: AppColors.white,
      rangePickerSurfaceTintColor: AppColors.mirage,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.mirage;
          }
          return AppColors.white;
        }),
      todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.mirage;
        }
        return AppColors.white;
      }),
      todayBorder: BorderSide(
        color: AppColors.mirage,
      ),
      todayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        }
        return AppColors.mirage;
      }),
      rangeSelectionOverlayColor: WidgetStatePropertyAll(AppColors.mirage),
      rangePickerBackgroundColor: AppColors.mirage,
      dayStyle: TextStyle(
        color: AppColors.white
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.mirage)
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.mirage)
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mirage,
          ),
        ),
        helperStyle: TextStyle(
            color: AppColors.mirage
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mirage,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mirage,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mirage,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mirage,
          ),
        ),
        labelStyle: TextStyle(
            color: AppColors.mirage
        ),
        hintStyle: TextStyle(
            color: AppColors.mirage
        ),
        floatingLabelStyle: TextStyle(
            color: AppColors.mirage
        ),
        counterStyle: TextStyle(
          color: AppColors.mirage,
        ),
        filled: false,
      )
    ),
    colorScheme:  ColorScheme.light(
    primary: AppColors.mirage,
    ),
  );
  static final dark = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      splashColor: AppColors.transparent,
      foregroundColor: AppColors.mirage,
    ),
    scaffoldBackgroundColor: AppColors.mirage,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.mirage,
      unselectedItemColor: AppColors.mirage,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(color: AppColors.mirage),
      unselectedIconTheme: IconThemeData(color: AppColors.mirage),
      unselectedLabelStyle: TextStyle(color: AppColors.mirage),
      selectedIconTheme: IconThemeData(color: AppColors.mirage),
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mirage,
      actionsIconTheme: IconThemeData(color: AppColors.white),
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(color: AppColors.white, fontSize: 20),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.white),
      // General body text
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.white),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.white),

      displayLarge: TextStyle(fontSize: 57, color: AppColors.white),
      // Large headings
      displayMedium: TextStyle(fontSize: 45, color: AppColors.white),
      displaySmall: TextStyle(fontSize: 36, color: AppColors.white),

      headlineLarge: TextStyle(fontSize: 32, color: AppColors.white),
      // Section headings
      headlineMedium: TextStyle(fontSize: 28, color: AppColors.white),
      headlineSmall: TextStyle(fontSize: 24, color: AppColors.white),

      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      // Titles
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      // Buttons & labels
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    ),
    splashColor: AppColors.transparent,
    highlightColor: AppColors.transparent,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          AppColors.mirage,
        ), // Set text color
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          AppColors.white,
        ), // Set text color
      ),
    ),
    cardTheme: const CardTheme(
      color: AppColors.oxfordBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.all(8),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.blackPearl,
      surfaceTintColor: AppColors.blackPearl2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      elevation: 8,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.white,
      splashColor: AppColors.transparent
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.blackPearl2,
      width: 300,
      elevation: 8,
      scrimColor: AppColors.gray20,
    ),
    datePickerTheme: DatePickerThemeData(
        headerForegroundColor: AppColors.white, // Changes "May 2025" text color
        headerHeadlineStyle: TextStyle(color: AppColors.white), // Optional: change style of the date
        headerHelpStyle: TextStyle(color: AppColors.white),
        backgroundColor: AppColors.riverBed,
        surfaceTintColor: AppColors.mirage,
        headerBackgroundColor: AppColors.riverBed,
        weekdayStyle: TextStyle(
          color: AppColors.white
        ),
        rangePickerHeaderHeadlineStyle: TextStyle(
          color: AppColors.white
        ),
        rangePickerHeaderHelpStyle: TextStyle(
          color: AppColors.white
        ),
        yearStyle: TextStyle(
          color: AppColors.white
        ),
        rangePickerHeaderForegroundColor: AppColors.white,
        yearForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.mirage; // Selected year text color
          }
          return AppColors.white; // Default year text color
        }),
        rangeSelectionBackgroundColor: AppColors.white,
        rangePickerSurfaceTintColor: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return null;
        }),
        todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.riverBed;
        }),
        dayForegroundColor:WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.mirage;
          }else if(states.contains(WidgetState.disabled)){
            return AppColors.gray;
          }
          return AppColors.white;
        }) ,
        todayBorder: BorderSide(
          color: AppColors.white,
        ),
        todayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.mirage;
          }
          return AppColors.white;
        }),
        rangeSelectionOverlayColor: WidgetStatePropertyAll(AppColors.white),
        rangePickerBackgroundColor: AppColors.mirage,
        dayStyle: TextStyle(
            color: AppColors.white
        ),
        cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.white)
        ),
        confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.white)
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.mirage,
            ),
          ),
          helperStyle: TextStyle(
              color: AppColors.mirage
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.mirage,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.mirage,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.mirage,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.mirage,
            ),
          ),
          labelStyle: TextStyle(
              color: AppColors.mirage
          ),
          hintStyle: TextStyle(
              color: AppColors.mirage
          ),
          floatingLabelStyle: TextStyle(
              color: AppColors.mirage
          ),
          counterStyle: TextStyle(
            color: AppColors.mirage,
          ),
          filled: false,
        )
    ),
    colorScheme:  ColorScheme.dark(
    primary: AppColors.white,
  ),
  );
}
