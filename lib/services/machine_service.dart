import '../models/machine.dart';

class MachineService {
  // Simule une base de données de machines
  static List<Machine> getMachinesByDept(String deptName) {
    switch (deptName) {
      case 'DEA':
        return [
          Machine(id: "DEA-01", name: "Four Électrique 1"),
          Machine(id: "DEA-02", name: "Four Électrique 2", initialStatus: true),
          Machine(id: "DEA-03", name: "Pont Roulant"),
        ];
      case 'DEL':
        return [
          Machine(id: "DEL-01", name: "Cage Laminoir A", initialStatus: true),
          Machine(id: "DEL-02", name: "Cisaille Volante", initialStatus: true),
        ];
      case 'DTF':
        return [
          Machine(id: "DTF-01", name: "Tréfileuse 1"),
          Machine(id: "DTF-02" , name: "Dresseuse"),
          Machine(id: "DTF-03" , name: "Embobineuse", initialStatus: true),
        ];
      default:
        return [];
    }
  }
}