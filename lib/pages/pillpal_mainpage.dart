// ignore_for_file: unused_import

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocks/provider.dart';
import 'package:flutter_application_1/pages/cronicalDisease.dart';
import 'package:flutter_application_1/pages/pastillas.dart';
import 'package:flutter_application_1/pages/register_user.dart';
import 'package:flutter_application_1/pages/user_page.dart';
import 'package:flutter_application_1/pages/tratamientos.dart';
import 'package:flutter_application_1/services/firebase_service.dart';

import 'login_page.dart';

class PillPalMainPage extends StatefulWidget {
  static String id = "pillpalpage";

  const PillPalMainPage({Key key}) : super(key: key);

  @override
  State<PillPalMainPage> createState() => _PillPalMainPageState();
}

class _PillPalMainPageState extends State<PillPalMainPage> {
  int _paginaActual = 0;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // final bloc = ProviderLogin.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(63.0),
          child: AppBar(
            title: Center(
              child: _paginaActual == 0
                  ? Text(
                      'PILL PAL',
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                    )
                  : Text("Inventory Page"),
            ),
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
        ),
        // body: PaginaUsers()
        body: ListView(
          children: [
            SizedBox(height: 20),
            Divider(
              color: Colors.black,
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            GestureDetector(
              onTap: () {
                // Manejar la acción onTap aquí
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Tratamientos();
                }));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 3),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255), // Fondo de color
                  borderRadius: BorderRadius.circular(20.0), // Bordes redondos
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 175, 201, 184), // Fondo circular de color
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.notifications,
                        color: Color.fromARGB(
                            255, 62, 100, 104), // Color del icono
                        size: 24,
                      ),
                    ),
                    SizedBox(
                        width:
                            10), // Ajusta el espacio entre el icono y el texto según tus necesidades
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "TRATAMIENTOS",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                            letterSpacing: 3,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          "• ESTABLECER / MODIFICAR",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                          ),
                        ),
                        Text(
                          "  TRATAMIENTOS Y PASTILLAS",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Pastillas();
                }));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 3),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255), // Fondo de color
                  borderRadius: BorderRadius.circular(20.0), // Bordes redondos
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 175, 201, 184), // Fondo circular de color
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.medication_sharp,
                        color: Color.fromARGB(
                            255, 62, 100, 104), // Color del icono
                        size: 24,
                      ),
                    ),
                    SizedBox(
                        width:
                            10), // Ajusta el espacio entre el icono y el texto según tus necesidades
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "PASTILLAS",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                            letterSpacing: 3,
                          ),
                        ),
                        Text(
                          "• REVISAR LA CANTIDAD DE",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                          ),
                        ),
                        Text(
                          "  PASTILLAS DISPONIBLES",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            GestureDetector(
              onTap: () {
                // Manejar la acción onTap aquí
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PaginaUsers();
                }));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 3),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255), // Fondo de color
                  borderRadius: BorderRadius.circular(20.0), // Bordes redondos
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 175, 201, 184), // Fondo circular de color
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.medication_sharp,
                        color: Color.fromARGB(
                            255, 62, 100, 104), // Color del icono
                        size: 24,
                      ),
                    ),
                    SizedBox(
                        width:
                            10), // Ajusta el espacio entre el icono y el texto según tus necesidades
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ENFERMEDADES",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                            letterSpacing: 3,
                          ),
                        ),
                        Text(
                          "• INFORMACION SOBRE",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                          ),
                        ),
                        Text(
                          "  ENFEREMEDADES CRONICAS",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 62, 100, 104),
                            fontFamily: 'Heebo',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
              margin: EdgeInsets.fromLTRB(10, 20, 10, 3),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 175, 201, 184), // Fondo de color
                borderRadius: BorderRadius.circular(20.0), // Bordes redondos
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: const Text(
                        "CONSEJO MEDICO",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(
                                255, 62, 100, 104), // Color del texto
                            fontFamily: 'Heebo',
                            // decoration: TextDecoration.underline,
                            letterSpacing: 3),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "•Beber suficiente agua a lo largo del día es fundamental para mantener una buena salud. El agua ayuda a mantener el equilibrio de fluidos en el cuerpo, mejora la función renal y ayuda en la digestión. Además, puede tener beneficios para la piel y ayudar a prevenir la deshidratación. Intenta establecer el hábito de mantener una hidratación adecuada todos los días.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white, // Color del texto
                          fontFamily: 'Heebo',
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: const [],
                  // ),
                  // _columnLogin(bloc),
                ],
              ),
            ),
            // PaginaUsers()
          ],
        ),
// Container(
//   color: Colors.white, // Fondo blanco
//   height: double.infinity, // Altura que ocupa el resto de la pantalla
// )
      ),
      // ),
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
    // const SizedBox(height: 35.0);
    // _Singup
    return const Center(
      child: Cards(),
    );
  }
}

class Cards extends StatefulWidget {
  const Cards({Key key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  int _paginaActual = 0;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(63.0),
        child: AppBar(
          title: Center(
            child: _paginaActual == 0
                ? Text(
                    'PILL PAL',
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  )
                : Text("Inventory Page"),
          ),
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
      ),
      body: FutureBuilder(
          future: getCronicalDiseases(),
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
                    return Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 3),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 175, 201, 184),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                snapshot.data[index]["name"],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 62, 100, 104),
                                  fontFamily: 'Heebo',
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '• ${snapshot.data[index]["description"]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: 'Heebo',
                                ),
                              ),
                            ),
                          ),
                          // Agrega otros elementos según sea necesario
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          })),
    );
  }
}
