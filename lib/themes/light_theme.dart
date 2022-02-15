import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_sizes.dart';
import 'app_theme.dart';

class LightAppTheme {
  static final themeData = ThemeData.light().copyWith(
    colorScheme: _colorScheme,
    textTheme: _textTheme,
    scaffoldBackgroundColor: _colorScheme.surface,
    appBarTheme: _appBarTheme,
    tabBarTheme: _tabBarTheme,
    dividerTheme: _dividerTheme,
    drawerTheme: _drawerTheme,
    cardTheme: _cardTheme,
    floatingActionButtonTheme: _fabTheme,
    listTileTheme: _listTileTheme,
    inputDecorationTheme: _inputDecorationTheme,
    useMaterial3: true,
    // backgroundColor: AppColors.background,
    // dialogBackgroundColor: AppColors.white,
    // errorColor: AppColors.red,
  );

  /////////// Color Theme //////////////
  static final _colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.green,
    brightness: Brightness.light,
  );

  // static final _overlayColor = ElevationOverlay.colorWithOverlay(
  //     _colorScheme.surface, _colorScheme.onSurface, 3);

  /////////// Text Theme //////////////
  static final _textTheme = Typography.blackMountainView.apply(
    bodyColor: _colorScheme.onSurface,
    displayColor: _colorScheme.onSurface,
  );

  /////////// AppBar Theme //////////////
  static final _appBarTheme = AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.transparent,
    ),
    elevation: 0,
    color: _colorScheme.surfaceVariant,
    centerTitle: true,
    iconTheme: IconThemeData(color: _colorScheme.onSurfaceVariant),
    titleSpacing: AppSizes.smallPadding,
  );

  /////////// FAB Theme //////////////
  static final _fabTheme = FloatingActionButtonThemeData(
    elevation: 3,
    backgroundColor: _colorScheme.primaryContainer,
    foregroundColor: _colorScheme.onPrimaryContainer,
    extendedTextStyle: _textTheme.button,
    extendedIconLabelSpacing: AppSizes.exSmallPadding,
    extendedPadding: const EdgeInsets.only(
      left: AppSizes.smallPadding,
      right: AppSizes.smallPadding + 4,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.fabRadius),
    ),
  );

  /////////// Divider Theme //////////////
  static final _dividerTheme = DividerThemeData(
    color: _colorScheme.onSurfaceVariant,
    thickness: 0.25,
    space: AppSizes.exSmallPadding,
  );

  /////////// Drawer Theme //////////////
  static final _drawerTheme = DrawerThemeData(
    elevation: 5,
    backgroundColor: _colorScheme.surface,
    scrimColor: _colorScheme.inverseSurface.withOpacity(0.4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    ),
  );

  /////////// TabBar Theme //////////////
  static final _tabBarTheme = TabBarTheme(
    labelColor: _colorScheme.primary,
    unselectedLabelColor: _colorScheme.onSurfaceVariant,
    indicatorSize: TabBarIndicatorSize.label,
  );

  /////////// List Tile Theme //////////////
  static final _listTileTheme = ListTileThemeData(
    contentPadding:
        const EdgeInsets.symmetric(horizontal: AppSizes.exSmallPadding),
    horizontalTitleGap: AppSizes.smallPadding,
    minLeadingWidth: 24,
    minVerticalPadding: 0,
    tileColor: _colorScheme.surface,
    selectedTileColor: _colorScheme.secondaryContainer,
    selectedColor: _colorScheme.onSecondaryContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.roundRadius),
    ),
  );

  /////////// Card Theme //////////////
  static final _cardTheme = CardTheme(
    elevation: 0,
    color: _colorScheme.surfaceVariant,
    clipBehavior: Clip.antiAlias,
    margin: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
    ),
  );

  /////////// Input Decoration Theme //////////////
  static final _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: _colorScheme.surfaceVariant,
    errorMaxLines: 3,
    contentPadding: const EdgeInsets.all(AppSizes.smallPadding),
    iconColor: _colorScheme.onSurfaceVariant,
    labelStyle:
        _textTheme.labelLarge!.copyWith(color: _colorScheme.onSurfaceVariant),
    hintStyle:
        _textTheme.labelLarge!.copyWith(color: _colorScheme.onSurfaceVariant),
    errorStyle: _textTheme.labelSmall!.copyWith(color: _colorScheme.error),
    helperStyle: _textTheme.labelSmall,
    counterStyle: _textTheme.labelSmall,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSizes.textFieldRadius)),
      borderSide: BorderSide.none,
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSizes.textFieldRadius)),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius:
          const BorderRadius.all(Radius.circular(AppSizes.textFieldRadius)),
      borderSide: BorderSide(color: _colorScheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius:
          const BorderRadius.all(Radius.circular(AppSizes.textFieldRadius)),
      borderSide: BorderSide(color: _colorScheme.error),
    ),
  );
}
