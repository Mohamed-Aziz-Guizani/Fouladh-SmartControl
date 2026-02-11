import 'package:flutter/material.dart';
import '../models/machine.dart';

class MachineCard extends StatelessWidget {
  final Machine machine;
  final VoidCallback onToggle;

  const MachineCard({super.key, required this.machine, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.power_settings_new, 
          color: machine.isOpen ? Colors.green : Colors.red,
          size: 35
        ),
        title: Text(machine.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${machine.id} - ${machine.statusText}"),
        trailing: Switch(
          value: machine.isOpen,
          onChanged: (_) => onToggle(),
          activeColor: Colors.green,
        ),
      ),
    );
  }
}