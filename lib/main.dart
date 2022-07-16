import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_projeto/login.dart';
import 'package:whatsapp_projeto/routegenerator.dart';
import 'firebase_options.dart';

void main() async {

  // Inicializando os serviços do Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WhatsApp',
    home: const Login(),

    // Rotas
    initialRoute: '/',

    onGenerateRoute: RouteGenerator.generateRoute,

    /* routes: {
      '/login':(context) => const Login(),
      '/home' :(context) => const Home(),

    }, */
    
    // Tema
    theme: ThemeData(
      //useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff075E54),
        secondary: const Color(0xff25D366),
        //onBackground: Colors.white,
        primary: const Color(0xff075E54),
      ),
      //canvasColor: Colors.white,

      //scaffoldBackgroundColor: const Color(0xff075E54),
      backgroundColor: Colors.white
            

    ),

  ));
}
