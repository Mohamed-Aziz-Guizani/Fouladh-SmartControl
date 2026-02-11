import 'package:flutter/material.dart';
import '../models/department.dart';
import '../widgets/department_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Liste de données (Source de vérité pour l'UI)
  static const List<Department> _departments = [
    Department(
      name: "DEA", 
      icon: Icons.bolt, 
      themeColor: Colors.orange
    ),
    Department(
      name: "DEL", 
      icon: Icons.settings_suggest, 
      themeColor: Colors.blue
    ),
    Department(
      name: "DTF", 
      icon: Icons.precision_manufacturing, 
      themeColor: Colors.green
    ),
    Department(
      name: "MAINTENANCE", 
      icon: Icons.build_circle, 
      themeColor: Colors.blueGrey
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("El Fouladh - Accueil"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/config'),
          ),
        ],
      ),
      // Tiroir latéral (Drawer) pour le profil
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Étudiant Stagiaire"),
              accountEmail: Text("perfectionnement@elfouladh.tn"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blueGrey),
              ),
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Tableau de bord"),
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Déconnexion"),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Départements Usine",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Sélectionnez une unité pour gérer les machines :"),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: _departments.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 colonnes
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  final dept = _departments[index];
                  return DepartmentCard(
                    department: dept,
                    onTap: () {
                      // Utilisation de la route nommée avec arguments
                      Navigator.pushNamed(
                        context, 
                        '/details', 
                        arguments: dept.name
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}