import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_service.dart';

import '../blocks/login_Bloc.dart';

class RegisterUser extends StatefulWidget {
  static String id = "register_user";
  const RegisterUser({Key key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final TextEditingController _userController = TextEditingController(text: "");
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  final TextEditingController _roleController = TextEditingController(text: "");
  final TextEditingController _idController = TextEditingController(text: "");

  Future SingUp() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

    await userCredential.user
        .updateProfile(displayName: _userController.text.trim());
  }

  void updateDisplayName(String newDisplayName) async {
    try {
      User user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateProfile(displayName: newDisplayName);
        await user
            .reload(); // Recarga los datos del usuario después de la actualización
        user = FirebaseAuth
            .instance.currentUser; // Actualiza la referencia al usuario
        print('DisplayName actualizado: ${user.displayName}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Usuario'),
          // backgroundColor: Colors.black,
          backgroundColor: Color.fromARGB(255, 62, 100, 104),
        ),
        body: SingleChildScrollView(
          child: _columnSingUp(LoginBloc()),
        ),
      ),
    );
  }

  Widget _columnSingUp(LoginBloc bloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 25.0,
        ),
        _textFieldID(bloc),
        const SizedBox(
          height: 25.0,
        ),
        _textFieldUser(),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldEmail(bloc),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldPassword(bloc),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldRole(),
        const SizedBox(
          height: 75.0,
        ),
        _buttonSingUp(),
      ],
    );
  }

  Widget _buttonSingUp() {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 110.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () async {
          await addUser(
                  _userController.text,
                  _emailController.text,
                  _passwordController.text,
                  _roleController.text,
                  _idController.text)
              .then((_) => {
                    Navigator.pop(context),
                  });
          updateDisplayName(_userController.text.trim());
          SingUp();
        },
        // color: const Color.fromARGB(255, 0, 0, 0),
        color: Color.fromARGB(255, 62, 100, 104),
        child: Text(
          'Registrar'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _textFieldID(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'ID de Usuario',
            'Ejemplo: 0123456789',
            Icons.numbers,
            bloc.changeEmail,
            TextInputType.text,
            false,
            snapshot.error,
            _idController,
          );
        });
  }

  Widget _textFieldUser() {
    return _TextFieldGeneral(
      'Nombre de Usuario',
      'Ejemplo: Jaime Juarez',
      Icons.person,
      (value) {},
      TextInputType.text,
      false,
      null,
      _userController,
    );
  }

  Widget _textFieldEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'Correo Electronico',
            'Ejemplo: ExampleMail@mail.com',
            Icons.email_outlined,
            bloc.changeEmail,
            TextInputType.emailAddress,
            false,
            snapshot.error,
            _emailController,
          );
        });
  }

  Widget _textFieldPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'Contraseña',
            'Ejemplo: 123456',
            Icons.lock_outline_rounded,
            bloc.changePassword,
            null,
            true,
            snapshot.error,
            _passwordController,
          );
        });
  }

  Widget _textFieldRole() {
    return _TextFieldGeneral(
        'Rol de Usuario',
        'Ejemplo: user or admin',
        Icons.person_pin,
        (value) {},
        TextInputType.text,
        false,
        null,
        _roleController);
  }
}

class _TextFieldGeneral extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  // final void Function() onChanged;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final String errorText;
  final TextEditingController controller;
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
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
