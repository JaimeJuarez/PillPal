// ignore_for_file: unused_import

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocks/provider.dart';
import 'package:flutter_application_1/pages/cronicalDisease.dart';
import 'package:flutter_application_1/pages/register_user.dart';
import 'package:flutter_application_1/pages/user_page.dart';
import 'package:flutter_application_1/pages/tratamientos.dart';

class LoginPage extends StatefulWidget {
  static String id = "login_page";

  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = FirebaseAuth.instance.currentUser;
  bool selectLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Future SingIn() async {
  //   try {
  //     final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim());
  //     if (user != null) {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return const CronicalDisease();
  //       }));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future SingIn() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final user = userCredential.user;

      if (user != null) {
        String userName = user.displayName ?? 'Usuario Desconocido';

        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CronicalDisease(userName: userName);
              },
            ),
          );
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ProviderLogin.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: CustomAppBar(),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 110, 0, 0),
                      // padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: const Text(
                          "PILL PAL",
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromARGB(255, 22, 22, 22),
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // const SizedBox(height: 35.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [],
                ),
                _columnLogin(bloc),
              ],
            ),
          )),
      // ),
    );
  }

  Widget _buttonLogin() {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 125.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          SingIn();
        },
        // color: const Color.fromARGB(255, 0, 0, 0),
        color: Color.fromARGB(255, 62, 100, 104),
        child: Text(
          'Entrar'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _forgotPassword() {
    return Container(
      alignment: const Alignment(1, 0),
      padding: const EdgeInsets.only(top: 0, right: 30.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RegisterUser.id);
        },
        child: const Text(
          'Crear Nuevo Usuario',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Heebo',
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmailLogin(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return _TextFieldGeneral(
            'Correo Electronico', 'ExampleMail@mail.com', Icons.mail_outline,
            // bloc.changeEmail,
            (value) {
          // email = value;
        }, TextInputType.emailAddress, false, snapshot.error, _emailController);
      },
    );
  }

  Widget _textFieldPasswordLogin(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return _TextFieldGeneral(
            'Contraseña', 'Ejemplo: 123456', Icons.lock_outline_rounded,
            // bloc.changePassword,
            (value) {
          // password = value;
        }, null, true, snapshot.error, _passwordController);
      },
    );
  }

  Widget _columnLogin(LoginBloc bloc) {
    return Column(
      children: [
        const SizedBox(
          height: 25.0,
        ),
        // Center(
        //   child: Image(
        //       image: const AssetImage('assets/icon/ebook.png'), height: 100),
        // ),
        const SizedBox(
          height: 25.0,
        ),
        _textFieldEmailLogin(bloc),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldPasswordLogin(bloc),
        const SizedBox(
          height: 25.0,
        ),
        _forgotPassword(),
        const SizedBox(
          height: 65.0,
        ),
        _buttonLogin(),
        const SizedBox(
          height: 25.0,
        ),
        // _buttonRegister(),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 62, 100, 104),
            Color.fromARGB(255, 34, 54, 66),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container(
          //   width: 1,
          // )
          SizedBox(height: 35.0)
        ],
      ),
    );
  }
}

class _TextFieldGeneral extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  // final void Function() onChanged;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final String errorText;
  const _TextFieldGeneral(
    this.labelText,
    this.hintText,
    this.icon,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.errorText,
    this.controller,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
