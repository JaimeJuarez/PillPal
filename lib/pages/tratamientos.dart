// ignore: unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_medicine.dart';
// import 'package:flutter_application_1/pages/edit_user.dart';
import 'package:flutter_application_1/pages/inventary_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/register_medicine.dart';
// import 'package:flutter_application_1/pages/register_user.dart';
import 'package:flutter_application_1/services/firebase_service.dart';
// import 'package:prueba/pages/inventory_page.dart';

class Tratamientos extends StatefulWidget {
  static String id = "tratamientos";

  const Tratamientos({Key key}) : super(key: key);

  @override
  State<Tratamientos> createState() => _TratamientosState();
}

class _TratamientosState extends State<Tratamientos> {
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
              ? const Text('Tratamientos')
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
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data[index]["name"]),
                        subtitle: Text(
                            '${snapshot.data[index]["dias_cumplidos"]} / ${snapshot.data[index]["dias_maximos"]} Dias Cumplidos' +
                                " " +
                                '\n (Dosis cada ${snapshot.data[index]["horas_dosis"]} Horas)'),
                        leading: const Icon(Icons.medication_sharp),
                        trailing: PopupMenuButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            itemBuilder: ((context) => [
                                  PopupMenuItem(
                                      child: ListTile(
                                    leading: const Icon(Icons.delete),
                                    title: const Text('Eliminar',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            fontFamily: 'Hoobie')),
                                    onTap: () {
                                      db
                                          .collection('medicamentos')
                                          .doc(snapshot.data[index]["id"])
                                          .get()
                                          .then((doc) {
                                        if (doc.exists) {
                                          doc.reference.delete();
                                          setState(() {});
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                                  )),
                                  PopupMenuItem(
                                      child: ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Editar',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            fontFamily: 'Hoobie')),
                                    onTap: () async {
                                      // snapshot.data[index]["id"];
                                      // await Navigator.pushNamed(
                                      //     context, EditUser.id);
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditMedicine(
                                                      medicineID: snapshot
                                                          .data[index]["id"])));
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                  )),
                                ])),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, RegisterMedicine.id);
          setState(() {});
        },
        backgroundColor: Color.fromARGB(255, 62, 100, 104),
        child: const Icon(Icons.add),
      ),
    );
  }
}
