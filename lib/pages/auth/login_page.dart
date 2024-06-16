// ignore_for_file: use_build_context_synchronously

import 'package:chessapp/components/mybutton.dart';
import 'package:chessapp/components/mytextfield.dart';
import 'package:chessapp/pages/auth/forgot_pw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogPage extends StatefulWidget {
  final Function()? onTap;
  const LogPage({super.key, required this.onTap});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Чтобы пользователь не мог закрыть диалоговое окно
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(245, 91, 75, 1),
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.of(context)
          .pop(); // Закрыть диалоговое окно после успешного входа
    } catch (e) {
      Navigator.of(context)
          .pop(); // Закрыть диалоговое окно при возникновении ошибки

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Неверный логин или пароль. Пожалуйста, попробуйте еще раз.'),
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
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: MyTextField(
                    controller: emailController,
                    hintText: "email",
                    obscureText: false,
                  ),
                ),

                const SizedBox(height: 10),

                //password
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: MyTextField(
                    controller: passwordController,
                    hintText: "Пароль",
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgotPassword();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Забыли пароль?',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(67, 67, 67, 0.6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: MyButton(onTap: signUserIn, text: 'Войти')),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Нет аккаунта?',
                      style: TextStyle(color: Color.fromRGBO(67, 67, 67, 0.6)),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(67, 67, 67, 0.6)),
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
