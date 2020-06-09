import 'package:agencia_scholz/app/src/views/home_views.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgenciaScholzApp extends StatelessWidget {
  const AgenciaScholzApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeViews(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cursorColor: const Color(0xFF00d856),
        buttonColor: const Color(0xFF8C35F1),
        indicatorColor: Colors.blue,
        accentColor: const Color(0xFF9F56F3),
        hintColor: const Color(0xFFF3E600),
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF00d856),
        fontFamily: '',
        canvasColor: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.black,
                fontSize: 16,
              ),
              headline6: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.black,
                fontSize: 24,
              ),
            ),
        appBarTheme: AppBarTheme(
          elevation: 5,
          color: const Color(0xFF00d856),
          iconTheme: IconThemeData(
            color: const Color(0xFF8C35F1),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
        ),
      ),
    );
  }
}
