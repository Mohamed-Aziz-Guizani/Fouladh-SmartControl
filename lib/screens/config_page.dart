import 'package:flutter/material.dart';
import '../main.dart'; // Pour accéder à themeService

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuration")),
      body: ListView(
        children: [
          _buildSectionTitle("Apparence"),
          _buildThemeSwitch(),

          const Divider(),
          _buildSectionTitle("À propos"),
          _buildInfoTile(),
        ],
      ),
    );
  }

  // --- COMPOSANTS UI (Clean Code - Décomposition) ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildThemeSwitch() {
    return ListenableBuilder(
      listenable: themeService,
      builder: (context, child) {
        return SwitchListTile(
          title: const Text("Mode Sombre"),
          subtitle: const Text("Optimiser l'affichage pour la nuit"),
          secondary: Icon(
            themeService.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: themeService.isDarkMode ? Colors.orangeAccent : Colors.blueGrey,
          ),
          value: themeService.isDarkMode,
          onChanged: (value) => themeService.toggleTheme(),
        );
      },
    );
  }

 

  Widget _buildInfoTile() {
    return const ListTile(
      leading: Icon(Icons.info_outline),
      title: Text("Version de l'application"),
      subtitle: Text("1.0.0 - El Fouladh SmartControl"),
      trailing: Text("PFE", style: TextStyle(color: Colors.grey)),
    );
  }
}