
import 'package:bdatos/firebase_options.dart';
import 'package:bdatos/pages/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            //texto
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
              titleLarge: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.titleLarge,
                fontSize: 32,
                color: Color.fromARGB(100, 103, 58, 183),
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.bodyMedium,
                fontSize: 18,
                color: Colors.black87,
                fontStyle: FontStyle.italic,
              ),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(100, 103, 58, 183,),
              brightness: Brightness.light,
            ),
            iconTheme: IconThemeData(
                color: Color.fromARGB(255, 103, 58, 183,)
            ),
            scaffoldBackgroundColor: Colors.pinkAccent[50],
            appBarTheme: AppBarTheme(
              backgroundColor: Color.fromARGB(255, 81, 45, 168,),
              titleTextStyle: GoogleFonts.lato(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(100, 103, 58, 183,),
                    textStyle: GoogleFonts.lato(
                        fontSize:20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )
                )
            )
        ),
        home: SplashScreen()
    );
  }
}