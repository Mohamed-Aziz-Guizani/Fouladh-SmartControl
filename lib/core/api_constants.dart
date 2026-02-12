class ApiConstants {
  // ⚠️ Changez l'IP ici une seule fois pour tout le projet !
  // Émulateur : '10.0.2.2' | Réel : '192.168.1.X'
  static const String baseUrl = "http://10.0.2.2/fouladh_api";
  
  static const String loginEndpoint = "$baseUrl/login.php";
  static const String registerEndpoint = "$baseUrl/register.php";

  static const String getMachines = "$baseUrl/get_machines.php";
  static const String updateMachine = "$baseUrl/update_machine.php";
  static const String getMachinesByDept = "$baseUrl/get_machines_by_dept.php";
}