import 'package:flutter/material.dart';
import '../models/machine.dart';

class DialogHelper {
  // Méthode statique pour afficher la confirmation
  static Future<bool> showConfirmation({
    required BuildContext context,
    required Machine machine,
  }) async {
    final bool isRunning = machine.etat == 1;
    final String actionText = isRunning ? "ARRÊTER" : "DÉMARRER";
    final Color actionColor = isRunning ? Colors.red : Colors.green;

    // Affiche le dialogue et attend la réponse (true ou null)
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orange),
            const SizedBox(width: 10),
            const Text("Confirmation"),
          ],
        ),
        content: Text.rich(
          TextSpan(
            text: "Voulez-vous vraiment ",
            style: const TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: actionText,
                style: TextStyle(color: actionColor, fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: " la machine \n"),
              TextSpan(
                text: machine.nom,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: " ?"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Annuler
            child: const Text("Annuler", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: actionColor),
            onPressed: () => Navigator.pop(context, true), // Confirmer
            child: const Text("CONFIRMER", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    return result ?? false; // Retourne false si l'utilisateur clique à côté (bien que bloqué ici)
  }
}