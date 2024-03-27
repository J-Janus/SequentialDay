import 'package:flutter/material.dart';
import 'package:my_wear_app/ambient_mode/ambient_mode.dart';
import 'package:my_wear_app/app/view/app_mobile.dart';
import 'package:my_wear_app/auth/loginPageMediator.dart';
import 'package:my_wear_app/auth/login_page.dart';
import 'package:my_wear_app/test_google/test.dart';
import 'package:my_wear_app/watch/counter.dart';
import 'package:my_wear_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AmbientModeBuilder(
      child: loginPageWraper(),
      builder: (context, isAmbientModeActive, child) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            // This makes elements such as buttons have a fewer pixels in
            // padding and general spacing. good for devices with limited screen
            // real state.
            visualDensity: VisualDensity.compact,
            // When in ambient mode, change the apps color scheme
            colorScheme: isAmbientModeActive
                ? const ColorScheme.dark(
                    primary: Colors.white24,
                    onBackground: Colors.white10,
                    onSurface: Colors.white10,
                  )
                : const ColorScheme.dark(
                    primary: Color(0xFF00B5FF),
                  ),
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: child,
        );
      },
    );
  }
}
