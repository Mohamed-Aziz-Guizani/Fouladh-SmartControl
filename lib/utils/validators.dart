class Validators {
  static String? validateMatricule(String? value) {
    if (value == null || value.isEmpty) {
      return "Matricule requis";
    }
    if (value.length != 5) {
      return "Le matricule doit faire exactement 5 chiffres";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Mot de passe requis";
    }
    if (value.length < 4) {
      return "Mot de passe trop court";
    }
    return null;
  }
}