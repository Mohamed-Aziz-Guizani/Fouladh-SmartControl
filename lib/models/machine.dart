class Machine {
  final String id;
  final String name;
  bool _status; // Privé (Encapsulation)

  Machine({required this.id, required this.name, bool initialStatus = false}) 
      : _status = initialStatus;

  // Getter pour lire le statut
  bool get isOpen => _status;

  // Méthode pour modifier le statut (Logique métier centralisée)
  void toggleStatus() {
    _status = !_status;
  }

  String get statusText => _status ? "EN MARCHE" : "ARRÊT";
}