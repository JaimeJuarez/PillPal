// ignore: unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/pages/edit_user.dart';
import 'package:flutter_application_1/pages/inventary_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
// import 'package:flutter_application_1/pages/register_user.dart';
import 'package:flutter_application_1/services/firebase_service.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl_browser.dart' as intl_browser;
// import 'package:prueba/pages/inventory_page.dart';

class Pastillas extends StatefulWidget {
  static String id = "Pastillas";

  const Pastillas({Key key}) : super(key: key);

  @override
  State<Pastillas> createState() => _PastillasState();
}

class _PastillasState extends State<Pastillas> {
  int _paginaActual = 0;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final List<Widget> _paginas = <Widget>[
    const PaginaUsers(),
    const InventaryPage(),
  ];
  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _paginaActual == 0
              ? const Text('Pastillas')
              : const Text("Inventory Page"),
          backgroundColor: Color.fromARGB(255, 62, 100, 104),
          leading: IconButton(
            icon: _paginaActual == 0
                ? const Icon(Icons.medical_information)
                : const Icon(Icons.medical_services),
            onPressed: () {},
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Sing Out',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Hoobie')),
                    onTap: () async {
                      await _firebaseAuth.signOut();
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
        body: StreamBuilder<User>(
          stream: _firebaseAuth.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return _paginas[_paginaActual];
            } else {
              return const Center(
                child: Text("No hay datos"),
              );
            }
          }),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   onTap: (index) {
        //     setState(() {
        //       _paginaActual = index;
        //     });
        //   },
        //   currentIndex: _paginaActual,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: "Users",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_cart),
        //       label: "Inventory",
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class PaginaUsers extends StatefulWidget {
  const PaginaUsers({Key key}) : super(key: key);

  @override
  State<PaginaUsers> createState() => _PaginaUsersState();
}

class _PaginaUsersState extends State<PaginaUsers> {
  @override
  Widget build(context) {
    return const Center(
      child: Cards(),
    );
  }
}

class ProximaTomaInfo {
  final String proximaTomaFormatted;
  final int minutosRestantes;
  final int horasRestantes;

  ProximaTomaInfo(
      this.proximaTomaFormatted, this.minutosRestantes, this.horasRestantes);
}

ProximaTomaInfo calcularProximaToma(String horaRegistrada, String horasDosis) {
  initializeDateFormatting();

  // No es necesario parsear la hora registrada nuevamente si ya es un formato válido de hora
  // Solo convierte la cadena de la hora a un objeto DateTime
  DateTime horaRegistradaParsed = DateTime.parse('1970-01-01 $horaRegistrada');

  // Obtener la fecha y hora actual en UTC
  DateTime ahoraUtc = DateTime.now().toUtc();

  // Convertir la hora actual de UTC a UTC-6
  DateTime ahoraUtcMinus6 = ahoraUtc.subtract(Duration(hours: 6));

  // Crear objetos DateTime completos para ambos, proximaToma y ahora
  DateTime proximaToma = DateTime(
    ahoraUtcMinus6.year,
    ahoraUtcMinus6.month,
    ahoraUtcMinus6.day,
    horaRegistradaParsed.hour,
    horaRegistradaParsed.minute,
  );

  // Sumar las horas de la dosis
  int horasDosisInt = int.parse(horasDosis);
  proximaToma = proximaToma.add(Duration(hours: horasDosisInt));

  // Calcular el tiempo restante en minutos
  int minutosRestantes = proximaToma.difference(ahoraUtcMinus6).inMinutes;

  // Convertir minutos a horas y redondear
  int horasRestantes = (minutosRestantes / 60).round();

  // Formatear la próxima hora de toma en el formato deseado
  String proximaTomaFormatted = DateFormat.jm().format(proximaToma);

  return ProximaTomaInfo(
    proximaTomaFormatted,
    minutosRestantes,
    horasRestantes,
  );
}

class Cards extends StatefulWidget {
  const Cards({Key key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getMedicamentos(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              if (snapshot.hasData) {
                ProximaTomaInfo info = calcularProximaToma(
                  snapshot.data[index]["hora_registrada"],
                  snapshot.data[index]["horas_dosis"],
                );
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[index]["name"]),
                    subtitle: Text(
                      '(Próxima dosis a las ${info.proximaTomaFormatted}, en ${info.horasRestantes} horas)',
                    ),
                    leading: const Icon(Icons.medication_sharp),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
