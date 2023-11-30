import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../blocks/login_Bloc.dart';

class EditMedicine extends StatefulWidget {
  static String id = "edit_medicine";
  const EditMedicine({Key key, this.medicineID}) : super(key: key);
  final String medicineID;

  @override
  State<EditMedicine> createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
  final TextEditingController _nombreMedicamentoController =
      TextEditingController(text: "");
  final TextEditingController _diasCumplidosController =
      TextEditingController(text: "");
  final TextEditingController _diasMaximosController =
      TextEditingController(text: "");
  final TextEditingController _horasDosisController =
      TextEditingController(text: "");
  String hora = '';
  // final TextEditingController _idController = TextEditingController(text: "");
  final bloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Tratamiento'),
          backgroundColor: Color.fromARGB(255, 62, 100, 104),
        ),
        body: FutureBuilder(
          future: getMedicamentosByID(widget.medicineID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              _nombreMedicamentoController.text = snapshot.data["name"];
              _diasCumplidosController.text = snapshot.data["dias_cumplidos"];
              _diasMaximosController.text = snapshot.data["dias_maximos"];
              _horasDosisController.text = snapshot.data["horas_dosis"];
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
                  _buttonEditMedicine(widget.medicineID),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buttonEditMedicine(id) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 110.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () async {
          hora = getFormattedCurrentTime();
          await editMedicamentos(
                  _nombreMedicamentoController.text,
                  _diasCumplidosController.text,
                  _diasMaximosController.text,
                  _horasDosisController.text,
                  hora,
                  id)
              .then((_) => {
                    setState(() {}),
                    Navigator.pop(context),
                  });
        },
        color: Color.fromARGB(255, 62, 100, 104),
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
      'Nombre de Medicamento',
      'Ejemplo: Paracetamol',
      Icons.medication,
      (value) {},
      TextInputType.text,
      false,
      null,
      _nombreMedicamentoController,
    );
  }

  Widget _textFieldEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'Dias Cumplidos Con la Dosis',
            'Ejemplo: 8',
            Icons.medical_information,
            bloc.changeEmail,
            TextInputType.text,
            false,
            snapshot.error,
            _diasCumplidosController,
          );
        });
  }

  Widget _textFieldPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _TextFieldGeneral(
            'Dias Maximas de Dosis',
            'Ejemplo: 20',
            Icons.add,
            bloc.changeEmail,
            null,
            false,
            snapshot.error,
            _diasMaximosController,
          );
        });
  }

  Widget _textFieldRol() {
    return _TextFieldGeneral(
        'Cada cuantas horas tomar una Dosis',
        'Ejemplo: 8',
        Icons.lock_clock,
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
  String formattedTime = DateFormat('hh:mm a', 'es').format(now);
  return formattedTime;
}
