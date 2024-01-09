import 'package:expense_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

var kcolorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 6, 66, 56));

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,]).then((fn){
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kcolorscheme,
      // scaffoldBackgroundColor: const Color.fromARGB(255, 11, 102, 67),
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kcolorscheme.onPrimaryContainer,
        foregroundColor: kcolorscheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        color: kcolorscheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kcolorscheme.primaryContainer),
      ),
    ),
    home: const Expenses(),
  ));
    //});
}
