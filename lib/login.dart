import 'package:flutter/material.dart';

import 'api.dart';
import 'register.dart';
import 'todo.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: userCtrl, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: () async {
                bool ok = await ApiService.login(userCtrl.text, passCtrl.text);
                if (ok) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const TodoScreen()),
                  );
                }
              },
            ),
            TextButton(
              child: const Text("Register"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
