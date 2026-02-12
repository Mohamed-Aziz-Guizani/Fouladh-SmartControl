class Machine {
  final String id;
  final String nom;
  final String dept;
  final String ip;
  final int etat; // 1 = Marche, 0 = Arrêt

  Machine({
    required this.id,
    required this.nom,
    required this.dept,
    required this.ip,
    required this.etat,
  });

  // Factory : Transforme le JSON reçu du PHP en Objet Dart
  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      id: json['id_machine'].toString(),
      nom: json['nom_machine'],
      dept: json['dept'],
      ip: json['ip_automate'] ?? 'Non défini',
      // Parfois le PHP renvoie "1" (String) au lieu de 1 (Int), on sécurise :
      etat: int.parse(json['etat'].toString()), 
    );
  }
}