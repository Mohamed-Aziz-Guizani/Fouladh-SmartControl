import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_text_field.dart'; 
import '../utils/validators.dart';          
import '../services/auth_service.dart';     

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
 
  // Le service qui parle au serveur (PHP)
  final AuthService _authService = AuthService(); 
  
  // La clé pour valider le formulaire
  final _formKey = GlobalKey<FormState>();
  
  // Les contrôleurs pour récupérer le texte
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Les variables d'état (La mémoire de la page)
  bool _isLoginMode = true; // true = Connexion, false = Inscription
  bool _isLoading = false;  // true = Affiche le rond qui tourne

  // Basculer entre Connexion et Inscription
  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _formKey.currentState?.reset(); // Efface les messages d'erreur rouges
    });
  }

  // Envoyer le formulaire
  Future<void> _submitForm() async {
    // Si le formulaire n'est pas valide (ex: matricule < 5), on arrête tout
    if (!_formKey.currentState!.validate()) return;

    // On affiche le chargement
    setState(() => _isLoading = true);

    // On récupère les valeurs
    final String matricule = _matriculeController.text;
    final String password = _passController.text;
    
    Map<String, dynamic> result;

    // On appelle le Service (Clean Code)
    try {
      if (_isLoginMode) {
        result = await _authService.login(matricule, password);
      } else {
        result = await _authService.register(matricule, password);
      }
      
      // On traite la réponse
      _handleResponse(result);

    } catch (e) {
      // Erreur grave (ex: crash du code)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur interne : $e"), backgroundColor: Colors.red),
      );
    }
    
    // On cache le chargement
    setState(() => _isLoading = false);
  }

  // Gérer la réponse du serveur (Succès ou Erreur)
  void _handleResponse(Map<String, dynamic> response) {
    if (!mounted) return; // Sécurité Flutter

    if (response['status'] == 'success') {
      // --- SUCCÈS ---
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isLoginMode ? "Connexion réussie !" : "Compte créé ! Connectez-vous."),
          backgroundColor: Colors.green,
        ),
      );

      if (_isLoginMode) {
        // Vers l'accueil
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Après inscription, on retourne sur le login et on vide le mot de passe
        _toggleMode(); 
        _passController.clear();
      }
    } else {
      // --- ERREUR (ex: Mauvais mot de passe) ---
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message'] ?? "Erreur inconnue"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // LOGO
                    Image.asset('assets/images/elfouladh_logo.png', height: 100),
                    const SizedBox(height: 30),

                    // TITRE
                    Text(
                      _isLoginMode ? "Connexion" : "Inscription",
                      style: const TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.blueGrey
                      ),
                    ),
                    const SizedBox(height: 25),

                    // CHAMP MATRICULE (Utilise notre Widget Custom)
                    CustomTextField(
                      controller: _matriculeController,
                      label: "Matricule",
                      icon: Icons.person,
                      validator: Validators.validateMatricule,
                      keyboardType: TextInputType.number,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5),
                      ],
                    ),
                    
                    const SizedBox(height: 15),

                    // CHAMP PASSWORD (Utilise notre Widget Custom)
                    CustomTextField(
                      controller: _passController,
                      label: "Mot de passe",
                      icon: Icons.lock,
                      validator: Validators.validatePassword,
                      isPassword: true,
                    ),
                    
                    const SizedBox(height: 25),

                    // BOUTON D'ACTION
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isLoginMode ? Colors.blueGrey : Colors.green[700],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text(
                                _isLoginMode ? "SE CONNECTER" : "S'INSCRIRE",
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                    ),

                    // BOUTON BASCULE
                    TextButton(
                      onPressed: _toggleMode,
                      child: Text(_isLoginMode ? "Créer un compte" : "J'ai déjà un compte"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}