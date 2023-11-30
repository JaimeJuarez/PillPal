// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../blocks/login_Bloc.dart';

class RegisterMedicine extends StatefulWidget {
  static String id = "register_medicine";
  const RegisterMedicine({Key key}) : super(key: key);

  @override
  State<RegisterMedicine> createState() => _RegisterMedicineState();
}

class _RegisterMedicineState extends State<RegisterMedicine> {
  final TextEditingController _nameMedicineController =
      TextEditingController(text: "");
  final TextEditingController _diasCumplidosController =
      TextEditingController(text: "");
  final TextEditingController _diasMaximosController =
      TextEditingController(text: "");
  final TextEditingController _horasDosisController =
      TextEditingController(text: "");
  final TextEditingController _idController = TextEditingController(text: "");
  String hora = '';

  // Future SingUp() async {
  //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _diasCumplidosController.text.trim(),
  //       password: _diasMaximosController.text.trim());
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agregar nuevo Tratamiento'),
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
        _textFieldNameMedicine(),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldDiasCumplidos(bloc),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldDiasMaximos(bloc),
        const SizedBox(
          height: 15.0,
        ),
        _textFieldHorasDosis(),
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
          hora = getFormattedCurrentTime();
          await addMedicamentos(
                  _nameMedicineController.text,
                  _diasCumplidosController.text,
                  _diasMaximosController.text,
                  _horasDosisController.text,
                  hora,
                  _idController.text)
              .then((_) => {
                    Navigator.pop(context),
                  });
          // SingUp();
        },
        color: Color.fromARGB(255, 62, 100, 104),
        child: Text(
          'Agregar'.toUpperCase(),
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
            'ID De Medicamento',
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

  Widget _textFieldNameMedicine() {
    return _TextFieldGeneral(
      'Nombre del Medicamento',
      'Ejemplo: Paracetamol',
      Icons.medication,
      (value) {},
      TextInputType.text,
      false,
      null,
      _nameMedicineController,
    );
  }

  Widget _textFieldDiasCumplidos(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'Dias Cumplidos de Dosis',
            'Ejemplo: 3',
            Icons.calendar_today,
            bloc.changeEmail,
            TextInputType.emailAddress,
            false,
            snapshot.error,
            _diasCumplidosController,
          );
        });
  }

  Widget _textFieldDiasMaximos(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'Dias Maximos de Dosis',
            'Ejemplo: 20',
            Icons.calendar_today,
            bloc.changePassword,
            null,
            false,
            snapshot.error,
            _diasMaximosController,
          );
        });
  }

  Widget _textFieldHorasDosis() {
    return _TextFieldGeneral(
        'Cada cuantas horas tomar dosis',
        'Ejemplo: 8hrs',
        Icons.punch_clock,
        (value) {},
        TextInputType.text,
        false,
        null,
        _horasDosisController);
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

String getFormattedCurrentTime() {
  initializeDateFormatting('es'); // Ajusta el idioma según tus preferencias
  DateTime now = DateTime.now()
      .toUtc()
      .subtract(Duration(hours: 6)); // Ajusta la zona horaria a UTC-6
  String formattedTime = DateFormat('HH:mm', 'es').format(now);
  return formattedTime;
}
