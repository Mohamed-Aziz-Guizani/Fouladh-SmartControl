import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_constants.dart';
import '../models/machine.dart';

class MachineService {

Future<List<Machine>> getMachinesByDept(String deptName) async {
  try {
    final response = await http.post(
      Uri.parse(ApiConstants.getMachinesByDept),
      body: {
        'dept': deptName, // On envoie "DEA" ou "DEL" au PHP
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Machine.fromJson(item)).toList();
    } else {
      return []; // Retourne une liste vide en cas d'erreur
    }
  } catch (e) {
    print("Erreur Service : $e");
    return [];
  }
}
  // Récupérer la liste des machines
  Future<List<Machine>> fetchMachines() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.getMachines));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        // On transforme la liste JSON en liste d'objets Machine
        List<Machine> machines = body.map((dynamic item) => Machine.fromJson(item)).toList();
        return machines;
      } else {
        throw Exception("Erreur chargement machines");
      }
    } catch (e) {
      throw Exception("Erreur connexion : $e");
    }
  }

  // Changer l'état (ON/OFF)
  Future<bool> toggleMachine(String id, int newEtat) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.updateMachine),
        body: {
          'id_machine': id,
          'etat': newEtat.toString(),
        },
      );
      
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['status'] == 'success';
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}