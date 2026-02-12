import 'package:flutter/material.dart';
import 'screens/auth_page.dart';
import 'screens/home_page.dart';
import 'screens/config_page.dart';
import 'screens/department_page.dart';
import 'services/theme_service.dart';

// 1. Instance globale pour la gestion du thème (POO - Singleton Pattern)
final themeService = ThemeService();

void main() {
  runApp(const ElFouladhApp());
}

class ElFouladhApp extends StatelessWidget {
  const ElFouladhApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Utilisation de ListenableBuilder pour écouter les changements de thème
    return ListenableBuilder(
      listenable: themeService,
      builder: (context, child) {
        return MaterialApp(
          title: 'El Fouladh System',
          debugShowCheckedModeBanner: false,
          
          // --- CONFIGURATION DU THÈME ---
          themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          
          // Thème Clair
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blueGrey,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
            ),
          ),
          
          // Thème Sombre
          darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.blueGrey,
          scaffoldBackgroundColor: const Color(0xFF121212), // Fond sombre de l'écran

            // --- C'EST ICI QUE LA MAGIE OPÈRE ---
            inputDecorationTheme: InputDecorationTheme(
              filled: true, // On remplit le fond du champ
              fillColor: Colors.white.withOpacity(0.9), // Fond BLANC (pour voir le texte noir)
              
              // 1. Couleur du LABEL (ex: "Matricule")
              labelStyle: const TextStyle(
                color: Colors.black87, 
                fontWeight: FontWeight.bold
              ),
              
              // 2. Couleur du texte d'aide (Hint)
              hintStyle: const TextStyle(color: Colors.black54),

              // 3. Bordures
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),

            // 4. Couleur du TEXTE QUE L'ON ÉCRIT
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black), // Le texte tapé sera NOIR
              bodyMedium: TextStyle(color: Colors.black), 
            ),
          ),

          // --- GESTION DE LA NAVIGATION ---
          initialRoute: '/', // Point de départ (Login)
          
          routes: {
            '/': (context) => const AuthPage(),
            '/home': (context) => const HomePage(),
            '/config': (context) => const ConfigPage(),
          },

          // Gestion des routes dynamiques (pour passer des arguments)
          onGenerateRoute: (settings) {
            if (settings.name == '/details') {
              // On extrait le nom du département envoyé depuis la HomePage
              final String deptName = settings.arguments as String;
              
              return MaterialPageRoute(
                builder: (context) => DepartmentPage(deptName: deptName),
              );
            }
            return null; // Route inconnue
          },
        );
      },
    );
  }
}