import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_service.dart';

import '../blocks/login_Bloc.dart';

class EditUser extends StatefulWidget {
  static String id = "edit_user";
  const EditUser({Key key, this.userID}) : super(key: key);
  final String userID;

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _nombreUsuarioController =
      TextEditingController(text: "");
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  final TextEditingController _rolController = TextEditingController(text: "");
  // final TextEditingController _idController = TextEditingController(text: "");
  final bloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Usuario'),
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
          future: getUsersByID(widget.userID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              _nombreUsuarioController.text = snapshot.data["name"];
              _emailController.text = snapshot.data["email"];
              _passwordController.text = snapshot.data["password"];
              _rolController.text = snapshot.data["rol"];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  _textFieldUserName(),
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
                  _textFieldRol(),
                  const SizedBox(
                    height: 75.0,
                  ),
                  _buttonEditUser(widget.userID),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buttonEditUser(id) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 110.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () async {
          await editUser(_nombreUsuarioController.text, _emailController.text,
                  _passwordController.text, _rolController.text, id)
              .then((_) => {
                    setState(() {}),
                    Navigator.pop(context),
                  });
        },
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Text(
          'Editar'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _textFieldUserName() {
    return _TextFieldGeneral(
      'Nombre de usuario',
      'Ejemplo: Jaime Juarez',
      Icons.person,
      (value) {},
      TextInputType.text,
      false,
      null,
      _nombreUsuarioController,
    );
  }

  Widget _textFieldEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'Correo electrónico',
            'Ejemplo: ExampleMail@mail.com',
            Icons.email_outlined,
            bloc.changeEmail,
            TextInputType.text,
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
            bloc.changeEmail,
            null,
            true,
            snapshot.error,
            _passwordController,
          );
        });
  }

  Widget _textFieldRol() {
    return _TextFieldGeneral(
        'Rol del usuario',
        'Ejemplo: Administrador o Usuario',
        Icons.person_pin,
        (value) {},
        TextInputType.text,
        false,
        null,
        _rolController);
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
