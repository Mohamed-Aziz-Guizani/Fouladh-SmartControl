import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instance du service pour récupérer les infos
  final AuthService _authService = AuthService();

  // Variables pour stocker les infos de l'utilisateur connecté
  String _userRole = "Chargement...";
  String _userMatricule = "";

  @override
  void initState() {
    super.initState();
    _loadUserSession(); // Charger les données au démarrage de la page
  }

  // Fonction pour récupérer les données depuis SharedPreferences via le Service
  Future<void> _loadUserSession() async {
    final userData = await _authService.getUserData();
    setState(() {
      _userRole = userData['role'] ?? "Utilisateur";
      _userMatricule = userData['matricule'] ?? "N/A";
    });
  }

  // Fonction de déconnexion centralisée
  void _handleLogout() async {
    await _authService.logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/'); // Retour au Login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text("Fouladh SmartControl"),
  actions: [
    IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        // Navigation vers la route définie dans main.dart
        Navigator.pushNamed(context, '/config');
      },
    ),
  ],
),
      
      // --- TIROIR LATÉRAL (DRAWER) ---
      drawer: Drawer(
        child: Column(
          children: [
            // Header avec rôle dynamique de la BDD
            UserAccountsDrawerHeader(
              accountName: Text(
                "Rôle : $_userRole", 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              accountEmail: Text("Matricule : $_userMatricule"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blueGrey, size: 40),
              ),
              decoration: const BoxDecoration(color: Colors.blueGrey),
            ),
            
            // Menu : Tableau de bord
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Tableau de bord"),
              onTap: () => Navigator.pop(context),
            ),
            
            // Menu : Configuration
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuration"),
              onTap: () {
                Navigator.pop(context); // Fermer le tiroir
                Navigator.pushNamed(context, '/config');
              },
            ),

            const Spacer(), // Pousse le bouton déconnexion vers le bas
            const Divider(),

            // Menu : Déconnexion
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Déconnexion", style: TextStyle(color: Colors.red)),
              onTap: _handleLogout,
            ),
          ],
        ),
      ),

      // --- CORPS DE LA PAGE (SÉLECTION DES DÉPARTEMENTS) ---
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
                "Unités de Production",
                style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildDeptCard("Aciérie (DEA)", "DEA", Icons.local_fire_department, Colors.orange),
                  _buildDeptCard("Laminoirs (DEL)", "DEL", Icons.engineering, Colors.blue),
                  _buildDeptCard("Tréfilerie (DTF)", "DTF", Icons.architecture, Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget pour les cartes de départements (Clean Code)
  Widget _buildDeptCard(String title, String code, IconData icon, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("Supervision et contrôle"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigation vers la page département avec le code en argument
          Navigator.pushNamed(context, '/details', arguments: code);
        },
      ),
    );
  }
}