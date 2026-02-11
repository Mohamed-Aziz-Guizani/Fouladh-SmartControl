import 'package:flutter/material.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Navigation vers l'accueil si validation OK
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.factory, size: 60, color: Colors.blueGrey),
                    const SizedBox(height: 10),
                    Text(
                      "El Fouladh System",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(isLogin ? "Authentification" : "Inscription"),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _matriculeController,
                      decoration: const InputDecoration(labelText: "Matricule", border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                      validator: (value) => value!.isEmpty ? "Champ requis" : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Mot de passe", border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                      validator: (value) => value!.length < 4 ? "Trop court" : null,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                        child: Text(isLogin ? "CONNEXION" : "S'INSCRIRE", style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => isLogin = !isLogin),
                      child: Text(isLogin ? "Créer un compte" : "J'ai déjà un compte"),
                    )
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