import 'package:flutter/material.dart';
import '../models/machine.dart';
import '../services/machine_service.dart';
import '../widgets/machine_card.dart';

class DepartmentPage extends StatefulWidget {
  // Le nom du département est transmis par le constructeur via onGenerateRoute
  final String deptName;
  
  const DepartmentPage({super.key, required this.deptName});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  late List<Machine> machines;

  @override
  void initState() {
    super.initState();
    // Chargement des données via le service (Abstraction)
    machines = MachineService.getMachinesByDept(widget.deptName);
  }

  // Méthode pour gérer le changement d'état et la notification
  void _toggleMachineStatus(int index) {
    setState(() {
      machines[index].toggleStatus();
    });

    // 1. Supprime immédiatement toute SnackBar existante pour éviter l'accumulation
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // 2. Affiche la nouvelle notification avec une durée de 2 secondes
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              machines[index].isOpen ? Icons.check_circle : Icons.power_settings_new,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text("${machines[index].name} est ${machines[index].statusText}"),
          ],
        ),
        backgroundColor: machines[index].isOpen ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2), // Disparaît après 2 secondes
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Département ${widget.deptName}"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: machines.isEmpty
          ? const Center(
              child: Text("Aucune machine répertoriée dans ce département."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: machines.length,
              itemBuilder: (context, index) {
                // Utilisation du Widget réutilisable (Composition)
                return MachineCard(
                  machine: machines[index],
                  onToggle: () => _toggleMachineStatus(index),
                );
              },
            ),
    );
  }
}