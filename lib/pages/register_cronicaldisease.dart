// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/pillpal_mainpage.dart';
import 'package:flutter_application_1/services/firebase_service.dart';

import '../blocks/login_Bloc.dart';

class RegisterCronicalDisease extends StatefulWidget {
  static String id = "register_cronicaldisease";
  const RegisterCronicalDisease({Key key}) : super(key: key);

  @override
  State<RegisterCronicalDisease> createState() =>
      _RegisterCronicalDiseaseState();
}

class _RegisterCronicalDiseaseState extends State<RegisterCronicalDisease> {
  final TextEditingController _nameCronicalDiseaseController =
      TextEditingController(text: "");
  final TextEditingController _descriptionCronicalDiseaseController =
      TextEditingController(text: "");
  final TextEditingController _idController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Enfermedad Cronica'),
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
          height: 175.0,
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
          await addCronicalDiseases(
                  _nameCronicalDiseaseController.text,
                  _descriptionCronicalDiseaseController.text,
                  _idController.text)
              .then((_) => {
                    Navigator.pushNamed(context, PillPalMainPage.id)
                    // setState(() {});
                  });
        },
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
            'ID de Enfermedad',
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
      'Nombre de la Enfermedad',
      'Ejemplo: Diabetes',
      Icons.personal_injury,
      (value) {},
      TextInputType.text,
      false,
      null,
      _nameCronicalDiseaseController,
    );
  }

  Widget _textFieldEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'Descripccion de la Enfermedad',
            'Ejemplo: La diabetes es una enfermedad crónica (de larga duración) que afecta la forma en que el cuerpo convierte los alimentos en energía. ',
            Icons.text_fields,
            bloc.changeEmail,
            TextInputType.emailAddress,
            false,
            snapshot.error,
            _descriptionCronicalDiseaseController,
          );
        });
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
