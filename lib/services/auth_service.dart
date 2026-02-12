import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/api_constants.dart';

class AuthService {
  
  // --- MÉTHODE DE CONNEXION (LOGIN) ---
  Future<Map<String, dynamic>> login(String matricule, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginEndpoint),
        body: {
          'matricule': matricule,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          // --- SAUVEGARDE DES INFOS DANS LE TÉLÉPHONE (OOP) ---
          final prefs = await SharedPreferences.getInstance();
          
          // On enregistre les données pour les afficher dans le Drawer plus tard
          await prefs.setString('user_role', data['role'].toString());
          await prefs.setString('user_matricule', matricule);
          await prefs.setBool('is_logged_in', true);
        }
        return data;
      } else {
        return {'status': 'error', 'message': 'Erreur serveur (${response.statusCode})'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Impossible de joindre le serveur PHP'};
    }
  }

  // --- MÉTHODE D'INSCRIPTION (REGISTER) ---
  Future<Map<String, dynamic>> register(String matricule, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.registerEndpoint),
        body: {
          'matricule': matricule,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'status': 'error', 'message': 'Erreur lors de l\'inscription'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Erreur de connexion réseau'};
    }
  }

  // --- MÉTHODE DE DÉCONNEXION (LOGOUT) ---
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // On vide le coffre-fort quand l'utilisateur quitte
    await prefs.clear(); 
  }

  // --- MÉTHODE POUR RÉCUPÉRER LES INFOS ENREGISTRÉES ---
  // Utile pour le Drawer
  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'role': prefs.getString('user_role') ?? 'Utilisateur',
      'matricule': prefs.getString('user_matricule') ?? 'N/A',
    };
  }
}