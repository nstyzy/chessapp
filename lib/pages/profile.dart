import 'package:chessapp/components/avatar.dart';
import 'package:chessapp/components/lvl.dart';
import 'package:chessapp/pages/auth/forgot_pw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

TextEditingController nameController = TextEditingController();

class Profile extends StatelessWidget {
  Profile({super.key});

  final user = FirebaseAuth.instance.currentUser;

  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(
        context, '/login'); // Перенаправление на страницу входа после выхода
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Убираем стрелку "назад"
        title: const Text(
          'Профиль',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(120, 120, 120, 1)),
        ),
        centerTitle: true, 
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Avatar(
                      onAvatarSelected: (int selectedAvatarIndex) {},
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 370),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 150, vertical: 8),
                        child: StatusContainer(status: Status.newbie),
                      ),
                    ),
                    Container( constraints: const BoxConstraints(maxWidth: 600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Шустрый Енот',
                                      hintStyle: TextStyle(fontSize: 15)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const SizedBox(height: 15),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(
                                      159, 159, 159, 1), // Цвет границы
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Изменение выравнивания
                                children: [
                                  Text('Email: ${user?.email ?? 'No email'}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 250.0, left: 10, right: 10),
                child: Container( constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x3416202A),
                                offset: Offset(
                                  0.0,
                                  2,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'Изменить пароль',
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.9, 0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF57636C),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => signUserOut(context),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x3416202A),
                                offset: Offset(
                                  0.0,
                                  2,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'Выйти из аккаунта',
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.9, 0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF57636C),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
