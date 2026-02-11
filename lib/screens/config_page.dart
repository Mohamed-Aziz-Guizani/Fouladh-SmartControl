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
          ListenableBuilder(
            listenable: themeService,
            builder: (context, child) {
              return SwitchListTile(
                title: const Text("Mode Sombre"),
                subtitle: const Text("Activer/Désactiver le thème nuit"),
                secondary: Icon(themeService.isDarkMode ? Icons.dark_mode : Icons.light_mode),
                value: themeService.isDarkMode,
                onChanged: (value) {
                  themeService.toggleTheme();
                },
              );
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Version"),
            subtitle: Text("1.0.0 - Stage Perfectionnement"),
          ),
        ],
      ),
    );
  }
}