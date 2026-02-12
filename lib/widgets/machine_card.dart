import 'package:flutter/material.dart';
import '../models/machine.dart'; // Assurez-vous que le nom du fichier est bon

class MachineCard extends StatelessWidget {
  final Machine machine;
  final VoidCallback onToggle; // La fonction déclenchée quand on clique sur le switch

  const MachineCard({
    super.key, 
    required this.machine, 
    required this.onToggle
  });

  @override
  Widget build(BuildContext context) {
    // On traduit l'état (int) en booléen pour l'affichage
    final bool isRunning = machine.etat == 1;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      // Bordure colorée subtile selon l'état (Vert = OK, Rouge = Arrêt)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isRunning ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          // 1. ICÔNE (Rond coloré)
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isRunning ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.power_settings_new, 
              color: isRunning ? Colors.green : Colors.red,
              size: 28
            ),
          ),

          // 2. TEXTES (Nom + IP)
          title: Text(
            machine.nom, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              // Affichage de l'IP (Important pour la maintenance)
              Text("IP: ${machine.ip}", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              // Texte d'état explicite
              Text(
                isRunning ? "EN MARCHE" : "À L'ARRÊT",
                style: TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.bold,
                  color: isRunning ? Colors.green[700] : Colors.red[700]
                ),
              ),
            ],
          ),

          // 3. INTERRUPTEUR
          trailing: Switch(
            value: isRunning,
            activeColor: Colors.white,
            activeTrackColor: Colors.green,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.red,
            onChanged: (_) {
              // On appelle la fonction parent (qui affichera le popup de confirmation)
              onToggle(); 
            },
          ),
        ),
      ),
    );
  }
}