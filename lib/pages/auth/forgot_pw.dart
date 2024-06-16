// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
                "Письмо для сброса пароля отправлено на ваш адрес электронной почты."),
          );
        },
      );
    } on FirebaseAuthException {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Такого адреса Email почты не существует"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(245, 91, 75, 1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: const Text(
                    'Введите адрес электронной почты, связанный с вашей учетной записью, и мы вышлем электронное письмо с инструкциями по сбросу вашего пароля.'),
              ),
              const SizedBox(height: 10),
              //username
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                onPressed: sendPasswordResetEmail,
                color: const Color.fromRGBO(245, 91, 75, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      5.0), // Установка радиуса закругления
                ),
                elevation: 0,
                child: const Text(
                  'Восстановить пароль',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
