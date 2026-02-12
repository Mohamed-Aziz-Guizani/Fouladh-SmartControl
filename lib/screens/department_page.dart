import 'package:flutter/material.dart';
import '../models/machine.dart';
import '../services/machine_service.dart';
import '../widgets/machine_card.dart';
import '../utils/dialog_helper.dart'; // Import du helper créé ci-dessus

class DepartmentPage extends StatefulWidget {
  final String deptName;

  const DepartmentPage({super.key, required this.deptName});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  // --- DÉPENDANCES ---
  final MachineService _machineService = MachineService();
  
  // --- ÉTAT ---
  late Future<List<Machine>> _machinesFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Méthode privée pour (re)charger les données
  void _loadData() {
    setState(() {
      _machinesFuture = _machineService.getMachinesByDept(widget.deptName);
    });
  }

  // --- LOGIQUE MÉTIER (Business Logic) ---
  
  Future<void> _handleMachineToggle(Machine machine) async {
    // 1. Demander confirmation via notre Helper (Clean Code)
    bool confirmed = await DialogHelper.showConfirmation(
      context: context, 
      machine: machine
    );

    if (!confirmed) return; // Si annulé, on arrête tout

    // 2. Feedback visuel immédiat
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Traitement en cours..."), duration: Duration(milliseconds: 500)),
    );

    // 3. Appel API
    int newState = machine.etat == 1 ? 0 : 1;
    bool success = await _machineService.toggleMachine(machine.id, newState);

    if (!mounted) return;

    // 4. Gestion du résultat
    if (success) {
      _loadData(); // Rafraîchir la liste
      _showSnackBar("Succès : État mis à jour", Colors.green);
    } else {
      _showSnackBar("Erreur : Connexion échouée", Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  // --- CONSTRUCTION DE L'UI (View) ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zone ${widget.deptName}"),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
        ],
      ),
      body: FutureBuilder<List<Machine>>(
        future: _machinesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }
          if (snapshot.hasError) {
            return _buildError(snapshot.error.toString());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmpty();
          }

          // Si tout est OK, on affiche la liste
          return _buildList(snapshot.data!);
        },
      ),
    );
  }

  // --- WIDGETS PRIVÉS (Décomposition UI) ---

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 10),
          Text("Une erreur est survenue :\n$error", textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _loadData, child: const Text("Réessayer")),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 10),
          Text("Aucune machine dans la zone ${widget.deptName}", style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildList(List<Machine> machines) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: machines.length,
      itemBuilder: (context, index) {
        final machine = machines[index];
        return MachineCard(
          machine: machine,
          onToggle: () => _handleMachineToggle(machine),
        );
      },
    );
  }
}