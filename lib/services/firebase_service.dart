import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsers() async {
  List usuarios = [];

  CollectionReference usersReference = db.collection('users');

  QuerySnapshot queryUsers = await usersReference.get();

  for (var doc in queryUsers.docs) {
    usuarios.add(doc.data());
  }
  return usuarios;
}

Future<Map<String, dynamic>> getUsersByID(String id) async {
  // List usuarios = [];

  CollectionReference usersReference = db.collection('users');

  QuerySnapshot queryUsers = await usersReference.get();

  for (var doc in queryUsers.docs) {
    if (doc.data()['id'] == id) {
      return doc.data();
    }
  }
  return null;
}

Future<void> addUser(
    String name, String email, String password, String rol, String id) async {
  await db.collection('users').doc(id).set(
    {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'rol': rol,
    },
  );
}

Future<void> editUser(
    String name, String email, String password, String rol, String id) async {
  await db.collection('users').doc(id).update(
    {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'rol': rol,
    },
  );
}

Future<List> getInventary() async {
  List inventary = [];

  CollectionReference inventarioReference = db.collection('inventario');

  QuerySnapshot queryInventary = await inventarioReference.get();

  for (var doc in queryInventary.docs) {
    inventary.add(doc.data());
  }
  return inventary;
}

Future<Map<String, dynamic>> getInventaryByID(String id) async {
  // List usuarios = [];

  CollectionReference inventaryReference = db.collection('inventario');

  QuerySnapshot queryInventary = await inventaryReference.get();

  for (var doc in queryInventary.docs) {
    if (doc.data()['id'] == id) {
      return doc.data();
    }
  }
  return null;
}

Future<void> addInventary(String noinventario, String descripcion,
    String departamento, String imagen, String id) async {
  // CollectionReference inventaryReference =
  await db.collection('inventario').doc(id).set(
    {
      'id': id,
      'noinventario': noinventario,
      'descripcion': descripcion,
      'departamento': departamento,
      'imagen': imagen,
    },
  );
}

Future<void> editInventary(String noinventario, String descripcion,
    String departamento, String imagen, String id) async {
  // CollectionReference inventaryReference =
  await db.collection('inventario').doc(id).update(
    {
      'id': id,
      'noinventario': noinventario,
      'descripcion': descripcion,
      'departamento': departamento,
      'imagen': imagen,
    },
  );
}

Future<List> getMedicamentos() async {
  List Medicamentos = [];

  CollectionReference medicamentosReference = db.collection('medicamentos');

  QuerySnapshot querymedicamentos = await medicamentosReference.get();

  for (var doc in querymedicamentos.docs) {
    Medicamentos.add(doc.data());
  }
  return Medicamentos;
}

Future<Map<String, dynamic>> getMedicamentosByID(String id) async {
  CollectionReference medicamentosReference = db.collection('medicamentos');

  QuerySnapshot querymedicamentos = await medicamentosReference.get();

  for (var doc in querymedicamentos.docs) {
    if (doc.data()['id'] == id) {
      return doc.data();
    }
  }
  return null;
}

Future<void> addMedicamentos(
  String name,
  String dias_cumplidos,
  String dias_maximos,
  String horas_dosis,
  String hora_registrada,
  String id,
  /*String imagen*/
) async {
  await db.collection('medicamentos').doc(id).set(
    {
      'id': id,
      'name': name,
      'dias_cumplidos': dias_cumplidos,
      'dias_maximos': dias_maximos,
      'horas_dosis': horas_dosis,
      'hora_registrada': hora_registrada
      // 'imagen': imagen,
    },
  );
}

Future<void> editMedicamentos(
    String name,
    String dias_cumplidos,
    String dias_maximos,
    String horas_dosis,
    String hora_registrada,
    String id) async {
  await db.collection('medicamentos').doc(id).update(
    {
      'id': id,
      'name': name,
      'dias_cumplidos': dias_cumplidos,
      'dias_maximos': dias_maximos,
      'horas_dosis': horas_dosis,
      'hora_registrada': hora_registrada
    },
    // SetOptions(merge: true),
  );
}

Future<List> getCronicalDiseases() async {
  List Medicamentos = [];

  CollectionReference CronicalDiseasesReference =
      db.collection('enfermedad_cronica');

  QuerySnapshot queryCronicalDiseases = await CronicalDiseasesReference.get();

  for (var doc in queryCronicalDiseases.docs) {
    Medicamentos.add(doc.data());
  }
  return Medicamentos;
}

Future<Map<String, dynamic>> getCronicalDiseasesByID(String id) async {
  CollectionReference CronicalDiseasesReference =
      db.collection('enfermedad_cronica');

  QuerySnapshot queryCronicalDiseases = await CronicalDiseasesReference.get();

  for (var doc in queryCronicalDiseases.docs) {
    if (doc.data()['id'] == id) {
      return doc.data();
    }
  }
  return null;
}

Future<void> addCronicalDiseases(
  String name,
  String description,
  String id,
) async {
  await db.collection('enfermedad_cronica').doc(id).set(
    {
      'id': id,
      'name': name,
      'description': description,
    },
  );
}

Future<void> editCronicalDiseases(
  String name,
  String description,
  String id,
) async {
  await db.collection('medicamentos').doc(id).update(
    {
      'id': id,
      'name': name,
      'description': description,
    },
  );
}
