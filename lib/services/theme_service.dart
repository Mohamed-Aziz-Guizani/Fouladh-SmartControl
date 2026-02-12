import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  bool _isDarkMode = false;
  static const String _key = "isDarkMode";

  bool get isDarkMode => _isDarkMode;

  ThemeService() {
    _loadFromPrefs(); // Charger le choix au démarrage
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    
    // Sauvegarde OOP
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, _isDarkMode);
  }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_key) ?? false;
    notifyListeners();
  }
}