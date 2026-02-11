import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  // Variable privée pour stocker l'état
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Méthode pour changer le thème
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Informe l'application qu'il faut se redessiner
  }
}