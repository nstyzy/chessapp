// ignore_for_file: use_build_context_synchronously

import 'package:chessapp/components/mybutton.dart';
import 'package:chessapp/components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegPage extends StatefulWidget {
  final Function()? onTap;
  const RegPage({super.key, required this.onTap});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
  try {
    if (passwordController.text == confirmPasswordController.text) {
      if (passwordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Пароль должен содержать минимум 6 символов.'),
          ),
        );
        return;
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('percent', 0.01);
      Navigator.of(context).pop(); // Закрыть диалоговое окно после успешной регистрации
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пароли не совпадают. Пожалуйста, попробуйте еще раз.'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ошибка при регистрации: ${e.toString()}. Пожалуйста, попробуйте еще раз.'),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Text(
                  "ChessApp",
                  style: TextStyle(
                      fontSize: 36,
                      color: Color.fromRGBO(245, 91, 75, 1),
                      fontFamily: 'PottaOne'),
                ),

                const SizedBox(height: 50),

                //username
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: MyTextField(
                    controller: emailController,
                    hintText: "email",
                    obscureText: false,
                  ),
                ),

                const SizedBox(height: 10),

                // password
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: MyTextField(
                    controller: passwordController,
                    hintText: "Пароль",
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 10),

                // confirm password
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: MyTextField(
                    controller: confirmPasswordController,
                    hintText: "Повторите пароль",
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: MyButton(onTap: signUserUp, text: 'Регистрация')),

                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Уже есть аккаунт?',
                      style: TextStyle(color: Color.fromRGBO(67, 67, 67, 0.6)),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Войти',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(67, 67, 67, 0.6)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
