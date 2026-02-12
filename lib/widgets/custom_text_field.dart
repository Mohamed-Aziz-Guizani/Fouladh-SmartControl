import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  // On définit ce qui change d'un champ à l'autre
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?) validator; // Le validateur est passé en paramètre
  final bool isPassword;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? formatters; // Pour bloquer les caractères

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.isPassword = false, // Par défaut, ce n'est pas un mot de passe
    this.keyboardType = TextInputType.text,
    this.formatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: formatters,
      // Design centralisé (Clean UI)
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Bordures arrondies
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}